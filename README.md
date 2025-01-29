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

- package manager = yay
- notifications = dunst
- application runner = rofi + rofi-calc
- bar = waybar 
- font = mononoki
- prompt = starship
- wallpaper = hyprpaper
- screenshot = hyprshot
- file manager = Dolphin | ranger w/ pillow for image preview
- sound controller = pavucontrol
- dark theme manager = qt6ct
- network = networkmanager
- pdf viewer = zathura, zathura-pdf-mupdf
- utility for manuals = man
- sddm theme = [astronaut](https://github.com/Keyitdev/sddm-astronaut-theme)
- video and music player = mpv
- fonts = ttf-hack-nerd ttf-ubuntu-mono-nerd ttf-mononoki noto-fonts + emojis + cjk
- shell = fish
- clipboard manager = wl-clipboard + cliphist 
- IDE/editor = nvim
- firewall = ufw ( unclomplicated firewall )
- install reflector :] **must**
- terminal multiplexer = tmux
- brightness control = brightnessctl
- power management = tlp
- intel microcode = intel-ucode

# installation - arch

1. first install yay, then

```bash
yay -S dunst rofi rofi-calc tmux ranger python-pillow python3 waybar mononoki starship hyprpaper hyprshot pavucontrol qt6ct zathura zathura-pdf-mupdf man mpv ttf-hack-nerd ttf-ubuntu-mono-nerd linux-headers ttf-mononoki noto-fonts noto-fonts-cjk noto-fonts-emoji fish ufw reflector archlinux-xdg-menu ripgrep fzf python-nvim texlive

2. source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems

```bash
echo ".cfg" >> .gitignore
```

3. clone the dotfiles into a bare repository in a "dot" folder of your $HOME:

```bash
git clone --bare https://github.com/jeantigreros/dotfiles $HOME/.cfg
```

4. define the alias in the current shell scope
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

5. checkout the actual content from the bare repository to your $HOME:

```
config checkout
```

6. if the step above fail with a message like this:

```bash
error: The following ...
  .bashrc
  .gitignore
Please move or remove ... 
Aborting
```

It's  because your $HOME folder might already have some stock config files which would be overwritten by Git. Backup the files.

```bash
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

7. run again the command

```bash
config checkout
```

8. set the flag showUntrackedFiles to no on this specific (local) repository

```bash
config config --local status.showUntrackedFiles no
```
9. source the tmux file
```bash
tmux source ~/.config/tmux/tmux.conf
```
10. you're done :]

---

Personal mod

if you have a ssd then you maybe want to activate trim

# Postdata

i used figlet for the fancy text
