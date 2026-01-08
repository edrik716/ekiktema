#!/bin/bash
set -e

echo "==> Installing Neon Black Theme (Ptero Inertia Safe)"

PTERO="/var/www/pterodactyl"
CSS="$PTERO/resources/css/app.css"

if [ ! -f "$CSS" ]; then
  echo "❌ app.css not found"
  exit 1
fi

echo "✔ Found app.css"

cat >> "$CSS" <<'EOF'

/* ===== Neon Black Theme ===== */
:root {
  --neon: #00ffff;
}

body {
  background-color: #050505 !important;
}

header, nav, aside {
  background: #000 !important;
  box-shadow: 0 0 15px var(--neon);
}

a {
  color: var(--neon) !important;
}

button, .bg-primary {
  background: linear-gradient(90deg,#00ffff,#00ff99) !important;
  border: none !important;
}

.login-container {
  background: url("https://files.catbox.moe/9yuwp3.jpg") center/cover no-repeat;
}

.dashboard {
  background: url("https://files.catbox.moe/cjg3lg.jpg") center/cover no-repeat;
}
/* ===== End Theme ===== */

EOF

cd "$PTERO"
php artisan view:clear
php artisan optimize:clear

echo "✅ Neon theme installed (CSS only, safe)"
