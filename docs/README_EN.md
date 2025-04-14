# HYPR Star Dotfiles Configuration

## Overview
This repository contains my personal dotfiles configuration for Hyprland, a dynamic tiling Wayland compositor, designed to create a modern and efficient Linux desktop environment.

## 🌟 Features
- Hyprland window manager configuration
- Custom-themed Waybar 
- Optimized keybindings for productivity
- Terminal configuration (Kitty)
- Application launcher setup (Rofi)
- Dynamic wallpaper management
- Custom scripts and utilities

## 📋 Requirements
- Arch Linux or compatible distribution
- Hyprland
- Waybar
- Kitty terminal
- Rofi
- swww (wallpaper daemon)
- pipewire/wireplumber (audio)
- Network Manager
- brightnessctl
- playerctl

## 🚀 Quick Start
1. Clone this repository:
```bash
git clone https://github.com/biglexj/HYPR-Star-dotfiles.git ~/.config/
```

2. Install dependencies:
```bash
paru -S hyprland waybar kitty rofi swww pipewire wireplumber
```

3. Copy configurations:
```bash
cd ~/.config/HYPR-Star-dotfiles
./install.sh
```

## ⚙️ Configuration Structure
```
.
├── hypr/
│   ├── hyprland.conf
│   └── scripts/
├── waybar/
│   ├── config
│   └── style.css
├── rofi/
├── kitty/
└── scripts/
```

## 🎨 Customization
- Edit `~/.config/hypr/hyprland.conf` for window manager settings
- Modify `~/.config/waybar/config` for status bar customization
- Adjust themes in `~/.config/rofi/` for application launcher

## 🛠️ Keybindings
- `SUPER + Return` - Open terminal
- `SUPER + Q` - Close active window
- `SUPER + Space` - Launch application menu
- `SUPER + Shift + Q` - Exit Hyprland
- Check `hyprland.conf` for full keybinding list

## 📝 Contributing
Feel free to fork this repository and submit pull requests. For major changes, please open an issue first.

## 📜 License
This project is licensed under the MIT License - see the LICENSE file for details

## 🙏 Acknowledgments
- Hyprland community
- r/unixporn for inspiration
- Various dotfile creators who shared their configurations

## 📸 Screenshots
[Add your screenshots here]

## 🐛 Troubleshooting
Common issues and solutions can be found in the wiki section.

For additional support, please open an issue on GitHub.