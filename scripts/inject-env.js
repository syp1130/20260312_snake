const fs = require('fs');
const path = require('path');

const placeholder = '__INJECT_GAME_PASSWORD__';
const password = process.env.GAME_PASSWORD || '3082';
const filePath = path.join(__dirname, '..', 'public', 'index.html');

let html = fs.readFileSync(filePath, 'utf8');
if (!html.includes(placeholder)) {
  console.warn('inject-env: placeholder not found, skip');
  process.exit(0);
}
html = html.split(placeholder).join(password);
fs.writeFileSync(filePath, html);
console.log('inject-env: GAME_PASSWORD injected');
