```
 __  __            _
|  \/  |_   _     / \__      _____  ___  ___  _ __ ___   ___
| |\/| | | | |   / _ \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \
| |  | | |_| |  / ___ \ V  V /  __/\__ \ (_) | | | | | |  __/
|_|  |_|\__, | /_/   \_\_/\_/ \___||___/\___/|_| |_| |_|\___|
        |___/
 ____        _    __ _ _           _
|  _ \  ___ | |_ / _(_) | ___  ___| |
| | | |/ _ \| __| |_| | |/ _ \/ __| |
| |_| | (_) | |_|  _| | |  __/\__ \_|
|____/ \___/ \__|_| |_|_|\___||___(_)

```

# Packages

- package manager = distro specific
- notifications = dunst | mako
- application runner = rofi + rofi-calc | wofi
- bar = waybar | swaybar
- font = JetBrainsMono Nerd Font
- prompt = starship
- wallpaper = hyprpaper as backend | waypaper | swaybg
- screenshot = hyprshot | grim + slurp
- file manager = Dolphin | ranger w/ pillow for image preview | thunar
- sound controller = pavucontrol
- dark theme manager = qt6ct
- network = networkmanager
- pdf viewer = zathura, zathura-pdf-mupdf
- sddm theme = [astronaut](https://github.com/Keyitdev/sddm-astronaut-theme)
- video and music player = mpv
- fonts = noto-fonts + emojis + cjk
- shell = bash
- clipboard manager = wl-clipboard + cliphist | xclip
- "IDE"/editor = nvim
- firewall = ufw ( unclomplicated firewall )
- terminal multiplexer = tmux

# Installation
## Dependencies
### Arch

Install yay, then

```bash
yay -S dunst bash-completion rofi rofi-calc archlinux-xdg-menu joystick python-pynvim texlive omnisharp tmux ranger python-pillow python3 waybar mononoki starship hyprpaper hyprshot pavucontrol qt6ct zathura zathura-pdf-mupdf man mpv ttf-hack-nerd ttf-ubuntu-mono-nerd ttf-mononoki noto-fonts noto-fonts-cjk noto-fonts-emoji fish ufw reflector archlinux-xdg-menu ripgrep fzf
```

### Fedora

```bash
dnf install dunst rofi tmux ranger waybar starship pavucontrol qt6ct zathura zathura-pdf-mupdf man mpv ufw ripgrep fzf bash-completion
```
*INCOMPLETE*

### Debian

```bash
apt install mako wofi tmux ranger waybar pavucontrol zathura man mpv ufw ripgrep fzf bash-completion waybar grim slurp wl-clipboard mako-notifier playerctl pipewire pipewire-pulse pipewire-utils pipewire-pulse neovim gcc npm feh imv
```
*INCOMPLETE*

## Install config files

```bash
./install.sh
```
