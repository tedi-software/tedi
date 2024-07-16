<div align="center">
  <a href="https://github.com/tedi-software/tedi">
    <img src="images/banner.png" alt="Tedi" >
  </a>
</div>

<!-- width="1280" height="640" -->


###### *Copywrite (C) 2020-2024 TEDI, LLC*

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![GitHub Downloads (all assets, all releases)][downloads-shield]][downloads-url]

[![License][license-shield]][license-url]

<p align="left">
<a href="https://github.com/tedi-software/tedi">View Demo</a>
    |
    <a href="https://github.com/tedi-software/tedi/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    |
    <a href="https://github.com/tedi-software/rtedi/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
</p>

<a id="top"></a>

## ${\color{949698} ➤}$ About TEDI
<p align="left">
TEDI is an easy-to-use, cloud-native, high-performant, low-code integration server. TEDI is a low-cost solution to facilitate the movement of your important business data between business applications and services (A2A & B2B) internally within your organization and externally with your trading partners.

TEDI saves engineering and development time by employing a framework of common engineering patterns that can be stitched together via workflows driven by configuration files.

TEDI is powered by Golang and can run as a stand-alone binary running in systemd or if you prefer, it can easily be containerized.
</p>

<p align="right">(<a href="#top">top</a>)</p>


## ${\color{949698} ➤}$ Getting Started
The tedi repository is an example installation. Follow the installation steps below to start and start TEDI.


### ${\color{949698} ➤}$ Installation
1. clone the repo
   ```sh
   git clone https://github.com/tedi-software/tedi.git
   ```
2. copy the tedi folder to the directory you want to root TEDI
   ```sh
   cd /path/to/tedi
   cp -pR tedi /opt/
   ```

### ${\color{949698} ➤}$ Running TEDI
1. start TEDI
   ```sh
   cd /opt/tedi/bin
   ./tedi_start.sh
   ```
2. stop TEDI
   ```sh
   cd /opt/tedi/bin
   ./tedi_stop.sh
   ```
3. viewing the logs
   ```sh
   cd /opt/tedi/logs
   tail -f tedi_*.log
   ```

> [!NOTE]
> This sample TEDI installation includes binaries for Linux and OSX.
> Note: the MacOSX binaries are not signed and will be put into quarantine on download. To list and subsequently remove:

```sh
    xattr <binary name>
    xattr -d <binary name>
```

<p align="right">(<a href="#top">top</a>)</p>


## ${\color{949698} ➤}$ Usage

<p align="right">(<a href="#top">top</a>)</p>


## ${\color{949698} ➤}$ Supported Protocols
- [x] Shell
- [x] SFTP
- [x] HTTPS
- [x] NATS (Core/JetStream)
- [x] XSLT (in-memory/on-disk)
- [x] PGP
- [x] Database
  - [x] Oracle
  - [x] MySQL
  - [x] PostgreSQL
  - [x] Microsoft SQL Server

## ${\color{949698} ➤}$ Roadmap
- [] AS2
- [] Kafka
- [] Azure ADLS
- [] Azure EventHub

See the [open issues](https://github.com/tedi-software/tedi/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">top</a>)</p>


## ${\color{949698} ➤}$ Support
For questions, open an [issue](https://github.com/tedi-software/tedi/issues) 

<p align="right">(<a href="#top">top</a>)</p>



[contributors-shield]: https://img.shields.io/github/contributors/tedi-software/tedi.svg?style=for-the-badge
[contributors-url]:    https://github.com/tedi-software/tedi/graphs/contributors

[downloads-shield]:    https://img.shields.io/github/release/tedi-software/tedi.svg?style=for-the-badge
[downloads-url]:       https://img.shields.io/github/downloads/tedi-software/tedi/total

[forks-shield]:        https://img.shields.io/github/forks/tedi-software/tedi.svg?style=for-the-badge
[forks-url]:           https://github.com/tedi-software/tedi/network/members

[stars-shield]:        https://img.shields.io/github/stars/tedi-software/tedi.svg?style=for-the-badge
[stars-url]:           https://github.com/tedi-software/tedi/stargazers

[issues-shield]:       https://img.shields.io/github/issues/tedi-software/tedi.svg?style=for-the-badge
[issues-url]:          https://github.com/tedi-software/tedi/issues

[license-shield]:      https://img.shields.io/badge/License-Commercial-FF0000
[license-url]:         https://raw.githubusercontent.com/tedi-software/tedi/main/LICENSE
