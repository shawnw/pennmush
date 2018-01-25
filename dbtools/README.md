% Database Tools

Introduction
============

dbtools is a library and set of utilities for examining, transforming,
and editing PennMUSH database files. Unless otherwise specified, all
programs can work with either uncompressed databases, or ones
compressed with compress (**.Z**), gzip (**.gz**) or bzip2 (**.bz2**).

The only currently supported database version is the one written by
Penn 1.8. The ability to read older versions will be added, but it is
unlikely support for writing older database versions will be added.

It does not currently support mail or chat databases.

Building
========

dbtools programs are written in C++, not C like Penn itself. They
depend on OpenSSL, and the [boost.iostreams] library as well as some
header-only boost libraries. The latter can be installed on Ubuntu
like systems with `apt install libbost-dev
libboost-iostreams-dev`. `cmake` is used for configuration and
creating Makefiles.

To build:

    % cd dbtools
    % cmake -DCMAKE_BUILD_TYPE=Release .
    % make -j4

The Utilities
=============

dbupgrade
---------

Read a database in any supported format, and write out the database
in the current format.

### Options

-z

:    Database is compressed with gzip.

-Z

:    Database is compressed with compress.

-j

:    Database is compressed with bzip2.

-i

:    Modify the database file in-place. If not given, the database is
printed to standard output.

If a filename is not given on the command line, standard input is used.

### Examples

To upgrade an old, uncompressed database: `dbtools/dbupgrade
game/data/outdb > game/data/indb`

To upgrade an old, compressed database in place: `dbtools/dbupgrade -Z
game/dta/outdb.Z`

pwutil
------

A replacement for `utils/pwutil.pl`, this program lets you alter
passwords of players. Handy if, for example, you forgot God's
password.

### Options

-d DBREF | -a 

:    Specifies a particular player dbref (Without the \#), or `-a` for
all players. One of these two options **must** be given.

-p PASSWORD

:    The password to use. The default is *hunter2*

-c

:     Instead of setting a password, erase it. `-ac` clears all players
passwords.

-z

:    The database file is gzipped.

-Z

:    Database is compressed with compress.

-j

:    Database is compressed with bzip2.

-i

:    Modify the database file in place. If not given, the modified db is
printed to standard output.


If a filename is not given on the command line, standard input is used.

### Examples

To reset #1's password to *foobar*: `dbtools/pwutil -iz -d 1 -p foobar
game/data/outdb.gz`

To erase every player's passwords in a new database: `dbtools/pwutil
-acz game/data/outdb.gz > newdb.gz` 

db2dot
------

Creates a graph of the database's rooms and exits in the dot language
used by [graphviz]. Graphviz tools can then be used to visualize the
grid, and manipulate the graph first if desired.

Exits without locks are represented by solid lines, exits with locks
by dashed.

If a room or exit has a *COLOR* attribute, its value is used as the
color for that part of the graph. (TODO: Parse *MONIKER* attributes?)

If an exit has a *DISTANCE* attribute that is an integer, its value is
used as the length of that edge (Used by some graphviz utilities like
`dijsktra`).

### Options

-z

:    Indicates the database is gzipped.

-Z

:    Database is compressed with compress.

-j

:    Database is compressed with bzip2.

If a filename is not given on the command line, standard input is used.
The resulting graph is always printed to standard output.

### Examples

To create a map of your world: `dbtools/db2dot -z
game/data/outdb.gz | dot -Tsvg > world.svg`. It might look like ![this sample].

To limit the output to only rooms reachable from #0: `dbtools/db2dot
-z game/data/outdb.gz | ccomps -X room0 > grid.dot`

[graphviz]: https://graphviz.org
[this sample]: world.svg
[boost.iostreams]: https://www.boost.org/doc/libs/1_66_0/libs/iostreams/doc/index.html