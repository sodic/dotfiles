# Theming system
NOTE: Claude wrote this file when I prompted him to document my theming system in detail. It's a good reference and I'm pretty sure there are no mistakes, but still...

This document describes how the light/dark theme toggle works across all applications. For the high-level architecture (symlink pattern, why symlinks, why two layers), see [../README.md](../README.md).

## Source of truth

`gsettings org.gnome.desktop.interface color-scheme` (`prefer-light` or `prefer-dark`).

`toggle-color` flips this first, reads back the new value, and uses it to set everything else. The symlink names (`prefer-light`, `prefer-dark`) match the gsettings values exactly - no string manipulation needed.

Keybinding: `$mod+c` (defined in `i3/config`).

## Per-application details

### Alacritty (terminal emulator)

- **Config location**: `alacritty/alacritty.toml` imports `theme.toml`
- **Theme files**: `alacritty/everforest_light.toml`, `alacritty/everforest_dark.toml`
- **Symlink chain**: `theme.toml` -> `prefer-light.toml` -> `everforest_light.toml`
- **How it reloads**: Alacritty watches all config files (main + imports) via inotify (the `notify` crate on Linux). The script touches `alacritty.toml` to ensure Alacritty re-resolves the symlink and reloads.
- **Live update**: Yes, instant.

### i3 (window manager)

- **Config location**: `i3/config` uses `include ~/.config/i3/theme` to pull in window border colors and the `bar {}` block
- **Theme files**: `i3/themes/everforest-light`, `i3/themes/everforest-dark`
- **Symlink chain**: `i3/theme` -> `themes/prefer-light` -> `themes/everforest-light`
- **How it reloads**: `i3-msg reload` re-reads the config and applies new window colors.
- **Live update**: Yes, instant.

### i3blocks (status bar)

