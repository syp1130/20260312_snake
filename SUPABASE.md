# 스네이크 게임 - Supabase 스코어 저장 설정

게임 스코어를 Supabase DB에 저장하려면 아래 순서대로 진행하세요.

## 1. Supabase 프로젝트 만들기

1. [supabase.com](https://supabase.com) 로그인 후 **New project** 생성
2. 프로젝트가 준비되면 **Settings → API** 에서 확인:
   - **Project URL** (예: `https://abcdefgh.supabase.co`)
   - **anon public** 키 (공개용 키)

> ⚠️ 적어주신 `https://20260312-snake-git-master-...vercel.app` 는 **Vercel 배포 주소**입니다.  
> 스코어를 DB에 넣으려면 **Supabase**에서 새 프로젝트를 만든 뒤, 아래에서 그 프로젝트의 URL과 키를 사용해야 합니다.

## 2. DB 테이블·함수 생성

1. Supabase 대시보드 → **SQL Editor**
2. 이 폴더의 **`supabase-setup.sql`** 내용을 통째로 붙여넣기
3. **Run** 실행

이렇게 하면 `scores` 테이블과 랭킹 조회 함수 `get_ranking()` 이 생성됩니다.

## 3. 게임에 URL·키 넣기

`public/index.html` (또는 사용하는 HTML 파일) 상단의 다음 부분을 수정하세요:

```javascript
const SUPABASE_URL = 'https://YOUR_PROJECT_REF.supabase.co';  // ← 여기에 Project URL
const SUPABASE_ANON_KEY = 'YOUR_ANON_KEY';                     // ← 여기에 anon public 키
```

- `YOUR_PROJECT_REF` 자리에는 Supabase **Project URL**의 프로젝트 ID만 넣지 말고, **전체 URL**을 넣습니다.  
  예: `https://abcdefghijk.supabase.co`
- `YOUR_ANON_KEY` 자리에는 **anon public** 키 전체를 붙여넣습니다.

저장 후 Vercel에 다시 배포하면, 같은 프로젝트를 쓰는 모든 사용자의 스코어가 Supabase에 쌓이고, 랭킹도 DB 기준으로 표시됩니다.

## 동작 요약

- **기록하기** 클릭 시 → Supabase `scores` 테이블에 `initials`, `score` 행이 추가됩니다.
- **랭킹** 표시 시 → `get_ranking()` 으로 “같은 이니셜은 최고 점수만” 상위 10명을 가져옵니다.
- `SUPABASE_URL` / `SUPABASE_ANON_KEY` 를 넣지 않으면 기존처럼 **localStorage**만 사용합니다.
