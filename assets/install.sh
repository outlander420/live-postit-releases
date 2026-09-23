#!/usr/bin/env bash
set -euo pipefail

APPNAME="Live PostIt"
APPIMAGE="live-postit-0.2.0.AppImage"
VERSION="0.2.0"

if [[ $EUID -eq 0 ]]; then
  INSTALL_DIR="/opt/LivePostIt"
  BIN="/usr/bin"
else
  INSTALL_DIR="$HOME/.local/share/LivePostIt"
  BIN="$HOME/.local/bin"
  mkdir -p "$BIN"
fi

INSTALLED="$INSTALL_DIR/$APPIMAGE"

echo "Installing $APPNAME v$VERSION..."
mkdir -p "$INSTALL_DIR"

cp "$APPIMAGE" "$INSTALLED"
chmod +x "$INSTALLED"

# Wrapper script with the flags baked in
cat > "$BIN/live-postit" <<WRAPPER
#!/bin/bash
exec "$INSTALLED" --no-sandbox --disable-gpu "\$@"
WRAPPER
chmod +x "$BIN/live-postit"

# Symlink as fallback
ln -sf "$INSTALLED" "$BIN/$APPNAME"

# Desktop file
mkdir -p "$HOME/.local/share/applications"
cat > "$HOME/.local/share/applications/live-postit.desktop" <<'EOF'
[Desktop Entry]
Name=Live PostIt
Comment=A desktop post-it wall for notes and ideas
Exec=live-postit
Icon=live-postit
Terminal=false
Type=Application
Categories=Utility;Productivity;
MimeType=text/plain;
StartupWMClass=live-postit

EOF

# Icon
if [[ -f "icon.png" ]]; then
  cp icon.png "$INSTALL_DIR/icon.png"
  mkdir -p "$HOME/.local/share/icons/hicolor/256x256/apps"
  cp icon.png "$HOME/.local/share/icons/hicolor/256x256/apps/live-postit.png"
fi

echo ""
echo "Done!"
echo "  AppImage: $INSTALLED"
echo "  Wrapper:  $BIN/live-postit"
echo "  Desktop:  $HOME/.local/share/applications/live-postit.desktop"
echo ""
echo "You can now launch Live PostIt from your applications menu."
