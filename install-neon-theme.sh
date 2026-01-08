#!/bin/bash
set -e

echo ">>> EKIK NEON BRUTAL THEME INSTALLER"

PANEL="/var/www/pterodactyl"
ASSETS="$PANEL/public/assets"

if [ ! -d "$ASSETS" ]; then
  echo "❌ Assets folder not found"
  exit 1
fi

echo "→ Downloading background images"
curl -fsSL https://files.catbox.moe/9yuwp3.jpg -o "$ASSETS/ekik-bg1.jpg"
curl -fsSL https://files.catbox.moe/cjg3lg.jpg -o "$ASSETS/ekik-bg2.jpg"

echo "→ Creating embedded neon CSS"
cat > "$ASSETS/ekik-neon.css" <<'EOF'
body {
  background:
    linear-gradient(rgba(0,0,0,.85), rgba(0,0,0,.85)),
    url("/assets/ekik-bg1.jpg"),
    url("/assets/ekik-bg2.jpg");
  background-size: cover;
  background-position: center;
  background-attachment: fixed;
}

* {
  --primary: #00ffcc;
  --accent: #00ffaa;
}

a, button, .btn {
  color: #00ffcc !important;
  text-shadow: 0 0 6px #00ffcc;
}

.card, .box, .panel {
  background: rgba(0,0,0,.75) !important;
  border: 1px solid #00ffcc;
  box-shadow: 0 0 20px #00ffcc55;
}

input, select, textarea {
  background: #050505 !important;
  color: #00ffcc !important;
  border: 1px solid #00ffcc;
}
EOF

echo "→ Injecting CSS loader into all JS bundles"
for f in "$ASSETS"/*.js; do
  if ! grep -q "ekik-neon.css" "$f"; then
    sed -i '1s|^|var _ekik=document.createElement("link");_ekik.rel="stylesheet";_ekik.href="/assets/ekik-neon.css";document.head.appendChild(_ekik);\n|' "$f"
  fi
done

echo "✅ DONE"
echo "⚠️ HARD REFRESH BROWSER (CTRL+F5)"
