# dpx_biz_onesheet Context

**Project:** Interactive web reference for dpx_biz capacitive touch PCB business card controller.
**Current Stage:** Core interactive page (dpx-interactive.html) exists; planning phase for HID visualizer and synth tools.

---

## Product Overview

**dpx_biz** is a pocket-sized, dual-mode USB controller built around the RP2040 microcontroller:
- **12 capacitive touch pads** (x.1 through x.12 on silkscreen; pad_0–pad_11 in config)
- **10 addressable RGB LEDs** (under pads x.1 through x.10 only; pads x.11/x.12 have no LEDs)
- **2 buttons:** BOOT (reboot) and RESET (bootloader, silkscreen labels are swapped from function)
- **1 status LED (D1)** at bottom-right, shows heartbeat when running
- **USB-C port** for power and communication

**Dual modes:**
- **HID Keyboard Mode:** Controlled via jumper (OPEN); sends keystroke combos to host
- **MIDI Mode:** Controlled via jumper (CLOSED); sends MIDI notes on channel 1

**Default configuration:** Optimized for disguise d3 designer timeline/layer control (not DaVinci Resolve).

---

## Critical Data: Pad Mapping Reference

### Complete Table (PCB Label → Config Key → GPIO → LED → Default Functions)

| PCB | Config | GPIO | LED | HID Default | MIDI Default | d3 Function |
|-----|--------|------|-----|-------------|--------------|-------------|
| x.1 | pad_0_* | 3 | 0 | ctrl+alt+↑ | Note 60 | Layer Up |
| x.2 | pad_1_* | 2 | 1 | alt+s | Note 61 | Split Section |
| x.3 | pad_2_* | 1 | 2 | alt+m | Note 62 | Merge Section |
| x.4 | pad_3_* | 4 | 3 | ctrl+alt+[ | Note 64 | Trim to Playhead |
| x.5 | pad_4_* | 9 | 4 | o | Note 65 | Move Playhead End |
| x.6 | pad_5_* | 7 | 9 | . (period) | Note 66 | Next Section |
| x.7 | pad_6_* | 6 | 8 | , (comma) | Note 67 | Previous Section |
| x.8 | pad_7_* | 5 | 7 | alt+t | Note 69 | Repeat Prev Tag |
| x.9 | pad_8_* | 10 | 6 | space | Note 70 | Play Section |
| x.10 | pad_9_* | 11 | 5 | ctrl+alt+↓ | Note 69 | Layer Down |
| x.11 (QR) | pad_10_* | 18 | — | esc | Note 70 | — |
| x.12 (logo) | pad_11_* | 19 | — | tab | Note 48 | — |

**Key Points:**
- PCB uses **1-indexed** labels (x.1–x.12)
- Config file uses **0-indexed** keys (pad_0–pad_11)
- **LED numbering is NOT sequential** with pad numbers (see `led_lookup[]` array in firmware)
- Pads x.11 and x.12 **have NO LEDs**

---

## Boot Sequence & Timing

From firmware analysis:

1. **WHITE SWIPE** (~500ms) — LEDs 0→9 light sequentially (50ms each)
2. **3 D1 HEARTBEAT CHIRPS** (~600ms) — status LED flashes 3×
3. **1-SECOND SETTLE** — device ready for input
4. **1-SECOND DETECTION WINDOW** — device watches for held combo
5. **CONFIRMATION COLOR + BLINK** — mode triggered
6. **Heartbeat starts** — D1 pulses = normal operation

**When to hold pads:** After 3 D1 blinks begin, hold combo for ~1 second until you see confirmation color blink.

### Boot Combo Colors

| Pads | Mode | Detection → Confirmation |
|------|------|--------------------------|
| x.1 + x.2 | CONFIG | BLUE → GREEN (blinking) |
| x.3 + x.4 | RESET CONFIG | RED → WHITE (blinking) |
| x.7 + x.8 | FORCE MIDI | YELLOW → RED (blinking) |

**Priority:** CONFIG (1+2) > RESET (3+4) > FORCE MIDI (7+8)

---

## File Structure & Organization

```
/src/
  /reference_documents/
    instructions.md          ← Style guide, pad mappings, boot timing, tooltip format
    dpx_biz_hid_planning_v1.md
    dpx_biz_synth_planning_v3.md
    dpx_biz_onesheet_ref.md  ← Physical one-sheet reference data
    FIRMWARE_README.md       ← Full firmware features & config syntax
    context.md               ← [This file]
  /images/
    pcb_images_raw/
  /zzz_archive/             ← Versioned backups (v1.2–v1.9)
/web/
  index.html                ← Main landing page (future)
  dpx_biz_hid.html          ← HID visualizer (planned)
  dpx_biz_synth.html        ← MIDI synth (planned)
  config-reference.html     ← Config syntax reference
  dpx-interactive.html      ← Main interactive page
  hotspots.json
  images/
  samples/
```

---

## Web Project: Current & Planned Pages

### Current Implementation
- **dpx-interactive.html** — Main page with PCB image + interactive hotspots. Hover shows pad info (LED, GPIO, config key, defaults).
- **config-reference.html** — Full config.txt syntax reference with parameter table, modifiers, special keys.

### Planned Implementation
- **dpx_biz_hid.html** — HID keystroke visualizer
  - Detects keystrokes from physical dpx_biz (or any keyboard)
  - Shows pressed keys on keyboard layout visualization
  - Highlights corresponding pads on PCB image when keystroke combo matches
  - Read-only mapping reference (v1)
  
- **dpx_biz_synth.html** — Browser-based MIDI synthesizer
  - Listens to dpx_biz via Web MIDI API
  - Mode 1: Polyphonic oscillator (sine ↔ saw mix, decay envelope, volume)
  - Modes 2–7: Monophonic samplers (cat.wav, dog.wav, sheeyit.wav, awgeez.wav, horn.wav, + user WAV drop zone)
  - Pitch mapping: Adjustable base note, semitone offset per pad
  - Fallback: Keyboard (1–9, 0) and mouse click on pads for testing

---

## Tech Stack

- **Vanilla JS** — No frameworks (matches existing approach)
- **CSS Grid/Flexbox** — Responsive layouts (2 cols tablet, 1 col mobile)
- **SVG overlays** — For hotspot click targets on PCB image (scales proportionally)
- **Web Audio API** — For synth page (oscillators, sample playback, gain/envelope control)
- **Web MIDI API** — For synth page to listen to physical dpx_biz device

**Versioning:** All HTML files include version in filename and footer (`v{X.X}`)

---

## Styling & Branding

**Theme:** Dark with gold accents (dubpixel aesthetic)

| Element | Color | Hex |
|---------|-------|-----|
| Background | Dark | #0a0a0a |
| Gold accent (primary) | Gold | #c9a227 |
| HID highlighting | Blue | #4a9eff |
| MIDI/LED highlighting | Green | #4aff7a |
| Error/alert | Red | #ff4a4a |
| Boot detection | Yellow | #ffdd4a |

**Fonts:**
- **Code:** JetBrains Mono
- **Body/Headers:** Space Grotesk

**Header Style:** Lowercase with underscores (e.g., `config_reference`, `boot_combos`, `pad_mapping_table`)

---

## Hotspot Coordinates (SVG pixel values)

SVG viewBox: `0 0 1152 808` (matches source image exactly; coordinates are in pixels relative to image dimensions)

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

---

## Configuration System

### Pattern
`pad_X_parameter=value` where X = 0–11

### Common Parameters
- `pad_X_midi_note` (0–127)
- `pad_X_midi_velocity` (1–127)
- `pad_X_midi_channel` (1–16)
- `pad_X_hid_key` (key or key combo)
- `pad_X_led_brightness` (0–255)
- `pad_X_led_base_r`, `pad_X_led_base_g`, `pad_X_led_base_b` (0–255 each)
- `pad_X_led_touch_hue_shift` (-127 to +127)

### Special Key Syntax
- **Modifiers:** `ctrl`, `alt`, `shift`, `gui` (combine with `+`, max 2: `ctrl+alt+key`)
- **Special keys:** `tab`, `enter`, `esc`, `space`, `f1`–`f12`, `arrow_up`/`down`/`left`/`right`, `home`, `end`, `page_up`, `page_down`, `comma`, `period`, `minus`, `equal`, `[`, `]`, `\`, `;`, `'`, `` ` ``, `/`

---

## Known Issues & Edge Cases

1. **Browser shortcuts** — Some key combos (ctrl+t, ctrl+w, ctrl+n) may be intercepted by browser in HID mode
2. **OS shortcuts** — Alt+Tab, Win+X, Cmd+Space may trigger OS functions instead of being captured
3. **Touch sensitivity variance** — Handheld vs flat-surface operation feel different
4. **Dry hands** — Requires slight finger moisture for reliable detection
5. **Grounding matters** — Resting other hand on PCB edge improves sensitivity
6. **Pad interference during swipe** — Touching pads during white init swipe causes inverted behavior
7. **Repeat events** — Ignore keyboard repeat events (use `event.repeat` flag)
8. **Mobile compatibility** — HID visualizer only works with physical keyboard; show fallback message on mobile

---

## Tooltip Content Format

Each pad hotspot tooltip on dpx-interactive.html should display:

```
[Pad x.#]                     [LED # or "No LED"]
config: pad_#_*
─────────────────────────────
HID:    [default key combo]
MIDI:   Note [number]
GPIO:   [pin number]
Func:   [d3 designer function, if any]
```

Example for x.1:
```
Pad x.1                       LED 0
config: pad_0_*
────────────────────────────
HID:    ctrl+alt+↑
MIDI:   Note 60 (C4)
GPIO:   3
Func:   Layer Up
```

---

## Planning Documents Reference

### `dpx_biz_hid_planning_v1.md`
- PCB visualization with hotspot halos
- QWERTY keyboard layout visualization
- Keystroke combo display and detection logic
- Covers edge cases: browser shortcuts, OS shortcuts, modifier-only presses, key repeat
- Recommends read-only mappings for v1

### `dpx_biz_synth_planning_v3.md`
- MIDI synthesizer with Web Audio API
- Mode 1: Polyphonic oscillator (sine/saw, decay, volume)
- Modes 2–7: Monophonic samplers + user WAV drop
- Pitch mapping formula: `playbackRate = 2^((padNote - 60) / 12)`
- Default pad MIDI notes (60–70, with some repeats)
- Fallback input: Keyboard (1–9, 0) and mouse clicks

### `dpx_biz_onesheet_ref.md`
- Physical one-sheet reference data for visual designers
- Pad numbering, boot combos with colors, button functions
- LED color palette for each mode/state
- 10 RGB LEDs (under pads 0–9), 2 pads without LEDs (10–11)
- Design notes for kid-friendly quick-reference card

### `FIRMWARE_README.md`
- Complete feature set: HID keyboard, MIDI, config-via-USB-drive, polyphonic touch detection
- Boot sequence timing and modes
- Touch sensing specs: FakeyTouch library, 100 threshold, 75ms debounce
- Full default mappings table (HID + MIDI)
- Config syntax reference with examples

---

## Future Considerations

- **Custom mapping editor** — Allow users to create and save custom pad configs
- **Keystroke history log** — Show recent keystrokes in HID visualizer
- **Latency measurement** — Time between keystroke and pad detection
- **Sound feedback** — Optional click sound on pad detection
- **Visual indicator** — Expected vs actual keystroke comparison
- **3rd modifier support** — ctrl+alt+shift+key combinations
- **Mouse support** — left_click, right_click, scroll, mouse_x/y
- **Key sequences** — Multi-keypress with timing (e.g., "ctrl+c,delay:100,ctrl+v")

---

## Source Files Reference

- **`dpx_biz_frm.ino`** — Complete firmware source (touch sensing, MIDI, HID, LED control)
- **`default_config.h`** — Default config.txt template with parameter descriptions
- **Original Reference Docs** — All planning and specification documents listed above

