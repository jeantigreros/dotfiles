# dotfiles
my personal dotfiles, proceed with caution!, this are my configs for my pc/laptop so careful.

![20230617_21h08m29s_grim](https://github.com/jeantigreros/dotfiles/assets/85091862/58caad8c-39fb-443d-b966-c9f3856799d3)

## INFORMATION

Hyprland as Wayland tiling compositor, 

### [Wallpapers](https://github.com/jeantigreros/dotfiles/tree/50bd571c740f591466165548e66222e18b5147dd/wallpapers)
> also here are some of cool wallpapers (https://github.com/iamdevnitesh/nord-wallpapers/tree/main/wallpapers)

### Installing needed dependencies
```sh
paru -S hyprland-git polkit-kde-agent dunst rofi
xdg-desktop-portal-hyprland-git qt5-wayland qt6-wayland
waybar-hyprland-git zsh firefox starship thunar cava git
discord rofi ranger variety hyprshot nomacs
```
- Cloning the repository
```sh
cd ~/ && git clone https://github.com/jeantigreros/dotfiles.git
```

**Extras*
```sh
# themes
paru -S bibata-cursor-theme arc-darkest adwaita-icon-themes nwg-look
# Music-player
paru -S youtube-music-bin
```

#### As fonts i'm  using Cartographh CF
```sh
mkdir -p $HOME/Downloads/nerdfonts/
cd $HOME/Downloads/
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.1/CascadiaCode.zip
unzip '*.zip' -d $HOME/Downloads/nerdfonts/
rm -rf *.zip
sudo cp -R $HOME/Downloads/nerdfonts/ /usr/share/fonts/
```
#### Regenerate Font Cache
```sh
fc-cache -rv
```

## some links

* **Window Manager** • [Hyprland ](https://github.com/hyprwm/Hyprland)
* **Shell** • [Zsh ](https://www.zsh.org) with [starship](https://github.com/starship/starship)
* **Terminal** • [WezTerm ](https://github.com/wez/wezterm) 
* **Panel** • [Waybar ](https://aur.archlinux.org/packages/waybar-hyprland-git) 
* **Notify Daemon** • [Dunst ](https://github.com/dunst-project/dunst)
* **Launcher** • [Rofi ](https://github.com/davatorium/rofi) 
* **File Manager** • [Ranger ](https://github.com/ranger/ranger)
* **Music Player** • [Youtube Music App ](https://github.com/th-ch/youtube-music)

### Keybind

All the keybinds are [here](https://github.com/jeantigreros/dotfiles/blob/5b56554a9f50bbdf70ca340186558b6384c67ee0/hypr/cheatsheet.md)

### **Setup config files** \
> copy all respective config files in their locations

## Credits

[linuxmobile](https://github.com/linuxmobile/hyprland-dots)
