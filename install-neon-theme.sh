#!/bin/bash
set -e

echo "==> Installing Neon Black Theme (Ultra Safe)"

PTERO="/var/www/pterodactyl"

LAYOUT=""

# detect all known layout paths
if [ -f "$PTERO/resources/views/components/layout.blade.php" ]; then
    LAYOUT="$PTERO/resources/views/components/layout.blade.php"
elif [ -f "$PTERO/resources/views/layouts/app.blade.php" ]; then
    LAYOUT="$PTERO/resources/views/layouts/app.blade.php"
elif [ -f "$PTERO/resources/views/templates/app.blade.php" ]; then
    LAYOUT="$PTERO/resources/views/templates/app.blade.php"
else
    echo "❌ Layout file not found (unsupported panel version)"
    exit 1
fi

echo "✔ Layout found: $LAYOUT"

# create css dir
mkdir -p "$PTERO/public/themes"

# write css
cat > "$PTERO/public/themes/neon-black.css" <<'EOF'
:root {
  --neon: #00ffff;
}

body {
  background: #050505 !important;
}

.sidebar, header {
  background: #000 !important;
  box-shadow: 0 0 15px var(--neon);
}

a, .text-primary {
  color: var(--neon) !important;
}

button, .btn-primary {
  background: linear-gradient(90deg,#00ffff,#00ff99) !important;
  border: none !important;
}

.login-wrapper {
  background: url("https://files.catbox.moe/9yuwp3.jpg") center/cover no-repeat;
}

.dashboard {
  background: url("https://files.catbox.moe/cjg3lg.jpg") center/cover no-repeat;
}
EOF

# inject css safely
if ! grep -q "neon-black.css" "$LAYOUT"; then
    sed -i "/<\/head>/i <link rel=\"stylesheet\" href=\"/themes/neon-black.css\">" "$LAYOUT"
    echo "✔ CSS injected"
else
    echo "ℹ Theme already installed"
fi

php artisan view:clear
php artisan cache:clear

echo "✅ Neon Black Theme installed successfully"

