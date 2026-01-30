# dpx_biz_documentation - instructions_for_claude
**v1.9**

## project_overview
This is an interactive web reference for the **dpx_biz** capacitive touch PCB business card by **dubpixel**.

## files_in_project
- `dpx-interactive-v{X.X}.html` - main interactive page with hover tooltips over PCB image
- `config-reference-v{X.X}.html` - full config.txt syntax reference
- `pcb-photo.png` - PCB render image
- `logo.png` - dubpixel logo

## versioning
- always include version in filename: `dpx-interactive-v1.9.html`
- always include version in footer of each page
- increment version for any changes

## style_guide
- all headers/titles use **lowercase with underscores**: `config_reference`, `parameter_pattern`, `boot_combos`
- this matches the dubpixel aesthetic

---

## CRITICAL: pad_mapping_reference

### firmware_arrays (from dpx_biz_frm.ino)
```cpp
const int touch_pins[] = {3, 2, 1, 4, 9, 7, 6, 5, 10, 11, 18, 19};
const int led_lookup[] = {0, 1, 2, 3, 4, 9, 8, 7, 6, 5};  // Only 10 entries - pads 0-9 have LEDs
```

### complete_pad_mapping_table

**IMPORTANT: Default functions are for disguise d3 designer. DO NOT reference DaVinci Resolve - it has NOTHING to do with this project.**

| PCB Label | Config Key | GPIO | LED | Default HID | Default MIDI | Function (d3 designer) |
|-----------|------------|------|-----|-------------|--------------|------------------------|
| x.1 | pad_0_* | 3 | LED 0 | ctrl+alt+arrow_up | Note 60 | Layer Up |
| x.2 | pad_1_* | 2 | LED 1 | alt+s | Note 61 | Split Section |
| x.3 | pad_2_* | 1 | LED 2 | alt+m | Note 62 | Merge Section |
| x.4 | pad_3_* | 4 | LED 3 | ctrl+alt+[ | Note 64 | Trim Container to Playhead |
| x.5 | pad_4_* | 9 | LED 4 | o | Note 65 | Move Playhead to End |
| x.6 | pad_5_* | 7 | LED 9 | period (.) | Note 66 | Next Section |
| x.7 | pad_6_* | 6 | LED 8 | comma (,) | Note 67 | Previous Section |
| x.8 | pad_7_* | 5 | LED 7 | alt+t | Note 69 | Repeat Prev Tag |
| x.9 | pad_8_* | 10 | LED 6 | space | Note 70 | Play Section |
| x.10 | pad_9_* | 11 | LED 5 | ctrl+alt+arrow_down | Note 69 | Layer Down |
| x.11 (QR) | pad_10_* | 18 | — | esc | Note 70 | — |
| x.12 (logo) | pad_11_* | 19 | — | tab | Note 48 | — |

### key_points
- **10 pads have LEDs** (x.1 through x.10 = pad_0 through pad_9)
- **2 pads have NO LEDs** (x.11 and x.12 = pad_10 and pad_11, near QR code and logo)
- PCB silkscreen uses **x.1 through x.12** (1-indexed)
- config file uses **pad_0 through pad_11** (0-indexed)
- LED numbers are **NOT sequential** with pad numbers (see led_lookup array)

---

## layout_notes

**v1.9 layout**: Image on top (full width, max 900px), cards in 4-column grid below.
- Responsive: 2 columns on tablet, 1 column on mobile
- boot_combos card spans 2 columns

## hotspot_position_data

**v1.9 uses SVG overlay approach for proper scaling**

The SVG has `viewBox="0 0 1152 808"` matching the image dimensions exactly.
This means hotspot coordinates are in **pixels** matching the source image.
The SVG scales proportionally with the image, so positions stay aligned.

### pad_coordinates (x.1 - x.10) - SVG pixel values

| Pad | Shape | Center/Position | Size |
|-----|-------|-----------------|------|
| x.1 | rect | x=17 y=17 | w=128 h=253 |
| x.2 | circle | cx=248 cy=108 | r=75 |
| x.3 | circle | cx=400 cy=95 | r=78 |
| x.4 | circle | cx=545 cy=115 | r=60 |
| x.5 | circle | cx=640 cy=280 | r=53 |
| x.6 | circle | cx=110 cy=405 | r=93 |
| x.7 | circle | cx=295 cy=290 | r=93 |
| x.8 | circle | cx=460 cy=340 | r=80 |
| x.9 | circle | cx=400 cy=565 | r=103 |
| x.10 | circle | cx=635 cy=405 | r=48 |

### hardware_elements

**IMPORTANT: Button silkscreen labels are SWAPPED from actual function!**

| Element | Silkscreen | Actual Function | Description |
|---------|------------|-----------------|-------------|
| SW1 | boot. | REBOOT | push to reboot the device |
| SW2 | reset. | BOOTLOADER | hold during reboot → bootloader |
| D1 | d1. | Status LED | white heartbeat = running |

---

## tooltip_content_format

each pad tooltip should show:
```
header: [Pad x.#]                    [LED # or "No LED"]
config: pad_#_*
─────────────────
HID:    [default key]
MIDI:   Note [number]
GPIO:   [pin number]
Func:   [d3 designer function, if any]
```

---

## boot_combos_reference

### boot_sequence_timing

From firmware analysis (dpx_biz_frm.ino):

1. **white swipe** (~500ms) — LEDs 0→9 light sequentially (50ms each), then all off
2. **3 D1 chirps** (~600ms) — status LED flashes 3× (100ms on, 100ms off)
3. **1 second settle** — touch sensors stabilize
4. **boot mode detection** (~1.5s) — 500ms grace + 1 second detection window
5. **confirmation** — if combo detected: color changes + blink
6. **heartbeat starts** — D1 pulses = normal operation

**WHEN TO HOLD PADS:**
- After white swipe completes
- After 3 D1 chirps
- **START HOLDING** during settle period (don't wait for prompt)
- Keep holding until you see confirmation blink (~1.5 seconds)
- Release after confirmation

### boot_combo_colors

| Pads | Mode | Detection → Confirmation |
|------|------|--------------------------|
| 1 + 2 | CONFIG | BLUE → GREEN (blink) |
| 3 + 4 | RESET | RED → WHITE (blink) |
| 7 + 8 | FORCE MIDI | YELLOW → RED (blink) |

hold ~1 second during boot.

---

## styling_notes
- dark theme: #0a0a0a background
- gold accent: #c9a227
- blue (HID): #4a9eff
- green (MIDI/LED): #4aff7a
- red: #ff4a4a
- yellow: #ffdd4a
- font: JetBrains Mono for code, Space Grotesk for body

---

## source_files (from user)
- `dpx_biz_frm.ino` - complete firmware
- `default_config.h` - default config.txt content with function descriptions
- `dpx_biz_onesheet_ref.md` - original reference document

---

## footer_format
```
[dubpixel logo]
making strange things daily
v{X.X}
```
