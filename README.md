
<div align="center">
  <a href="https://github.com/tedi-software/tedi">
    <img src="images/tedi_icon.png" alt="Tedi" >
  </a>
</div>

###### *Copywrite (C) 2020-2025 TEDI, LLC*

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![GitHub Downloads (all assets, all releases)][downloads-shield]][downloads-url]

<p align="left">
<a href="#demo">View Demo</a>
    |
    <a href="https://github.com/tedi-software/tedi/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    |
    <a href="https://github.com/tedi-software/rtedi/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
</p>

<a id="top"></a>

### ${\color{949698} ➤}$ About TEDI
<p align="left">
TEDI is an easy-to-use, cloud-native, high-performant, low-code integration server. TEDI is a low-cost solution to facilitate the movement of your important business data between business applications and services (A2A & B2B) internally within your organization and externally with your trading partners.

TEDI saves engineering and development time by employing a framework of common engineering patterns that can be stitched together via workflows driven by configuration files.

TEDI is powered by Golang and can run as a stand-alone binary running in systemd or if you prefer, it can easily be containerized.
</p>
<div align="center">
  <a href="https://github.com/tedi-software/tedi">
    <img src="images/adiag.png" alt="architectural-diagram" >
  </a>
</div>

<p align="right">(<a href="#top">top</a>)</p>

### ${\color{949698} ➤}$ Getting Started
The tedi repository is an example installation. Follow the installation steps below to start and stop TEDI.

#### ${\color{949698} ➤}$ Installation
1. fetch the tedi repository
   ```sh
   git clone https://github.com/tedi-software/tedi.git

   # git clone git@github.com:tedi-software/tedi.git
   ```
2. copy the tedi folder to the directory you want to root TEDI
   ```sh
   cd /path/to/tedi
   cp -pR tedi /opt/
   ```

#### ${\color{949698} ➤}$ Running TEDI
1. start TEDI
   ```sh
   cd /opt/tedi/bin
   ./start.sh
   ```
2. stop TEDI
   ```sh
   cd /opt/tedi/bin
   ./stop.sh
   ```
3. viewing the logs
   ```sh
   cd /opt/tedi/logs
   tail -f tedi_*.log
   ```

> [!NOTE]
> This sample TEDI installation includes binaries for Linux and OSX.

> the MacOSX binaries are not signed and will be put into quarantine on download. To list and subsequently remove from quarantine:
```sh
xattr <binary name>
xattr -d com.apple.quarantine <binary name>
```

<p align="right">(<a href="#top">top</a>)</p>


### ${\color{949698} ➤}$ Usage

##### ${\color{949698} ➤}$ Configuration Files

TEDI uses simple *key-value* property files, like in Java, to configure services. These configuration files support multiline values, comments, environment variable injection, and you can even link to other property files by using the keyword *.include*. By using .include, you can break apart your configurations into smaller, more manageable pieces and is an excellent way of reusing common settings between processors.


view <span style="font-size:0.80em;">``` /tedi/services/archetypes ```</span> for more examples.


##### ${\color{949698} ➤}$ Building an Integration

To build an integration, you will define a *workflow*, a series of *processors* executing in sequence, in a file called <span style="font-size:0.80em;">``` service.properties ```</span>; which is the entry point for all integrations.

A **processor** is an independent module that represents sending or receiving data via a protocol like https, reading/writing records to a database, or interfacing with a message bus (e.g NATS).

At startup, TEDI will scan all the directories under <span style="font-size:0.80em;">``` tedi/services/ ```</span> looking for <span style="font-size:0.80em;">``` service.properties ```</span> files. When it finds one, it will load all the listed services, create a workflow, and begin executing it. This in effect means that in a single TEDI process, you can run a single service (integration), a set of related services, or as many as you like; there's no limit on the number of services you can run. This also means that if you want to prevent an integration from running, you can simply rename the <span style="font-size:0.80em;">``` service.properties ```</span> to something like <span style="font-size:0.80em;">``` ignore_service.properties ```</span>  and TEDI will not load that service.

For some working examples, view <span style="font-size:0.80em;">``` /tedi/services/examples ```</span>.


<p align="right">(<a href="#top">top</a>)</p>
<a id="demo"></a>

### ${\color{949698} ➤}$ Demo

Many example services can be found under <span style="font-size:0.80em;">``` /tedi/services/examples ```</span>.

For this simple demo, we'll use the <span style="font-size:0.80em;"> ``` cmd ``` </span> example.

The <span style="font-size:0.80em;">``` cmd ```</span> example demonstrates the stitching together of two *processors* to form a *service interface* or *integration*. 
This particular interface is driven by two shell scripts (*commands*): 
1. one to create input.
2. the second to receive input from the first shell and act on it.

note: the input script will run indefinately.

( these commands assume you rooted tedi under /opt/ )

First follow the installation steps.

```sh
cd /opt/tedi/services/examples/cmd
mv ignore_service.properties service.properties
cd /opt/tedi/bin
./start.sh
```

<p align="right">(<a href="#top">top</a>)</p>


### ${\color{949698} ➤}$ Supported Protocols
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


### ${\color{949698} ➤}$ Roadmap
- [] AS2
- [] Kafka
- [] Azure ADLS
- [] Azure EventHub

See the [open issues](https://github.com/tedi-software/tedi/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">top</a>)</p>


### ${\color{949698} ➤}$ Support
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
