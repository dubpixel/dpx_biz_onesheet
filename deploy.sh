#!/bin/bash
set -e

SRC_DIR="src"
WEB_DIR="web"

echo "Deploying DPX BIZ ONESHEET..."

# Copy dpx-interactive.html to web/index.html
echo "Copying dpx-interactive.html → web/index.html"
cp "$SRC_DIR/dpx-interactive.html" "$WEB_DIR/index.html"

# Copy config-reference.html
echo "Copying config-reference.html → web/config-reference.html"
cp "$SRC_DIR/config-reference.html" "$WEB_DIR/config-reference.html"

# Copy hotspots.json only if changed
if [ -f "$WEB_DIR/hotspots.json" ]; then
  if cmp -s "$SRC_DIR/hotspots.json" "$WEB_DIR/hotspots.json"; then
    echo "hotspots.json unchanged, skipping"
  else
    echo "hotspots.json changed, copying"
    cp "$SRC_DIR/hotspots.json" "$WEB_DIR/hotspots.json"
  fi
else
  echo "Copying hotspots.json (first time)"
  cp "$SRC_DIR/hotspots.json" "$WEB_DIR/hotspots.json"
fi

echo "✓ Deploy complete"
