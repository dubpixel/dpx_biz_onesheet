<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>

<!--  *** Thanks for checking out the Best-README-Template. If you have a suggestion that would make this better, please fork the repo and create a pull request or simply open an issue with the tag "enhancement". Don't forget to give the project a star! Thanks again! Now go create something AMAZING! :D -->



<!-- /// d   u   b   p   i   x   e   l  ---  f   o   r   k   ////--v0.5.7 -->
<!--this has additionally been modifed by @dubpixel for hardware use -->
<!--search dpx_biz_frm .. search & replace is COMMAND OPTION F -->

<!--this is the version for software -->
<!--todo ** add small product image thats not in a details tag -->
<!--todo ** new software product image? Remove it? -->
<!--igure out how to get the details tag to properly render in jekyll for gihub pages.-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
***
-->
<div align="center">

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
</div>
<!-- PROJECT LOGO -->
<div align="center">
  <a href="https://github.com/dubpixel/dpx_biz_frm">
    <img src="images/logo.png" alt="Logo" height="120">
  </a>
<h1 align="center">DPX Business Card</h1>
<h3 align="center"><i>Dual-Mode MIDI/Keyboard Controller</i></h3>
  <p align="center">
    RP2040-based business card with 12 capacitive touch pads and 10 WS2812 LEDs
    <br />
     »  
     <a href="https://github.com/dubpixel/dpx_biz_frm"><strong>Project Here!</strong></a>
     »  
     <br />
    <a href="https://github.com/dubpixel/dpx_biz_frm/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/dubpixel/dpx_biz_frm/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
    </p>
</div>
   <br />
<!-- TABLE OF CONTENTS -->
<details>
  <summary><h3>Table of Contents</h3></summary>
<ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#default-mappings">Default Mappings</a></li>
    <li><a href="#configuration">Configuration</a></li>
    <li><a href="#reflection">Reflection</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
</ol>
</details>
<!-- ABOUT THE PROJECT -->
<details>
<summary><h3>About The Project</h3></summary>

The DPX Business Card is a pocket-sized USB controller that can operate as either a MIDI controller  or an HID keyboard for show control. Built around the RP2040 microcontroller, it features 12 capacitive touch pads with polyphonic detection and 10 addressable RGB LEDs for visual feedback.

The device was designed specifically for show control in disguise d3 designer, with default keyboard mappings optimized for timeline editing, layer navigation, and section management. In MIDI mode, it becomes a portable note trigger for show control and music production applications.

Configuration is done via a simple text file accessible by holding two pads during boot - no software installation required. The device appears as a USB drive, you edit the config file, save, and press the reset button.

*author: Joshua Fleitell - www.dubpixel.tv - i@dubpixel.tv* 
</br>
<h3>Images</h3>

### FRONT
![FRONT][product-front]
</details>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With 
 
 * RP2040 Microcontroller
 * Adafruit TinyUSB
 * [![FastLed][FastLed.io]][FastLed-url]
 * FakeyTouch (capacitive sensing library)
 * PlatformIO
<p align="right">(<a href="#readme-top">back to top</a>)</p>
<!-- GETTING STARTED -->

