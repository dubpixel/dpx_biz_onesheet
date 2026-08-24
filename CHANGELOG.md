# Changelog

## config-reference v2.1.0 - 2026-08-24

### Fixed
- `--text-dim` was set to `#0f0808` (near-black) instead of the site-wide `#888888`, making most of the page's secondary text nearly illegible against the dark background

### Added
- Grounding note explaining what config.txt is and how to access/apply it (boot combo, desktop-only, quickstart link), broken into numbered steps instead of one run-on sentence
- Warning note on the saving/eject gotcha, matching the main page's boot_combos card wording
- `factory_defaults` moved to lead the page (was previously last) and made a collapsible `<details>` toggle
- Clarified the 0-indexed config key vs 1-indexed PCB label mismatch, and that config.txt only needs to list parameters you're overriding
- Working anchor links for "see special_keys" and "see factory_defaults" (previously just said "see below")

## dpx-interactive v2.5.0 / dpx-interactive-noSerial v2.4.0 / dpx_biz_flash v1.0.0 - 2026-08-23

### Added
- New `dpx_biz_flash.html` page - how to enter bootloader and flash the base firmware, plus links out to the `dpx_biz_qwikstrt` template repo for building your own firmware. Includes the real PCB image with hover-highlighted BOOT/RESET buttons, matching the main page's interaction style
- "firmware" button in the tools card (index/noSerial pages), in its own muted sage-green color distinct from the blue/gold tool buttons
- Footer github link now points to `dpx_biz_qwikstrt` (the firmware template) instead of this onesheet repo

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