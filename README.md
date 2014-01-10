# DirWait

Watches and waits for a directory to be created and then exits.

When it detects that specified directory was created, it exits cleanly (exit
code: 0).

This was hacked together as part of a proof-of-concept for which I needed a
portable way to quickly run a command as soon as a specific directory was
created. It served that purpose well, but it isn't very robust.


## Installing

With RubyGems:

    gem install dirwait

With Bundler:

    git clone https://github.com/brandt/dirwait.git
    cd dirwait
    bundle install


## Usage

Example: Copy file as soon as the destination become available:

    dirwait ~/Dropbox/Company && cp -r /tmp/Archive ~/Dropbox/Company/


## Authors

J. Brandt Buckley <brandt@runlevel1.com>

Monkey patches [Listen](https://github.com/guard/listen) to enable reporting
of directory creation events.
