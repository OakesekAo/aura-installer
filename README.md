# Aura Installer

Web-based ESP32 firmware installer for Aura weather display boards.

**⚠️ IMPORTANT**: This installer currently uses **test firmware** (ESPHome demo) since the base Aura repository doesn't have releases yet. The installer mechanism works correctly, but won't install actual Aura firmware until the base repository publishes releases.

## Supported Variants

- **2.4" ILI9341** - 2.4 inch displays with ILI9341 driver
- **2.4" ST7789** - 2.4 inch displays with ST7789 driver  
- **2.8" ILI9341** - 2.8 inch displays with ILI9341 driver (most common)

## Usage

1. Visit the installer page at: **https://oakesekao.github.io/aura-installer/**
2. Select your display variant from the dropdown
3. Connect your ESP32 board via USB
4. Click "Install" and follow the prompts

## How It Works

The installer fetches firmware binaries directly from the [OakesekAo/Aura](https://github.com/OakesekAo/Aura) repository releases. This ensures you always get the latest firmware without the installer repo needing to host large binary files.

## File Structure

```
manifests/
  24_ILI9341.json      # Install manifest for 2.4" ILI9341
  24_ST7789.json       # Install manifest for 2.4" ST7789  
  28_ILI9341.json      # Install manifest for 2.8" ILI9341
img/
  aura.jpg            # Project image
index.html            # Main installer page
```

## Current Status (Test Mode)

The installer currently uses ESPHome demo firmware to test the installation process. Once the base Aura repository has proper releases, the manifests will be updated to fetch actual Aura firmware.

### Expected Production Firmware Sources

Each manifest will fetch binaries from the latest Aura release:

- `https://github.com/OakesekAo/Aura/releases/latest/download/bootloader-{variant}.bin`
- `https://github.com/OakesekAo/Aura/releases/latest/download/partitions-{variant}.bin`
- `https://github.com/OakesekAo/Aura/releases/latest/download/boot_app0-{variant}.bin`
- `https://github.com/OakesekAo/Aura/releases/latest/download/app-{variant}.bin`

Where `{variant}` is one of: `24_ILI9341`, `24_ST7789`, or `28_ILI9341`.

## Flash Layout

All variants use the standard ESP32 flash layout:

- `0x1000` (4096) - bootloader.bin
- `0x8000` (32768) - partitions.bin  
- `0xE000` (57344) - boot_app0.bin
- `0x10000` (65536) - app.bin

## Browser Requirements

- Google Chrome or Microsoft Edge (Web Serial API support)
- HTTPS connection (automatically provided by GitHub Pages)

## Development

The installer uses ESP Web Tools for browser-based firmware flashing. Each variant has its own manifest.json that references firmware files from the Aura repository releases.

To update the installer, simply modify the manifest files and commit to the main branch. GitHub Pages will automatically deploy the changes.
