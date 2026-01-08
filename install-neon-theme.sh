#!/bin/bash
set -e

PANEL_DIR="/var/www/pterodactyl"
CSS_DIR="$PANEL_DIR/resources/css"
CSS_FILE="$CSS_DIR/custom-neon-theme.css"
LAYOUT_FILE="$PANEL_DIR/resources/views/layouts/app.blade.php"

echo "==> Installing Neon Black Theme (Safe Mode)"

# Cek panel
if [ ! -d "$PANEL_DIR" ]; then
  echo "❌ Pterodactyl panel not found"
  exit 1
fi

# Buat folder css kalau belum ada
mkdir -p "$CSS_DIR"

# Tulis CSS
cat > "$CSS_FILE" << 'EOF'
body { background:#0b0b0b!important; }

.auth-background {
  background:
  linear-gradient(rgba(0,0,0,.75),rgba(0,0,0,.75)),
  url("https://files.catbox.moe/9yuwp3.jpg")
  center/cover no-repeat!important;
}

#app {
  background:
  linear-gradient(rgba(0,0,0,.85),rgba(0,0,0,.85)),
  url("https://files.catbox.moe/cjg3lg.jpg")
  center/cover fixed no-repeat;
}

.bg-white,.bg-gray-50,.bg-gray-100 {
  background:#111!important;
  border:1px solid rgba(0,255,240,.15);
  box-shadow:0 0 20px rgba(0,255,240,.05);
}

.text-gray-700,.text-gray-600,.text-gray-800 {
  color:#e5e5e5!important;
}

button,.btn-primary {
  background:linear-gradient(135deg,#00fff0,#00c2ff)!important;
  color:#000!important;
  box-shadow:0 0 12px rgba(0,255,240,.6);
  border:none!important;
}

button:hover {
  box-shadow:0 0 20px rgba(0,255,240,.9);
}

a { color:#00fff0!important; }

input,select,textarea {
  background:#0f0f0f!important;
  color:#fff!important;
  border:1px solid rgba(0,255,240,.2)!important;
}
EOF

# Inject CSS ke layout kalau belum ada
if ! grep -q "custom-neon-theme.css" "$LAYOUT_FILE"; then
  sed -i '/<\/head>/i \<link rel="stylesheet" href="{{ asset('"'"'resources/css/custom-neon-theme.css'"'"') }}">'
 "$LAYOUT_FILE"
fi

# Clear cache
cd "$PANEL_DIR"
php artisan view:clear >/dev/null 2>&1 || true
php artisan config:clear >/dev/null 2>&1 || true

echo "✅ Neon theme installed successfully"
echo "ℹ️ Safe: no core files replaced"
