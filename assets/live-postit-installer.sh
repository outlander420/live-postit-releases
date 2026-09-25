#!/usr/bin/env bash
set -euo pipefail

APPNAME="Live PostIt"
APPIMAGE="live-postit-0.3.0.AppImage"
VERSION="0.3.0"
DOWNLOAD_URL="https://outlander420.github.io/live-postit-releases/assets/$APPIMAGE"
INSTALL_DIR="$HOME/.local/share/LivePostIt"
BIN="$HOME/.local/bin"
DESKTOP="$HOME/.local/share/applications/live-postit.desktop"
ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"

echo "========================================"
echo "  Live PostIt Installer v$VERSION"
echo "========================================"
echo ""

# Check if already installed
if [[ -x "$INSTALL_DIR/$APPIMAGE" ]]; then
  echo "✓ $APPNAME is already installed at:"
  echo "  $INSTALL_DIR/$APPIMAGE"
  echo ""
  echo "To reinstall, remove it first and run this script again."
  echo ""
  exit 0
fi

# Create directories
mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$ICON_DIR"

echo "Downloading $APPIMAGE..."
if command -v wget &>/dev/null; then
  wget -q --show-progress -O "$INSTALL_DIR/$APPIMAGE" "$DOWNLOAD_URL"
elif command -v curl &>/dev/null; then
  curl -fSL --progress-bar -o "$INSTALL_DIR/$APPIMAGE" "$DOWNLOAD_URL"
else
  echo "Error: wget or curl required."
  exit 1
fi

chmod +x "$INSTALL_DIR/$APPIMAGE"
echo "Downloaded."
echo ""

# Wrapper script
cat > "$BIN/live-postit" <<WRAPPER
#!/bin/bash
exec "$INSTALL_DIR/$APPIMAGE" --no-sandbox --disable-gpu "\$@"
WRAPPER
chmod +x "$BIN/live-postit"

# Desktop file
cat > "$DESKTOP" <<EOF
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

# Try to download icon from the releases repo
ICON_URL="https://outlander420.github.io/live-postit-releases/assets/icon.png"
if curl -sfL --max-time 10 -o "$ICON_DIR/live-postit.png" "$ICON_URL" 2>/dev/null; then
  echo "Icon installed."
else
  echo "Icon: using system default."
fi

echo ""
echo "========================================"
echo "  Installation complete!"
echo "========================================"
echo ""
echo "  AppImage: $INSTALL_DIR/$APPIMAGE"
echo "  Wrapper:  $BIN/live-postit"
echo "  Desktop:  $DESKTOP"
echo ""
echo "You can now launch Live PostIt from your"
echo "applications menu."
echo ""
echo "If it doesn't start, run:"
echo "  $INSTALL_DIR/$APPIMAGE --no-sandbox --disable-gpu"
