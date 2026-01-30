<a id="readme-top"></a>




<!-- readmetemplate-->
<!-- /// d   u   b   p   i   x   e   l  ---  f   o   r   k   ////--v0.5.7 -->
<!--this has additionally been modifed by @dubpixel for hardware use -->
<!--search dpx_biz_onesheet.. search & replace is COMMAND OPTION F -->

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
  <a href="https://github.com/dubpixel/dpx_biz_onesheet">
    <img src="images/logo.png" alt="Logo" height="120">
  </a>
<h1 align="center">dpx_biz_onesheet</h1>
<h3 align="center"><i>"..oh, you want a manual?.."</i></h3>
  <p align="center">
    interactive quick-reference for the dpx_biz capacitive touch PCB business card
    <br />
     »  
     <a href="https://github.com/dubpixel/dpx_biz_onesheet"><strong>Project Here!</strong></a>
     »  
     <br />
    <a href="https://github.com/dubpixel/dpx_biz_onesheet/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/dubpixel/dpx_biz_onesheet/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
     ·
    <a href="https://dpx-biz-onesheet.pages.dev/">Live Demo</a>
  
  </p>
</div>
   <br />
<!-- TABLE OF CONTENTS -->
<!-- ABOUT THE PROJECT -->


## About The Project
this is the **interactive quick-reference** for the dpx_biz capacitive touch PCB business card. it's a standalone html page that lets you hover over each touch pad to see what it does—boot combos, HID mappings, MIDI notes, LED colors, and more.

**key features:**
- **interactive pcb map** – hover over any of the 10 touch pads to see its function
- **soft glowing halos** – visual feedback on hover with smooth fade in/out
- **smart tooltips** – auto-position to avoid clipping at edges
- **config reference** – full config.txt syntax documentation included
- **works offline** – just open the html file in any browser, no server needed

_the dpx_biz is a business card that actually does something—it's a USB HID device that can send keystrokes, mouse clicks, or MIDI notes. this onesheet helps new users figure out what each pad does without reading a full manual._

<details>
<summary>Images</summary>

  ### FRONT
  ![FRONT][product-front]

</details>

## Built With 

 * vanilla html/css/javascript
 * no frameworks, no dependencies, no build step
 * just open and go

<!--
 * [![KiCad][KiCad.org]][KiCad-url]
 * [![Fusion360][Fusion-360]][Autodesk-url]
 * [![FastLed][FastLed.io]][FastLed-url]
 * [![Fusion360][Fusion-360]][Autodesk-url]
 * [![Next][Next.js]][Next-url]
 * [![React][React.js]][React-url]
 * [![Vue][Vue.js]][Vue-url]
 * [![Angular][Angular.io]][Angular-url]
 * [![Svelte][Svelte.dev]][Svelte-url]
 * [![Laravel][Laravel.com]][Laravel-url]
 * [![Bootstrap][Bootstrap.com]][Bootstrap-url]
 * [![JQuery][JQuery.com]][JQuery-url]
 
-->
<p align="right">(<a href="#readme-top">back to top</a>)</p>
<!-- GETTING STARTED -->

## Getting Started
  ### Prerequisites
  * any modern web browser (chrome, firefox, safari, edge)
  * a dpx_biz card (contact i@dubpixel.tv for details)
  * usb-c cable
  
### Installation

  1. clone or download this repo
  2. open `src/dpx-interactive.html` in your browser
  3. hover over the pads to explore


<!-- USAGE EXAMPLES -->
## Usage

### using the interactive reference

1. open `src/dpx-interactive.html` in your browser
2. hover over any touch pad to see its mapping
3. tooltips show: pad number, HID key, MIDI note, LED color

<details>
<summary>More Usage Information</summary>
  
### boot modes (hold during plug-in)

| combo | mode | what it does |
|-------|------|--------------|
| **pad 1 + 2** | config mode | mounts as USB drive to edit config.txt |
| **pad 3 + 4** | factory reset | clears config, restores defaults |
| **pad 7 + 8** | force MIDI | boots in MIDI mode regardless of config |

### touch tips

- **single tap** – sends the mapped key/note once
- **hold** – some pads support hold behavior (configurable)
- **pad 1** is top-left, **pad 10** is bottom-right
- LED colors indicate pad state (configurable per-pad)

### config.txt reference

for full config syntax, open `src/config-reference.html`—it covers all parameters like `sensitivity`, `led_color`, `midi_channel`, and more.

_see the interactive page for the complete pad→key→midi mapping table_

</details>
<!-- REFLECTION -->

## Reflection

* what did we learn? 
  - _hover effects are surprisingly finicky at image boundaries_
  - _percentage-based positioning > pixel-based for responsive layouts_
* what do we like/hate?
  - _like: soft glowing halos are fun_
  - _hate: tooltip positioning edge cases are not_
* what would/could we do differently?
  - _maybe use svg overlays instead of div hotspots_
  - _finsh the roadmap for once_
  <!-- ROADMAP -->
## Roadmap

- [x] interactive pcb map with hover tooltips
- [x] soft glowing halos on hover
- [x] smart tooltip positioning (no clipping)
- [x] config.txt reference page
- [ ] correct popup bounds for narrow portait clipping
- [x] insert URL into readme
- [x] add links and firmware

See the [open issues](https://github.com/dubpixel/dpx_biz_onesheet/issues) for a full list of proposed features (and known issues).

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
  <a href="https://github.com/dubpixel/dpx_biz_onesheet/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=dubpixel/dpx_biz_onesheet" alt="contrib.rocks image" />
  </a>

<!-- LICENSE -->
## License
This work is licensed under CC BY-SA 4.0 with the following additional restriction: __commercial sale of unmodified reproductions is prohibited.__ Modified versions that constitute a substantial remix may be sold under the same terms.

__In plain terms:__

* Use it, learn from it, build on it — go buck wild!!
* Give credit back to this project
* _Don't_ just clone this and sell it— __that's not allowed__
* Remixes, improvements, and real derivatives? Sell them, just keep the attribution and share-alike
* Share your modifications under these same terms

_Questions about commercial use? Open an issue or reach out._
<!-- CONTACT -->
## Contact

  ### Joshua Fleitell - i@dubpixel.tv

  Project Link: [https://github.com/dubpixel/dpx_biz_onesheet](https://github.com/dubpixel/dpx_biz_onesheet)

<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

<!--
  * [ ]() - the best !
-->
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/dubpixel/dpx_biz_onesheet.svg?style=flat-square
[contributors-url]: https://github.com/dubpixel/dpx_biz_onesheet/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/gdubpixel/dpx_biz_onesheet.svg?style=flat-square
[forks-url]: https://github.com/dubpixel/dpx_biz_onesheet/network/members
[stars-shield]: https://img.shields.io/github/stars/dubpixel/dpx_biz_onesheet.svg?style=flat-square
[stars-url]: https://github.com/dubpixel/dpx_biz_onesheet/stargazers
[issues-shield]: https://img.shields.io/github/issues/dubpixel/dpx_biz_onesheet.svg?style=flat-square
[issues-url]: https://github.com/dubpixel/dpx_biz_onesheet/issues
[license-shield]: https://img.shields.io/github/license/dubpixel/dpx_biz_onesheet.svg?style=flat-square
[license-url]: https://github.com/dubpixel/dpx_biz_onesheet/blob/main/LICENSE.txt
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
