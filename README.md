# dotfiles
After cloning the repo, run the install script to automatically set up the development environment.
The install script is idempotent: it can safely be run multiple times.
Call the script with an appropriate argument (depending on the computer):
```bash
$ ./install manjaro-desktop # on manjaro desktops
$ ./install mac-desktop     # on mac desktops
$ ./install ubuntu-server   # on ubuntu servers
$ ./install arch-server     # on arch servers
````

The repository uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.
