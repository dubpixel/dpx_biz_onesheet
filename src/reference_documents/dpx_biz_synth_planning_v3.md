# dpx_biz_synth.html - planning v3

## overview
Browser-based MIDI synthesizer that reacts to dpx_biz card input (or mouse/keyboard for testing). Visual feedback via PCB image with pulsing halos matching main page aesthetic.

---

## inputs
- **Web MIDI API** — listen to physical dpx_biz card
- **Mouse** — click pads on PCB image
- **Keyboard** — fallback mapping (1-9, 0 for pads)

---

## visualization
- Same PCB image as main page
- Pads pulse gold halo on note-on (match main page aesthetic)
- Decay/release animation on note-off

---

## modes

| Mode | Type | Source | Editable |
|------|------|--------|----------|
| 1 | oscillator | sine/saw mix | waveform, decay, volume |
| 2 | sampler | cat.wav | base note, volume |
| 3 | sampler | dog.wav | base note, volume |
| 4 | sampler | sheeyit.wav | base note, volume |
| 5 | sampler | awgeez.wav | base note, volume |
| 6 | sampler | horn.wav | base note, volume |
| 7 | sampler | **user drop** | base note, volume |

---

## decisions

| Question | Answer |
|----------|--------|
| Polyphony | **Mode 1 only** (oscillator) — sampler modes 2-7 are mono |
| Envelope | Mode 1 gets simple **decay control** (no full ADSR yet) |
| Mode 7 persistence | **None** — user sample resets on reload |

---

## mode 1: oscillator

- **Polyphonic** (multiple pads can sound simultaneously)
- **Waveform**: Sine ↔ Saw mix (slider or knob)
- **Decay**: knob controlling how long note rings out after release
- **Volume**: knob

---

## modes 2-7: sampler

- **Monophonic** (new note cuts previous)
- **Base note selector**: note name (e.g., C4) — maps to lowest pad (x.1)
- **Volume**: shared global knob
- **Mode 7**: drag & drop zone for custom WAV

---

## pitch mapping logic

**Base note** = the note the sample sounds "correct" at (user-settable, default C4/60)

**Pad x.1** (lowest default note, 60) = always plays at base pitch

**Other pads** = semitone offset from pad x.1's note

```
playbackRate = 2^((padNote - 60) / 12)
```

| Pad | Default Note | Offset from x.1 | If base=60 (C4) | If base=48 (C3) |
|-----|--------------|-----------------|-----------------|-----------------|
| x.1 | 60 | 0 | C4 | C3 |
| x.2 | 61 | +1 | C#4 | C#3 |
| x.3 | 62 | +2 | D4 | D3 |
| x.4 | 64 | +4 | E4 | E3 |
| x.5 | 65 | +5 | F4 | F3 |
| x.6 | 66 | +6 | F#4 | F#3 |
| x.7 | 67 | +7 | G4 | G3 |
| x.8 | 69 | +9 | A4 | A3 |
| x.9 | 70 | +10 | A#4 | A#3 |
| x.10 | 69 | +9 | A4 | A3 |

---

## UI layout

```
┌─────────────────────────────────────────┐
│  dpx_biz_synth                          │
├─────────────────────────────────────────┤
│  ┌─────────────────────────────────┐    │
│  │                                 │    │
│  │     [ PCB IMAGE + HALOS ]       │    │
│  │                                 │    │
│  └─────────────────────────────────┘    │
├─────────────────────────────────────────┤
│  MODE: [1] [2] [3] [4] [5] [6] [7]      │
├─────────────────────────────────────────┤
│  Mode 1 only:                           │
│    [SINE ●───────○ SAW]   [DECAY ◉]     │
│                                         │
│  All modes:                             │
│    [BASE NOTE: C4 ▾]      [VOLUME ◉]    │
│                                         │
│  Mode 7 only:                           │
│    ┌─────────────────────┐              │
│    │  drop WAV here      │              │
│    └─────────────────────┘              │
└─────────────────────────────────────────┘
```

---

## controls summary

### mode 1 (oscillator)
- Waveform mix: sine ↔ saw slider
- Decay: knob (release time)
- Volume: knob

### modes 2-7 (sampler)
- Base note: dropdown (C1–C6)
- Volume: knob (shared)
- Mode 7: WAV drop zone

---

## tech stack

- **Web Audio API** — oscillators, sample playback, gain control
- **Web MIDI API** — listen to dpx_biz hardware
- **AudioBufferSourceNode** — sample playback with `playbackRate` for pitch
- **Vanilla JS** — no frameworks, match main page

---

## file structure

```
/synth/
  index.html
  samples/
    cat.wav
    dog.wav
    sheeyit.wav
    awgeez.wav
    horn.wav
  images/
    pcb-photo.png
    logo.png
```

---

## midi note reference (dpx_biz defaults)

| Pad | Silkscreen | Config Key | Default MIDI Note |
|-----|------------|------------|-------------------|
| x.1 | x.1 | pad_0_* | 60 |
| x.2 | x.2 | pad_1_* | 61 |
| x.3 | x.3 | pad_2_* | 62 |
| x.4 | x.4 | pad_3_* | 64 |
| x.5 | x.5 | pad_4_* | 65 |
| x.6 | x.6 | pad_5_* | 66 |
| x.7 | x.7 | pad_6_* | 67 |
| x.8 | x.8 | pad_7_* | 69 |
| x.9 | x.9 | pad_8_* | 70 |
| x.10 | x.10 | pad_9_* | 69 |
