# dpx_biz_documentation - instructions_for_claude
**v1.6**

## project_overview
This is an interactive web reference for the **dpx_biz** capacitive touch PCB business card by **dubpixel**.

## files_in_project
- `dpx-interactive-v{X.X}.html` - main interactive page with hover tooltips over PCB image
- `config-reference-v{X.X}.html` - full config.txt syntax reference
- `pcb-photo.png` - PCB render image
- `logo.png` - dubpixel logo

## versioning
- always include version in filename: `dpx-interactive-v1.6.html`
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

## hotspot_position_data (percentages for CSS positioning)

image: `pcb-photo.png` (1152 x 808 pixels)
formula: left% = px/1152*100, top% = px/808*100

### pad_coordinates (x.1 - x.10 only)

| Pad | Pixels (L,T,W,H) | Percent (L,T,W,H) | Shape |
|-----|------------------|-------------------|-------|
| x.1 | 17, 17, 128, 253 | 1.48, 2.1, 11.1, 31.3 | arrow |
| x.2 | 173, 33, 150, 150 | 15, 4.1, 13, 18.6 | circle |
| x.3 | 322, 17, 156, 156 | 28, 2.1, 13.5, 19.3 | circle |
| x.4 | 485, 55, 120, 120 | 42.1, 6.8, 10.4, 14.9 | circle |
| x.5 | 587, 227, 106, 106 | 51, 28.1, 9.2, 13.1 | circle |
| x.6 | 17, 312, 186, 186 | 1.48, 38.6, 16.1, 23 | circle |
| x.7 | 202, 197, 186, 186 | 17.5, 24.4, 16.1, 23 | circle |
| x.8 | 380, 260, 160, 160 | 33, 32.2, 13.9, 19.8 | circle |
| x.9 | 297, 462, 206, 206 | 25.8, 57.2, 17.9, 25.5 | circle |
| x.10 | 587, 357, 96, 96 | 51, 44.2, 8.3, 11.9 | circle |

### hardware_elements

**IMPORTANT: Button silkscreen labels are SWAPPED from actual function!**

| Element | Silkscreen | Actual Function | Left% | Top% | Width% | Height% |
|---------|------------|-----------------|-------|------|--------|---------|
| SW1 | "boot." | RESET (resets device) | 83.3 | 46.4 | 4.8 | 6.8 |
| SW2 | "reset." | BOOT (bootloader on power-up) | 55.1 | 1 | 6.1 | 6.8 |
| D1 | "d1." | Status LED (white heartbeat) | 85.5 | 71.8 | 4.8 | 5.6 |
| USB | "USB1" | USB-C port | 87.2 | 0 | 12.6 | 8.7 |
| midi? | "midi?" | Mode jumper (GPIO 20) | 76.4 | 60 | 5.6 | 5.6 |
| QR | "hack me!" | Links to docs | 57.3 | 66.2 | 14.3 | 22.9 |

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
