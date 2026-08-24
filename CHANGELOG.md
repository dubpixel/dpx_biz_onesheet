# Changelog

## dpx-interactive v2.4.2 / dpx-interactive-noSerial v2.3.2 - 2026-08-23

### Fixed
- Boot combo intro text said to hold the combo "while powering on" - actually needs to be after the 3 heartbeat chirps
- Confirm-blink color dots (boot_sequence step 5, and all three boot_combos rows) were always blinking - now solid until hovered, then blink only during the confirm phase, matching the PCB LED behavior
- Removed dangling "below" from the jumper description text

### Changed
- "saving:" label renamed to "saving config:" in the boot_combos footer
- Removed the "combo priority" line from the boot_combos footer (redundant/confusing)
- boot_sequence warning steps now explain why: "don't touch, calibrating" / "don't touch, setting baseline"
- boot_sequence detection/confirm dots now use real combo colors (blue/green) instead of generic gold
- Hovering "heartbeat = ready" now plays the 3 chirps before the steady pulse starts

## dpx-interactive v2.4.1 / dpx-interactive-noSerial v2.3.1 - 2026-08-22

### Added
- Desktop-only notice on the quickstart card and README Prerequisites - mounting as a drive, config editing, firmware flashing, and the serial debug panel don't work on phones/tablets

## dpx-interactive v2.4.0 / dpx-interactive-noSerial v2.3.0 / config-reference v2.0.2 - 2026-08-21

### Added
- Quickstart card explaining the device (dual-mode HID/MIDI, disguise d3 designer default mapping, boot combo overview) up front, before the pad-hover reference
- Boot swipe animation replayed live on the real PCB image (measured LED positions per pad) instead of an abstract dot animation, with hover-triggered previews for "white swipe" / "3x d1 chirps" / "heartbeat"
- Hover highlighting: hardware items (boot./reset./d1./jumper.) and boot combo rows now light their matching pad(s) on the PCB, including a real jumper hotspot with tooltip
- Boot combo rows show the correct detection color (blue/red/yellow) on hover, escalating to a blinking confirmation color (green/white/red) after a ~1s hold, matching the real firmware sequence
- GitHub link on the page title

### Fixed
- `config-reference.html`'s back-link pointed to `dpx-interactive.html`, which doesn't exist in the deployed `web/` output (renamed to `index.html` by `deploy.sh`) - was a broken link on the live site
- `.gitignore` pattern mismatch that left `src/zzz_archive/` tracked in git
- Boot combo/hover glow snapping instead of fading (split gold hover halo and white highlight glow into separate pseudo-elements so gradient colors never have to cross-fade)

### Changed
- Toggle switch (jlc_render/no_parts) moved below the PCB image, smaller and right-aligned
- Layout reorganized into two balanced 3-card rows instead of one 4-column grid

## v0.0.0

### Added or Changed
- 

### Removed

- S