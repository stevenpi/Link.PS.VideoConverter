# Video Converter
The purpose of the video converter is to save space from many different large captures (i.e. from game capturing).
it converts h264 coded `.mp4` files into h265 coded `.mp4` files.

## Requirements
* A usable `ffmpeg.exe` is needed (needs to be configured in `config.xml`). Either compile your own binaries from the [official sites](https://www.ffmpeg.org/), or download [Shotcut](https://shotcut.org/) (easier way, download portable version), which contains ffmpeg.exe!

## Setup & Usage
1. Copy `config.xmlexample` and paste it as `config.xml`
2. Change the values inside the freshly created `config.xml` to your liking
3. Start a powershell, `cd` into the directory of the repo
4. Run `.\video_converter.ps1`
