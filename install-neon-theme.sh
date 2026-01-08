#!/bin/bash
set -e

PTERO="/var/www/pterodactyl"
THEME="$PTERO/public/themes/neon.css"
INDEX="$PTERO/resources/views/index.blade.php"

echo "==> Installing Neon Black Theme (VITE SAFE)"

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

if ! grep -q "themes/neon.css" "$INDEX"; then
  sed -i '/<\/head>/i <link rel="stylesheet" href="/themes/neon.css">' "$INDEX"
fi

php artisan view:clear
php artisan optimize:clear

echo "✅ Neon Theme Installed (Vite Panel)"