- **Config location**: `i3/i3blocks.conf` (symlink - i3blocks can't import)
- **Theme files**: `i3/i3blocks/everforest-light.conf`, `i3/i3blocks/everforest-dark.conf` (full configs, duplicated because i3blocks has no import mechanism)
- **Symlink chain**: `i3blocks.conf` -> `i3blocks/prefer-light.conf` -> `i3blocks/everforest-light.conf`
- **How it reloads**: i3blocks reads its config once at startup and has no reload mechanism. The script kills i3bar (which spawned i3blocks) and restarts it: `pkill i3bar; i3bar &`. The new i3bar spawns a fresh i3blocks that reads the updated symlink. An alternative would be `i3-msg restart` (which restarts everything including i3bar), but it causes too much screen flashing.
- **Live update**: Yes, but via kill/restart.

### tmux (terminal multiplexer)

- **Config location**: `tmux/tmux.conf` sources `theme.conf`
- **Theme files**: `tmux/everforest-light.conf`, `tmux/everforest-dark.conf` (window background colors and status bar plugin colors)
- **Symlink chain**: `theme.conf` -> `prefer-light.conf` -> `everforest-light.conf`
- **How it reloads**: `tmux source-file ~/.config/tmux/tmux.conf` - tmux re-reads the full config, which re-sources the now-repointed `theme.conf`.
- **Live update**: Yes, applies to all running sessions.

### Neovim (text editor)

- **Config location**: No theme config files. Nvim's Everforest colorscheme reacts to the `background` option (`light` or `dark`).
- **New instances**: Auto-detect light/dark by querying the terminal's background color via OSC 11. Since Alacritty has already swapped themes by this point, new nvim instances pick up the right variant automatically. This works as long as the nvim config doesn't hardcode `set background=` (it doesn't).
- **Running instances**: The script finds all nvim RPC sockets at `/run/user/$UID/nvim.*.0` and sends `set background=light` or `set background=dark` via `nvim --server --remote-expr`.
- **Live update**: Yes, instant via RPC.

### GTK3/GTK4 apps (Nemo, Zathura, Pavucontrol, etc.)

This is the most complex part of the system because GTK on i3 (X11, without `gnome-settings-daemon`) has three independent settings channels:

1. **XSettings via xsettingsd** - The primary channel for live updates. GTK3 and GTK4 apps on X11 read `Net/ThemeName` from the XSettings protocol. The script updates `xsettingsd/xsettingsd.conf` with `sed` and sends `SIGHUP` to xsettingsd, which re-reads its config and pushes the new values to all GTK apps via X11 PropertyNotify events. This is the only channel that provides live theme updates. xsettingsd is started by i3 (`exec --no-startup-id xsettingsd` in `i3/config`).

2. **gsettings (dconf)** - GTK apps on X11 do NOT read `gtk-theme` from dconf directly (that code path only exists in the Wayland backend). The script sets it anyway to keep dconf in sync, which is useful for tools like `lxappearance` and in case `gnome-settings-daemon` is ever present.

3. **`~/.config/gtk-3.0/settings.ini` / `gtk-4.0/settings.ini`** - Static fallback read only at app startup, and only when xsettingsd isn't running. Not updated by the script.

GTK theme names (`prefer-light`, `prefer-dark`) resolve via symlinks in `~/.local/share/themes/` and `~/.local/share/icons/` to the actual Everforest GTK theme and icon directories. These symlinks are managed by dotbot (`manjaro-desktop.conf.yaml`).

- **Live update**: Yes, via xsettingsd SIGHUP.

### Electron apps (VS Code, Discord, Obsidian)

- **How they detect dark mode**: Via `xdg-desktop-portal`'s `org.freedesktop.portal.Settings` D-Bus interface. The portal backend (`xdg-desktop-portal-gtk` on i3) reads `org.gnome.desktop.interface color-scheme` from gsettings/dconf and exposes it as the standardized `org.freedesktop.appearance color-scheme` key. Chromium (which Electron apps are built on) subscribes to the portal's `SettingChanged` D-Bus signal. This is handled entirely by `swap_freedesktop` - no app-specific code needed.
- **Requirements**: `xdg-desktop-portal` and `xdg-desktop-portal-gtk` installed (see `packages/gui`). Both are D-Bus activated - systemd starts them on demand.
- **Live update**: Generally yes for VS Code and Discord. Obsidian may require a restart.

### Dunst (notification daemon)

- **Config location**: `dunst/dunstrc` (base config, no colors). Colors come from a drop-in override in `dunst/dunstrc.d/theme.conf`.
- **Theme files**: `dunst/dunstrc.d/everforest-dark`, `dunst/dunstrc.d/everforest-light` (no `.conf` extension so dunst doesn't read them directly - only `theme.conf` has the `.conf` extension)
- **Symlink chain**: `dunstrc.d/theme.conf` -> `prefer-dark` -> `everforest-dark`
- **How it reloads**: `dunstctl reload` tells dunst to re-read its config (base + drop-ins).
- **Live update**: Yes, instant.

### Rofi (application launcher)

- **Config location**: `rofi/config.rasi.monitor` (or `config.rasi.laptop`) with `@import "theme"` at the top
- **Theme files**: `rofi/everforest-dark.rasi`, `rofi/everforest-light.rasi`
- **Symlink chain**: `theme.rasi` -> `prefer-dark.rasi` -> `everforest-dark.rasi`
- **How it reloads**: Rofi is ephemeral - it launches fresh each time you invoke it and exits after selection. No reload mechanism exists or is needed.
- **Live update**: N/A (next launch picks up the new theme).

### Apps that inherit terminal colors (no config needed)

These apps use ANSI colors or terminal capabilities and automatically follow whatever Alacritty's theme is:
- **bat** - uses `--theme="ansi"`, inherits terminal palette
- **ranger** - uses `colorscheme nonbright`, inherits terminal palette
- **tig** - uses named colors (`black`, `green`, etc.), inherits terminal palette
- **fzf**, **grep**, and other CLI tools that use ANSI colors

## Communication summary

| App | Config change | Reload mechanism | Live? |
|-----|--------------|------------------|-------|
| FreeDesktop (Electron, libadwaita) | gsettings `color-scheme` | D-Bus signal via xdg-desktop-portal | Yes |
| Alacritty | Symlink repoint + touch | inotify | Yes |
| i3 | Symlink repoint | `i3-msg reload` | Yes |
| i3blocks | Symlink repoint | Kill i3bar + restart | Yes (restart) |
| tmux | Symlink repoint | `tmux source-file` | Yes |
| Neovim | None (RPC only) | `nvim --server --remote-expr` | Yes |
| GTK3/GTK4 | `sed` on xsettingsd.conf + gsettings | `SIGHUP` to xsettingsd | Yes |
| Dunst | Symlink repoint | `dunstctl reload` | Yes |
| Rofi | Symlink repoint | None needed | Next launch |
| bat, ranger, tig, fzf | None needed | Inherits terminal ANSI colors | Automatic |