## Getting Started

  ### Prerequisites
  
  * USB-C cable
  * Computer with available USB port
  * (Optional) MIDI software or DAW for MIDI mode
  * (Optional) disguise d3 designer for the default HID mode config
  
  ### Installation

  1. **Connect the device**
     ```
     Plug in via USB-C → Device boots in default HID mode
     ```

  2. **Choose your mode:**
     - **HID Keyboard** (d3 control) → Jumper OPEN (default)
     - **MIDI Controller** (show control ) → Jumper CLOSED or hold pads 8+9 during boot

  3. **Test it out**
     ```
     Touch any pad → LED lights up → Action triggers!
     ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->
## Usage

### Mode Selection

#### Normal Operation
- **Jumper CLOSED** (pin 20 to GND): MIDI Controller mode
- **Jumper OPEN** (pin 20 floating): HID Keyboard mode

#### Boot Mode Combinations

Hold touch pads during power-on/reset to access special modes:

| Pads | Mode | Description |
|------|------|-------------|
| **2 + 3** | CONFIG Mode | Device appears as USB drive for `config.txt` editing. Save config.txt then press reset button (WARNING: ejecting causes drive to re-mount. dont do this). |
| **4 + 5** | RESET CONFIG | Resets configuration to factory defaults and reboots |
| **8 + 9** | FORCE MIDI | Forces MIDI mode regardless of jumper setting |

**Priority Order:** Config mode (2+3) → Reset (4+5) → Force MIDI (8+9)

#### Boot Sequence & Timing

1. **Init swipe** - WHITE sweeps across pads (50ms per LED)
2. **Heartbeat starts** - Status LED (D1, bottom-right) pulses white
3. **Touch sensing activates** - safe to touch pads now
4. **Hold pad combination ~1 second** to trigger boot mode
5. **Detection color appears** on held pads:
   - BLUE (pads 2+3) = CONFIG Mode
   - RED (pads 4+5) = RESET CONFIG
   - YELLOW (pads 8+9) = FORCE MIDI
6. **Confirmation color blinks** when mode triggers:
   - GREEN blinking = CONFIG Mode confirmed
   - WHITE blinking = RESET CONFIG confirmed
   - RED blinking = FORCE MIDI confirmed
7. **Release pads** to continue boot into selected mode

⚠️ **Do NOT touch pads during init swipe** - wait for heartbeat before holding pad combinations.

**Config save workflow:** Solid white on status LED (D1) indicates saving. Wait for heartbeat to return, then press **BOOT** button to reset.

#### Touch Sensing Tips

- Works on flat surface or handheld - grounding improves sensitivity
- If touches aren't registering, rest your other hand on the PCB edge
- Dry hands? Moisten fingertips slightly
- Don't touch pads during WHITE swipe (calibration) - causes inverted behavior
- Pads acting weird? Press **BOOT** button to reset, keep hands off pads during swipe

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Features

- ✅ HID Keyboard control
- ✅ MIDI Controller
- ✅ Config from USB disk
- ✅ Internal config file system formatter
- ✅ Per-pad configuration system
- ✅ Polyphonic touch detection
- ✅ Per-pad debouncing (75ms)
- ✅ Adjustable touch threshold (100)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Default Mappings

### HID Keyboard Mode (disguise d3 designer)

| Pad | Key Mapping | D3 Function |
|-----|-------------|-------------|
| 0 | `Ctrl+Alt+↑` | Layer Up |
| 1 | `Alt+S` | Split Section |
| 2 | `Alt+M` | Merge Section |
| 3 | `Ctrl+Alt+[` | Trim Container to Playhead |
| 4 | `O` | Move Playhead to End of Container |
| 5 | `.` (period) | Next Section |
| 6 | `,` (comma) | Previous Section |
| 7 | `Alt+T` | Repeat Previous Tag |
| 8 | `Space` | Play Section |
| 9 | `Ctrl+Alt+↓` | Layer Down |
| 10 | `Esc` | Escape |
| 11 | `Tab` | Tab |

### MIDI Controller Mode

| Pad | MIDI Note | Velocity | Channel |
|-----|-----------|----------|---------|
| 0 | 60 (C4) | 127 | 1 |
| 1 | 61 (C#4) | 127 | 1 |
| 2 | 62 (D4) | 127 | 1 |
| 3 | 64 (E4) | 127 | 1 |
| 4 | 65 (F4) | 127 | 1 |
| 5 | 66 (F#4) | 127 | 1 |
| 6 | 67 (G4) | 127 | 1 |
| 7 | 69 (A4) | 127 | 1 |
| 8 | 70 (A#4) | 127 | 1 |
| 9 | 69 (A4) | 127 | 1 |
| 10 | 70 (A#4) | 127 | 1 |
| 11 | 48 (C3) | 127 | 1 |

*Note: Pads 7 and 9 both map to MIDI note 69 (A4) in current shipped firmware.*

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Configuration

Edit `config.txt` when in CONFIG mode to customize:
- MIDI notes, velocity, and channels
- HID keyboard mappings
- Key modifiers (ctrl, alt, shift)
- Special keys (arrows, function keys, etc.)
- LED colors per pad

See `include/default_config.h` for configuration template and examples.

### Parameter Reference

**Naming pattern:** `pad_X_parameter` where X = pad number (0-11)

| Parameter | Values | Description |
|-----------|--------|-------------|
| `pad_X_midi_note` | 0-127 | MIDI note number |
| `pad_X_midi_velocity` | 1-127 | Note velocity |
| `pad_X_midi_channel` | 1-16 | MIDI channel |
| `pad_X_hid_key` | see below | Key or key combo |
| `pad_X_led_brightness` | 0-255 | LED brightness |
| `pad_X_led_base_r` | 0-255 | Base red value |
| `pad_X_led_base_g` | 0-255 | Base green value |
| `pad_X_led_base_b` | 0-255 | Base blue value |
| `pad_X_led_touch_hue_shift` | -127 to +127 | Hue shift on touch |

### Modifiers

Use `+` to combine modifiers with keys (max 2 modifiers currently supported):

| Modifier | Description |
|----------|-------------|
| `ctrl` | Control key (left) |
| `alt` | Alt key (left) |
| `shift` | Shift key (left) |
| `gui` | GUI/Windows/Cmd key (left) |

### Special Keys

`tab`, `enter`, `esc`, `backspace`, `delete`, `space`
`f1` through `f12`
`arrow_up`, `arrow_down`, `arrow_left`, `arrow_right`
`home`, `end`, `page_up`, `page_down`
`comma`, `period`, `minus`, `equal`, `[`, `]`, `\`, `;`, `'`, `` ` ``, `/`

### Example Config Entries

```
# Simple letter key
pad_0_hid_key=a

# Key with single modifier
pad_1_hid_key=alt+s

# Key with two modifiers
pad_2_hid_key=ctrl+alt+arrow_up

# Special key with modifier
pad_3_hid_key=ctrl+[

# Function key
pad_4_hid_key=f5

# LED color (red)
pad_5_led_base_r=255
pad_5_led_base_g=0
pad_5_led_base_b=0
```

### Technical Details

#### Touch Sensing
- Library: FakeyTouch (based on capsense.info technique)
- Threshold: 100 (optimized for flat-surface operation)
- Debounce: 75ms (prevents retriggering)
- Polyphonic: Independent per-pad timing
- Serial debug: 115200 baud (connect for troubleshooting/debug output)
- Touch auto-recalibration: Disabled (prevents polyphony conflicts)

#### Debug Controls
Located in `src/dpx_biz_frm.ino`:
```cpp
#define DEBUG_LED 0              // LED animation debug
#define DEBUG_TOUCH 1            // General touch debug
```

#### Hardware Pin Assignments

| Pad | GPIO | LED Index |
|-----|------|-----------|
| 0 | 3 | 0 |
| 1 | 2 | 1 |
| 2 | 1 | 2 |
| 3 | 4 | 3 |
| 4 | 9 | 4 |
| 5 | 7 | 9 |
| 6 | 6 | 8 |
| 7 | 5 | 7 |
| 8 | 10 | 6 |
| 9 | 11 | 5 |
| 10 | 18 | — |
| 11 | 19 | — |

*LED Index is non-sequential due to PCB routing. Pads 10-11 have no LEDs.*

**Special Pins:**
- LED data: GPIO 0
- Mode jumper: GPIO 20
- Onboard status LED (D1): GPIO 25

<p align="right">(<a href="#readme-top">back to top</a>)</p>
<!-- REFLECTION -->
## Reflection

* **What did we learn?**
  - Capacitive touch sensing requires careful threshold tuning based on grounding conditions
  - Polyphonic touch detection needs independent per-pad debouncing
  - MIDI is more sensitive to retriggering than HID keyboard input
  
* **What do we like/hate?**
  - ✅ Config-via-USB-drive workflow is simple and accessible
  - ✅ Polyphonic touch detection works reliably with proper debouncing
  - ⚠️ Touch sensitivity varies significantly between held vs flat-surface operation
  
* **What would/could we do differently?**
  - Implement per-pad threshold configuration
  - Add hysteresis to touch detection for better stability
  - Consider adding physical tactile feedback

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->
## Roadmap

- [ ] Multi-keypress sequences (e.g., "ctrl+c,delay:100,ctrl+v")
- [ ] Mouse support (left_click, right_click, scroll_up, scroll_down, mouse_x, mouse_y)
- [ ] 3rd modifier support (ctrl+alt+shift+key combinations)
- [ ] Key sequences with timing
- [ ] Mouse movement with delta values

See the [open issues](https://github.com/dubpixel/dpx_biz_frm/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

_Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**._

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Top contributors:
<a href="https://github.com/dubpixel/dpx_biz_frm/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=dubpixel/dpx_biz_frm" alt="contrib.rocks image" />
</a>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
## License

  Distributed under the UNLICENSE License. See `LICENSE.txt` for more information.
<!-- CONTACT -->
## Contact

  ### Joshua Fleitell - i@dubpixel.tv

  Project Link: [https://github.com/dubpixel/dpx_biz_frm](https://github.com/dubpixel/dpx_biz_frm)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [picotouch](https://github.com/todbot/picotouch) - Inspiration and FakeyTouch library by @todbot / Tod Kurt
* [Best-README-Template](https://github.com/othneildrew/Best-README-Template) - README template
* [FastLED](https://fastled.io) - LED control library
* [Adafruit TinyUSB](https://github.com/adafruit/Adafruit_TinyUSB_Arduino) - USB stack

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Firmware Flashing

### Pre-built Firmware

Download `firmware_v0.5.7.uf2` from the releases page.

### Enter Bootloader

1. Hold the **RESET** button (top-right, near USB port)
2. While holding RESET, press the **BOOT** button
3. Release both buttons
4. Device appears as `RPI-RP2` USB drive

### Flash Firmware

1. Drag `.uf2` file to `RPI-RP2` drive
2. Device reboots automatically when complete

### Building from Source

```bash
pio run -e pico
```

Output: `.pio/build/pico/firmware.uf2`

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/dubpixel/dpx_biz_frm.svg?style=flat-square
[contributors-url]: https://github.com/dubpixel/dpx_biz_frm/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/dubpixel/dpx_biz_frm.svg?style=flat-square
[forks-url]: https://github.com/dubpixel/dpx_biz_frm/network/members
[stars-shield]: https://img.shields.io/github/stars/dubpixel/dpx_biz_frm.svg?style=flat-square
[stars-url]: https://github.com/dubpixel/dpx_biz_frm/stargazers
[issues-shield]: https://img.shields.io/github/issues/dubpixel/dpx_biz_frm.svg?style=flat-square
[issues-url]: https://github.com/dubpixel/dpx_biz_frm/issues
[license-shield]: https://img.shields.io/github/license/dubpixel/dpx_biz_frm.svg?style=flat-square
[license-url]: https://github.com/dubpixel/dpx_biz_frm/blob/main/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/jfleitell
[product-front]: images/front.png
[product-rear]: images/rear.png
[product-front-rendering]: images/front_render.png
[product-rear-rendering]: images/rear_render.png
[product-pcbFront]: images/pcb_front.png
[product-pcbRear]: images/pcb_rear.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 
[KiCad.org]: https://img.shields.io/badge/KiCad-v8.0.6-blue
[KiCad-url]: https://kicad.org 
[Fusion-360]: https://img.shields.io/badge/Fusion360-v4.2.0-green
[Autodesk-url]: https://autodesk.com 
[FastLed.io]: https://img.shields.io/badge/FastLED-v3.9.9-red
[FastLed-url]: https://fastled.io 
