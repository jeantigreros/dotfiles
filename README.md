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
- application runner = rofi
- bar = waybar - font: mononoki
- font = mononoki
- prompt = starship
- wallpaper = hyprpaper
- screenshot = hyprshot
- sound controller = pavucontrol
- dark theme = qt6ct
- brightness control = brightnessctl
- network discovery = networkmanager
- pdf viewer = zathura, zathura-pdf-mupdf
- utility for manual = man
- sddm theme = [astronaut](https://github.com/Keyitdev/sddm-astronaut-theme)
- video and music player = mpv
- fonts = ttf-hack-nerd ttf-ubuntu-mono-nerd ttf-mononoki
- shell = fish
- clipboard manager = wl-clipboard, cliphist
- **if arch then yay reflector :] i'm not asking**

# installation - arch

1. first install yay, then

```
yay dunst rofi reflector ttf-ubuntu-mono-nerd ttf-hack-nerd ttf-mononoki-nerd  mpv hyprpaper hyprshot pavucontrol qt6ct brightnessctl starship zathura zathura-pdf-mupdf
```

2. source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems

```
echo ".cfg" >> .gitignore
```

3. clone the dotfiles into a bare repository in a "dot" folder of your $HOME:

```
git clone --bare https://github.com/jeantigreros/dotfiles-new $HOME/.cfg
```

4. define the alias in the current shell scope

```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

5. checkout the actual content from the bare repository to your $HOME:

```
config checkout
```

6. if the step above fial with a message like this:

```
error: The following ...
  .bashrc
  .gitignore
Please move or remove blablabla
Aborting
```

its because yor $HOME folder might already have some stock config files wich would be overwritten by Git. backup the files.

```
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}
```

7. run again the command

```
config checkout
```

8. set the flag showUntrackedFiles to no on this specific (local) repository

```
config config --local status.showUntrackedFiles no
```

9. you're done :]

---

Personal mod

login.conf -> handlelid suspend

if ssd then activate trim

# Postdata

i used figlet for the fancy text
