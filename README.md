# s390x-abi

## Scope

This repository contains the LaTeX source for the s390x ELF ABI document.

## Documentation

The s390x ELF ABI specification is available online at:

**https://ibm.github.io/s390x-abi/**

You can download the current PDF version directly from the website.

For advertised versions and release history, see the project's
["Releases"][releases] section.

## Usage

In order to build the PDF yourself from source, you need:

* a full TeX installation (such as [TeX Live][texlive])
  * including latexmk, LuaTeX, and the various LaTeX packages used by the
    document
* the [IBM Plex][plex] fonts
* GNU Make

Then just typing

    $ make

should generate `lzsabi_s390x.pdf`.

It is also possible to build the 32-bit s390 ELF ABI from the same
sources.  The target is called `lzsabi_s390.pdf`.  To build both, use

    $ make all-pdf

However, note that this is not maintained as actively as the 64-bit ABI.

Experimental support for other targets exists, such as for HTML output via
[TeX4ht][tex4ht], and for plain text with [ELinks][elinks].  See the
Makefile for more information.

## Reporting Issues

If you find an issue in the specification or in the LaTeX source, please
report it by creating a new [issue here][new-issue].

## License

This project is licensed under the GNU Free Documentation License, Version
1.1; with no Invariant Sections, with no Front-Cover Texts, and with no
Back-Cover Texts.  More information can be found in the LICENSE file or
online at

    https://www.gnu.org/licenses/old-licenses/fdl-1.1.txt

[elinks]: http://elinks.or.cz
[new-issue]: https://github.com/ibm/s390x-abi/issues/new
[plex]: https://github.com/IBM/plex
[releases]: https://github.com/IBM/s390x-abi/releases
[tex4ht]: https://tug.org/tex4ht
[texlive]: https://www.tug.org/texlive
