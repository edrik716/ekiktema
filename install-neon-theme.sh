#!/bin/bash
set -e

PTERO="/var/www/pterodactyl"
THEME="$PTERO/public/themes/neon.css"

LAYOUT1="$PTERO/resources/views/layouts/app.blade.php"
LAYOUT2="$PTERO/resources/views/index.blade.php"

if [ -f "$LAYOUT1" ]; then
  TARGET="$LAYOUT1"
elif [ -f "$LAYOUT2" ]; then
  TARGET="$LAYOUT2"
else
  echo "❌ Layout file not found (unsupported panel version)"
  exit 1
fi

echo "==> Installing Neon Black Theme (VITE REAL SAFE)"
echo "==> Using layout: $TARGET"

mkdir -p "$PTERO/public/themes"

cat > "$THEME" <<'EOF'
/* ===== Neon Black Theme ===== */
:root {
  --neon:#00ffff;
}

body {
  background:#050505!important;
}

header,nav,aside {
  background:#000!important;
  box-shadow:0 0 12px var(--neon);
}

a { color:var(--neon)!important; }

button {
  background:linear-gradient(90deg,#00ffff,#00ff99)!important;
  color:#000!important;
}

#app {
  background:url("https://files.catbox.moe/9yuwp3.jpg") center/cover no-repeat fixed;
}

.dashboard-wrapper {
  background:url("https://files.catbox.moe/cjg3lg.jpg") center/cover no-repeat;
}
/* ===== End ===== */
EOF

if ! grep -q "themes/neon.css" "$TARGET"; then
  sed -i '/<\/head>/i <link rel="stylesheet" href="/themes/neon.css">' "$TARGET"
fi

php artisan view:clear
php artisan optimize:clear

echo "✅ Neon Theme Installed SUCCESS"
