# DPX Business Card - One-Sheet Reference Data

This document contains all functional data needed for a visual design agent to create a polished quick-reference card. Use with product photo for physical layout.

---

## 1. Physical Layout Data

- **Form factor:** Business card sized PCB
- **USB-C port:** Top edge, center
- **BOOT button:** Bottom edge (press to reset/reboot)
- **RESET button:** Top-right corner, near USB port (hold during power-up for bootloader)
- **Status LED (D1):** Bottom-right corner, white, shows heartbeat when running
- **12 capacitive touch pads:** Arranged across face of card
- **10 RGB LEDs:** Under pads 0-9 only (pads 10-11 have no LEDs)

---

## 2. Pad Numbering & Arrangement

| Pad | Position Description | Has LED |
|-----|---------------------|---------|
| 0 | Top-left large pad | ✓ |
| 1 | Top row, 1st small | ✓ |
| 2 | Top row, 2nd small | ✓ |
| 3 | Top row, 3rd small | ✓ |
| 4 | Top row, 4th small (rightmost) | ✓ |
| 5 | Large center pad | ✓ |
| 6 | Middle row, right of center | ✓ |
| 7 | Bottom row, 1st small | ✓ |
| 8 | Bottom row, 2nd small | ✓ |
| 9 | Bottom-right large pad | ✓ |
| 10 | Bottom row, near center | ✗ |
| 11 | Bottom row, near center | ✗ |

**Boot Combo Groupings:**
- Pads **2 + 3** → CONFIG Mode
- Pads **4 + 5** → RESET CONFIG
- Pads **8 + 9** → FORCE MIDI

---

## 3. Boot Mode Reference Table

| Pads | Mode | Detection Color | Confirmation Color | Description |
|------|------|-----------------|-------------------|-------------|
| 2 + 3 | CONFIG | BLUE | GREEN (blinking) | USB drive for config.txt editing |
| 4 + 5 | RESET CONFIG | RED | WHITE (blinking) | Factory reset |
| 8 + 9 | FORCE MIDI | YELLOW | RED (blinking) | MIDI mode regardless of jumper |

**Priority Order:** CONFIG (2+3) → RESET (4+5) → FORCE MIDI (8+9)

**Timing:** Hold pads ~1 second during boot

---

## 4. LED Color Palette

| Context | Color |
|---------|-------|
| Init swipe (boot) | WHITE |
| Status heartbeat | WHITE |
| Config save in progress | WHITE (solid) |
| CONFIG detecting | BLUE |
| CONFIG confirmed | GREEN (blinking) |
| RESET CONFIG detecting | RED |
| RESET CONFIG confirmed | WHITE (blinking) |
| FORCE MIDI detecting | YELLOW |
| FORCE MIDI confirmed | RED (blinking) |

---

## 5. Button Functions

| Label on PCB | Function | Location |
|--------------|----------|----------|
| **BOOT** | Press to reset/reboot device | Bottom edge |
| **RESET** | Hold during power-up to enter bootloader | Top-right, near USB |

---

## 6. Config Syntax Reference

### Parameter Pattern
`pad_X_parameter=value` where X = pad number (0-11)

### Parameters

| Parameter | Values | Description |
|-----------|--------|-------------|
| `pad_X_midi_note` | 0-127 | MIDI note number |
| `pad_X_midi_velocity` | 1-127 | Note velocity |
| `pad_X_midi_channel` | 1-16 | MIDI channel |
| `pad_X_hid_key` | see below | Key or key combo |
| `pad_X_led_brightness` | 0-255 | LED brightness |
| `pad_X_led_base_r` | 0-255 | Base red |
| `pad_X_led_base_g` | 0-255 | Base green |
| `pad_X_led_base_b` | 0-255 | Base blue |
| `pad_X_led_touch_hue_shift` | -127 to +127 | Hue shift on touch |

### Modifiers
`ctrl`, `alt`, `shift`, `gui`

Combine with `+`: `ctrl+alt+arrow_up`

Max 2 modifiers currently.

### Special Keys
`tab`, `enter`, `esc`, `backspace`, `delete`, `space`
`f1` - `f12`
`arrow_up`, `arrow_down`, `arrow_left`, `arrow_right`
`home`, `end`, `page_up`, `page_down`
`comma`, `period`, `minus`, `equal`, `[`, `]`, `\`, `;`, `'`, `` ` ``, `/`

### Examples
```
pad_0_hid_key=ctrl+alt+arrow_up
pad_1_hid_key=alt+s
pad_5_hid_key=space
pad_5_led_base_r=255
pad_5_led_base_g=0
pad_5_led_base_b=0
```

---

## 7. Troubleshooting Quick Hits

| Problem | Solution |
|---------|----------|
| Touches not registering | Rest other hand on PCB edge (grounding) |
| Dry hands | Moisten fingertips slightly |
| Pads acting weird/inverted | Press BOOT to reset, don't touch during WHITE swipe |

---

## 8. Design Notes for Visual Agent

### Recommended Layout
- **Front:** Pad layout diagram with numbers, boot combos with colors, button labels
- **Back:** Config syntax cheat sheet, troubleshooting one-liners

### Visual Emphasis
1. **Boot combo pads** - highlight 2+3, 4+5, 8+9 groupings with their colors
2. **Button locations** - clear callouts for BOOT and RESET with their actual functions
3. **Status LED** - mark D1 location
4. **Pads without LEDs** - indicate 10 and 11 are LED-less

### Color Coding Suggestion
- Use actual LED colors in the diagram (BLUE, RED, YELLOW for detection)
- Show confirmation colors as secondary indicators

### Target Audience
Kid-friendly / quick-start - minimal text, maximum visual
