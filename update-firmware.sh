#!/bin/bash

# Fetch latest Aura firmware release and update manifests

echo "🔄 Fetching latest Aura firmware release..."

# Get latest release info
curl -s https://api.github.com/repos/OakesekAo/Aura/releases/latest > latest.json
TAG=$(jq -r .tag_name latest.json)
echo "📦 Latest release: $TAG"

# Create firmware directory if it doesn't exist
mkdir -p firmware

echo "⬇️ Downloading firmware files..."

# Download standard firmware files
echo "  📱 Standard firmware files..."
wget -q -O firmware/aura-firmware-24-ili9341.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-firmware-24-ili9341.bin"
wget -q -O firmware/aura-firmware-24-st7789.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-firmware-24-st7789.bin"
wget -q -O firmware/aura-firmware-28-ili9341.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-firmware-28-ili9341.bin"

# Download component files
echo "  🧩 Component files..."
wget -q -O firmware/aura-bootloader-24-ili9341.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-bootloader-24-ili9341.bin"
wget -q -O firmware/aura-partitions-24-ili9341.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-partitions-24-ili9341.bin"
wget -q -O firmware/aura-boot-app0-24-ili9341.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-boot-app0-24-ili9341.bin"
wget -q -O firmware/aura-app-24-ili9341.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-app-24-ili9341.bin"

wget -q -O firmware/aura-bootloader-24-st7789.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-bootloader-24-st7789.bin"
wget -q -O firmware/aura-partitions-24-st7789.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-partitions-24-st7789.bin"
wget -q -O firmware/aura-boot-app0-24-st7789.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-boot-app0-24-st7789.bin"
wget -q -O firmware/aura-app-24-st7789.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-app-24-st7789.bin"

wget -q -O firmware/aura-bootloader-28-ili9341.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-bootloader-28-ili9341.bin"
wget -q -O firmware/aura-partitions-28-ili9341.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-partitions-28-ili9341.bin"
wget -q -O firmware/aura-boot-app0-28-ili9341.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-boot-app0-28-ili9341.bin"
wget -q -O firmware/aura-app-28-ili9341.bin "https://github.com/OakesekAo/Aura/releases/download/$TAG/aura-app-28-ili9341.bin"

echo "📝 Updating manifest files with version $TAG..."

# Update manifests with new version
mkdir -p manifests

# Standard manifests
cat > manifests/24_ILI9341.json << EOF
{
  "name": "Aura (2.4\" ILI9341)",
  "version": "$TAG",
  "builds": [
    {
      "chipFamily": "ESP32",
      "parts": [
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-firmware-24-ili9341.bin", "offset": 0 }
      ]
    }
  ]
}
EOF

cat > manifests/24_ST7789.json << EOF
{
  "name": "Aura (2.4\" ST7789)",
  "version": "$TAG",
  "builds": [
    {
      "chipFamily": "ESP32",
      "parts": [
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-firmware-24-st7789.bin", "offset": 0 }
      ]
    }
  ]
}
EOF

cat > manifests/28_ILI9341.json << EOF
{
  "name": "Aura (2.8\" ILI9341)",
  "version": "$TAG",
  "builds": [
    {
      "chipFamily": "ESP32",
      "parts": [
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-firmware-28-ili9341.bin", "offset": 0 }
      ]
    }
  ]
}
EOF

# Component manifests
cat > manifests/24_ILI9341_components.json << EOF
{
  "name": "Aura (2.4\" ILI9341 - Fix Chip ID)",
  "version": "$TAG",
  "builds": [
    {
      "chipFamily": "ESP32",
      "parts": [
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-bootloader-24-ili9341.bin", "offset": 4096 },
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-partitions-24-ili9341.bin", "offset": 32768 },
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-boot-app0-24-ili9341.bin", "offset": 57344 },
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-app-24-ili9341.bin", "offset": 65536 }
      ]
    }
  ]
}
EOF

cat > manifests/24_ST7789_components.json << EOF
{
  "name": "Aura (2.4\" ST7789 - Fix Chip ID)",
  "version": "$TAG",
  "builds": [
    {
      "chipFamily": "ESP32",
      "parts": [
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-bootloader-24-st7789.bin", "offset": 4096 },
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-partitions-24-st7789.bin", "offset": 32768 },
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-boot-app0-24-st7789.bin", "offset": 57344 },
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-app-24-st7789.bin", "offset": 65536 }
      ]
    }
  ]
}
EOF

cat > manifests/28_ILI9341_components.json << EOF
{
  "name": "Aura (2.8\" ILI9341 - Fix Chip ID)",
  "version": "$TAG",
  "builds": [
    {
      "chipFamily": "ESP32",
      "parts": [
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-bootloader-28-ili9341.bin", "offset": 4096 },
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-partitions-28-ili9341.bin", "offset": 32768 },
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-boot-app0-28-ili9341.bin", "offset": 57344 },
        { "path": "https://oakesekao.github.io/aura-installer/firmware/aura-app-28-ili9341.bin", "offset": 65536 }
      ]
    }
  ]
}
EOF

echo "✅ Updated to firmware version: $TAG"
echo "📊 Downloaded $(ls firmware/*.bin | wc -l) firmware files"
echo "📄 Updated 6 manifest files"
echo ""
echo "🚀 Ready to commit and deploy!"
echo ""
echo "Next steps:"
echo "  git add firmware/ manifests/ latest.json"
echo "  git commit -m \"Update to Aura firmware $TAG\""
echo "  git push origin main"
