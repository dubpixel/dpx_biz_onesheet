#!/bin/bash
set -e

SRC_DIR="src"
WEB_DIR="web"

echo "Deploying DPX BIZ ONESHEET..."

# Copy dpx-interactive.html to web/index.html
echo "Copying dpx-interactive.html → web/index.html"
cp "$SRC_DIR/dpx-interactive.html" "$WEB_DIR/index.html"

# Copy dpx-interactive-noSerial.html
echo "Copying dpx-interactive-noSerial.html → web/dpx-interactive-noSerial.html"
cp "$SRC_DIR/dpx-interactive-noSerial.html" "$WEB_DIR/dpx-interactive-noSerial.html"

# Copy config-reference.html
echo "Copying config-reference.html → web/config-reference.html"
cp "$SRC_DIR/config-reference.html" "$WEB_DIR/config-reference.html"

# Copy dpx_biz_synth.html
echo "Copying dpx_biz_synth.html → web/dpx_biz_synth.html"
cp "$SRC_DIR/dpx_biz_synth.html" "$WEB_DIR/dpx_biz_synth.html"

# Copy dpx_biz_hid.html if it exists
if [ -f "$SRC_DIR/dpx_biz_hid.html" ]; then
  echo "Copying dpx_biz_hid.html → web/dpx_biz_hid.html"
  cp "$SRC_DIR/dpx_biz_hid.html" "$WEB_DIR/dpx_biz_hid.html"
fi

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

# Copy samples folder if it exists
if [ -d "$SRC_DIR/samples" ]; then
  echo "Copying samples folder → web/samples/"
  mkdir -p "$WEB_DIR/samples"
  cp -r "$SRC_DIR/samples/"* "$WEB_DIR/samples/"
fi

echo "✓ Deploy complete"
