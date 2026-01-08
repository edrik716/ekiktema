#!/bin/bash
set -e

echo "==> Installing Neon Black Theme (Safe Mode)"

PTERO_PATH="/var/www/pterodactyl"

# auto-detect layout file
if [ -f "$PTERO_PATH/resources/views/templates/app.blade.php" ]; then
    LAYOUT_FILE="$PTERO_PATH/resources/views/templates/app.blade.php"
elif [ -f "$PTERO_PATH/resources/views/layouts/app.blade.php" ]; then
    LAYOUT_FILE="$PTERO_PATH/resources/views/layouts/app.blade.php"
else
    echo "❌ Layout file not found"
    exit 1
fi

echo "✔ Layout file found: $LAYOUT_FILE"

# create css
mkdir -p "$PTERO_PATH/resources/css"

cat > "$PTERO_PATH/resources/css/custom-neon-theme.css" <<'EOF'
body {
    background: #050505 !important;
}
.sidebar {
    background: #000 !important;
    box-shadow: 0 0 15px #00ffff;
}
a, .text-primary {
    color: #00ffff !important;
}
.btn-primary {
    background: linear-gradient(90deg,#00ffff,#00ff99);
    border: none;
}
.login-container {
    background: url("https://files.catbox.moe/9yuwp3.jpg") center/cover no-repeat;
}
.dashboard-container {
    background: url("https://files.catbox.moe/cjg3lg.jpg") center/cover no-repeat;
}
EOF

# inject css if not exists
if ! grep -q "custom-neon-theme.css" "$LAYOUT_FILE"; then
    sed -i "/<\/head>/i <link rel=\"stylesheet\" href=\"{{ asset('resources/css/custom-neon-theme.css') }}\">" "$LAYOUT_FILE"
    echo "✔ CSS injected"
else
    echo "ℹ CSS already injected"
fi

php artisan view:clear
php artisan cache:clear

echo "✅ Neon theme installed successfully"
