# RevyTeX [![Build Status](https://travis-ci.org/dikurevy/RevyTeX.svg?branch=master)](https://travis-ci.org/dikurevy/RevyTeX)

LaTeX environment and scripts for the science revues at University of Copenhagen.

## Installation

RevyTeX requires Perl and a latex distribution.

To install the required perl packages, execute the following commands:

```
sudo cpan -i App::cpanminus
sudo cpanm --notest --installdeps .
```

## Usage

To make a new revue folder:

```
cd RevyTeX
make ../NewRevue
```

To compile a manuscript:

```
cd NewRevue

gedit aktoversigt.plan
# Format for file is:
#
# Akt 1
# sange/song1.tex
# sketches/sketch1.tex
# sketches/sketch2.tex
#
# Akt 2
# sange/song2.tex
# etc...

make
```
