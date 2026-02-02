# dpx_biz_hid.html - planning v1

## overview
Browser-based HID keystroke visualizer/tester for dpx_biz in keyboard mode. Shows which pad triggered based on detected keystrokes, and displays a visual keyboard with highlighted keys.

---

## inputs
- **Physical keyboard** — detect keystrokes from dpx_biz (in HID mode) or any keyboard
- **Browser keydown/keyup events** — capture key combos including modifiers

---

## top pane - PCB visualization
- Same PCB image + hotspots as synth/main page
- Pads light up when their corresponding HID keystroke combo is detected
- Gold halo pulse animation (matching synth/main page aesthetic)
- No click interaction needed (read-only visualization)

---

## bottom pane - keyboard visualization
- Visual QWERTY keyboard layout
- Keys highlight on press (gold, matching theme)
- Modifier keys shown (Ctrl, Alt, Shift, Meta/Cmd)
- Arrow keys cluster
- Special keys (Space, Enter, Brackets, Period, Comma, etc.)

---

## current input display
- Text display showing active key combo
- e.g., `ctrl + alt + ↑` or `alt + s`
- Shows matched pad label when detected
- Clears on key release (or after short timeout)

---

## default HID mappings (from dpx_biz)

| Pad | HID Keystroke | JS Key Code | Modifiers |
|-----|---------------|-------------|-----------|
| x.1 | ctrl+alt+↑ | ArrowUp | ctrlKey + altKey |
| x.2 | alt+s | KeyS | altKey |
| x.3 | alt+m | KeyM | altKey |
| x.4 | ctrl+alt+[ | BracketLeft | ctrlKey + altKey |
| x.5 | o | KeyO | none |
| x.6 | . (period) | Period | none |
| x.7 | , (comma) | Comma | none |
| x.8 | alt+t | KeyT | altKey |
| x.9 | space | Space | none |
| x.10 | ctrl+alt+↓ | ArrowDown | ctrlKey + altKey |

---

## detection logic

```javascript
// Pad mapping structure
const PAD_MAPPINGS = {
  1:  { key: 'ArrowUp',     modifiers: { ctrl: true, alt: true } },
  2:  { key: 'KeyS',        modifiers: { alt: true } },
  3:  { key: 'KeyM',        modifiers: { alt: true } },
  4:  { key: 'BracketLeft', modifiers: { ctrl: true, alt: true } },
  5:  { key: 'KeyO',        modifiers: {} },
  6:  { key: 'Period',      modifiers: {} },
  7:  { key: 'Comma',       modifiers: {} },
  8:  { key: 'KeyT',        modifiers: { alt: true } },
  9:  { key: 'Space',       modifiers: {} },
  10: { key: 'ArrowDown',   modifiers: { ctrl: true, alt: true } }
};

// On keydown:
// 1. Highlight pressed key on keyboard viz
// 2. Highlight active modifiers
// 3. Build current combo string for display
// 4. Match against pad mappings
// 5. If match found, light up corresponding pad on PCB

// On keyup:
// 1. Remove key highlight
// 2. Update modifier state
// 3. Clear combo display (or fade out)
// 4. Remove pad highlight
```

---

## keyboard layout structure

```
┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───────┐
│ ` │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 8 │ 9 │ 0 │ - │ = │ Bksp  │
├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─────┤
│ Tab │ Q │ W │ E │ R │ T │ Y │ U │ I │ O │ P │ [ │ ] │  \  │
├─────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─────┤
│ Caps │ A │ S │ D │ F │ G │ H │ J │ K │ L │ ; │ ' │ Enter  │
├──────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴────────┤
│ Shift  │ Z │ X │ C │ V │ B │ N │ M │ , │ . │ / │  Shift   │
├────┬───┴┬──┴─┬─┴───┴───┴───┴───┴───┴──┬┴───┼───┴┬────┬────┤
│Ctrl│Meta│Alt │         Space          │ Alt│Meta│Menu│Ctrl│
└────┴────┴────┴────────────────────────┴────┴────┴────┴────┘

        ┌───┐
        │ ↑ │
    ┌───┼───┼───┐
    │ ← │ ↓ │ → │
    └───┴───┴───┘
```

---

## UI layout

```
┌─────────────────────────────────────────────┐
│  dpx_biz_hid                                │
│  keystroke visualizer for hid mode          │
├─────────────────────────────────────────────┤
│  ┌───────────────────────────────────────┐  │
│  │                                       │  │
│  │        [ PCB IMAGE + HALOS ]          │  │
│  │                                       │  │
│  └───────────────────────────────────────┘  │
├─────────────────────────────────────────────┤
│                                             │
│  current: [ ctrl + alt + ↑ ]    pad: x.1    │
│                                             │
│  ┌───────────────────────────────────────┐  │
│  │                                       │  │
│  │        [ KEYBOARD LAYOUT ]            │  │
│  │                                       │  │
│  └───────────────────────────────────────┘  │
│                                             │
├─────────────────────────────────────────────┤
│  pad_mapping_reference (collapsible?)       │
│  x.1: ctrl+alt+↑   x.6: .                   │
│  x.2: alt+s        x.7: ,                   │
│  x.3: alt+m        x.8: alt+t               │
│  x.4: ctrl+alt+[   x.9: space               │
│  x.5: o            x.10: ctrl+alt+↓         │
└─────────────────────────────────────────────┘
```

---

## key states / styling

| State | Style |
|-------|-------|
| idle | dark bg (#333), dim text (#888) |
| pressed | gold bg (#c9a227), white text, glow shadow |
| modifier active | gold border, dim gold bg (rgba) |

---

## components

### PCB hotspots
- Reuse from synth page
- Remove click handlers (or make optional)
- Add `.detected` class for keystroke-triggered highlights

### Keyboard keys
- Each key is a div with `data-key="KeyCode"` attribute
- CSS grid or flexbox for layout
- Different widths for special keys (shift, space, enter, etc.)

### Combo display
- Shows human-readable combo: `ctrl + alt + ↑`
- Shows matched pad: `pad x.1`
- Fades out after release + delay

### Mapping reference
- Simple 2-column grid showing all pad→key mappings
- Maybe collapsible to save space

---

## file structure

```
/hid/
  index.html (or dpx_biz_hid.html)
  images/
    pcb-photo.png
    logo.png
```

(shares images with main/synth pages)

---

## tech stack

- **Vanilla JS** — keydown/keyup event listeners
- **CSS Grid** — keyboard layout
- **No dependencies** — match main page approach

---

## edge cases

- **Browser shortcuts** — some combos (ctrl+t, ctrl+w, etc.) may be intercepted by browser
- **OS shortcuts** — some combos trigger OS functions (alt+tab, etc.)
- **Modifier-only presses** — don't highlight pad until full combo detected
- **Key repeat** — ignore repeat events (e.key with repeat flag)

---

## questions / decisions

1. **Editable mappings?** — allow user to change pad→key mappings? Or read-only based on defaults?
   - *Recommendation: read-only for v1*

2. **History log?** — show recent keystrokes in a small log?
   - *Recommendation: skip for v1, keep it simple*

3. **Sound feedback?** — optional click sound on key detect?
   - *Recommendation: no, keep it visual only*

4. **Mobile?** — keyboard viz won't work on mobile (no physical keyboard)
   - *Show message: "connect a keyboard to use this tool"*

---

## future ideas (v2+)

- Keystroke history log
- Custom mapping editor
- Export/import mapping configs
- Visual indicator for "expected" vs "actual" keystrokes
- Latency measurement (time between keystrokes)
