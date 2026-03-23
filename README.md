# dotfiles
After cloning the repo, run the install script to automatically set up the development environment.
The install script is idempotent: it can safely be run multiple times.
Call the script with an appropriate argument (depending on the computer):
```bash
$ ./install manjaro-desktop # on manjaro desktops
$ ./install mac-desktop     # on mac desktops
$ ./install ubuntu-server   # on ubuntu servers
$ ./install arch-server     # on arch servers
```

The repository uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

## Toggling between light and dark themes

The `bin/toggle-color` script switches between light and dark colorschemes. How it does this depends on each particular app or protocol, but in general:
  - It repoints some symlinks (more on this below).
  - For some apps, it does something extra (e.g., pushes the change to active Neovim instances through RPC sockets). All such app-specific quirks are documented inside the script.

### Architecture

Every application's config follows the same symlink pattern.

#### Apps that support config imports
Most apps' configs can reference other files (e.g., Alacritty, i3, tmux).
This allows us to separate theming from the main config and avoid duplication.
Here's the setup:
```
main config (file) ─imports─▶ theme (symlink)
                                 │
                    ┌────────────┴────────────┐
                    ▼                         ▼
              prefer-light (symlink)    prefer-dark (symlink)
                    │                         │
                    ▼                         ▼
             everforest-light (file)   everforest-dark (file)
```
The leaf files here only contain theme settings.

#### Apps that don't support imports
Some apps only support single file configs (e.g., i3blocks), whcih means we have to duplicate the entire config across theme variants:
```
main config (symlink)
       │
       ├──▶ prefer-light (symlink) ──▶ everforest-light (file, full config)
       └──▶ prefer-dark  (symlink) ──▶ everforest-dark  (file, full config)
```

### Why the two layers of symlinks?

At first glance, it seems simpler to remove all the symlinks and just swap between two `theme` files. An earlier version of the system did exactly that.

Symlinks are better because:
- **They're stateless** - Flipping configs for N apps means working with N pieces of state that can all fall out of sync with each other. With symlinks, `toggle-color` relies on a single source of truth (`gsettings org.gnome.desktop.interface color-scheme`) to set all pointers. That's the only thing that "flips" and depends on the previous state. Everything else just derives from it. Even if configs get out of sync, a single execution of `toggle-color` brings them back in line.
- **They keep the files stable** - The actual config files you edit never move or get renamed. Swapping `foo.config` with `foo.config.other` every time you toggle is a mess for both git and the user.

Ok, but why the second layer? Why not just symlink `theme` directly to `everforest-light` and `everforest-dark`?

Because the `prefer-*` middle layer decouples the toggle script from a specific colorscheme:
 - To switch from Everforest to Gruvbox, you can repoint the `prefer-*` symlinks - without touching `toggle-color` or disrupting the current light/dark state.
 - To switch from light to dark, you can repoint the `theme` symlink to `prefer-dark` or `prefer-light` without knowing which colorscheme is active.
