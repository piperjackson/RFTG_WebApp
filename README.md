This project is a replacement HTML/JS GUI for Race for the Galaxy card game AI created by Keldon James.
The original project page can be found here: http://keldon.net/rftg/

## BUILD REQUIREMENTS

* `cards.txt`, `campaign.txt` and `images.data` files from the Desktop version
* emscripten (`emcc` should be in path)
* ImageMagick (specifically `convert` executable)
* GTK+ 2.0 development packages (only for desktop version)

## BUILD INSTRUCTIONS

Put `cards.txt`, `campaign.txt` and `images.data` in the main directory of the repository.

Build HTML GUI in the local directory

    make

Build and install in the specified directory

    INSTALLDIR=<http served directory> make install

Build a zipped webapp package

    make rftg_webapp.zip

Build the standard desktop version

    make rftg

The resulting files should be accessed through a http server. Using local file access may work to some extent depending on the browser used, but is not recommended.
*DO NOT* put this web app on publicly accessible addresses. While the code is open under GPL, the copyrighted files are distributed under a separate license.

## LEGAL

The source code is copyrighted and is placed under the GPL. For details,
see the file COPYING.

The original game of Race for the Galaxy was designed by Tom Lehmann and
published by Rio Grande Games.

The original Race for the Galaxy AI was written by Keldon James and B. Nordli.
