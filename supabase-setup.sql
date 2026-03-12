-- 스네이크 게임 스코어 테이블 (Supabase SQL Editor에서 실행)

-- 1. 스코어 이력 테이블
CREATE TABLE IF NOT EXISTS public.scores (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  initials TEXT NOT NULL,
  score INTEGER NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. 랭킹 조회 함수 (같은 이니셜은 최고 점수만, 상위 10명)
CREATE OR REPLACE FUNCTION public.get_ranking()
RETURNS TABLE (initials TEXT, score INTEGER) AS $$
  SELECT t.initials, t.score
  FROM (
    SELECT DISTINCT ON (s.initials) s.initials, s.score
    FROM public.scores s
    ORDER BY s.initials, s.score DESC
  ) t
  ORDER BY t.score DESC
  LIMIT 10;
$$ LANGUAGE sql SECURITY DEFINER;

-- 3. 테이블 권한 (anon이 테이블에 접근할 수 있도록)
GRANT SELECT, INSERT ON public.scores TO anon;

-- 4. 익명 읽기/쓰기 허용 (RLS 정책)
ALTER TABLE public.scores ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow anonymous read" ON public.scores
  FOR SELECT USING (true);

CREATE POLICY "Allow anonymous insert" ON public.scores
  FOR INSERT WITH CHECK (true);

-- 5. 익명 사용자가 랭킹 함수 실행 가능
GRANT EXECUTE ON FUNCTION public.get_ranking() TO anon;
GRANT EXECUTE ON FUNCTION public.get_ranking() TO authenticated;
