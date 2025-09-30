# 🌟 Biglex J Dotfiles

> Configuración refinada y optimizada de Hyprland - Reconstruida desde cero con la experiencia adquirida

## ✨ Características

- 🎨 Entorno Hyprland completamente personalizado
- 🚀 Configuraciones optimizadas y pulidas
- 📦 Scripts de utilidad organizados
- 🎭 Tema visual cohesivo y elegante
- ⚡ Rendimiento optimizado

## 📦 Componentes Incluidos

### Core
- **Hyprland** - Compositor Wayland
- **Waybar** - Barra de estado elegante
- **Kitty** - Emulador de terminal rápido
- **Rofi** - Lanzador de aplicaciones

### Utilidades
- **fastfetch** - Información del sistema
- **Kvantum** - Temas Qt
- **ranger** - Gestor de archivos en terminal
- **nvim** - Editor de texto Neovim
- **wofi** - Lanzador alternativo Wayland
- **wlogout** - Menú de apagado/cierre

### Gestión de Ventanas
- **hypr** - Configuración principal de Hyprland
- **swaync** - Centro de notificaciones

### Visuales
- **gtk-3.0** - Temas GTK3
- **qt5ct** / **qt6ct** - Configuración Qt
- **kde-material-you-colors** - Esquema de colores Material You

### Otros
- **kate** - Editor de texto KDE
- **qView** - Visor de imágenes ligero
- **pcmanfm** - Gestor de archivos gráfico
- **lsd** - LSDeluxe (ls mejorado)

## 🛠️ Instalación

### Requisitos Previos

```bash
# Arch Linux / Arch-based
sudo pacman -S hyprland waybar kitty rofi swaync \
               fastfetch kvantum ranger neovim \
               gtk3 qt5ct qt6ct lsd
```

### Instalación de Dotfiles

```bash
# 1. Clona el repositorio
git clone https://github.com/biglexj/biglexj-dotfiles.git
cd biglexj-dotfiles

# 2. Respalda tu configuración actual (importante!)
mkdir -p ~/.config/backup
cp -r ~/.config/{hypr,waybar,kitty,rofi} ~/.config/backup/

# 3. Ejecuta el script de instalación
chmod +x biglexj/install.sh  # o el script que tengas
./biglexj/install.sh

# 4. Recarga Hyprland
# Presiona Super + Shift + R o reinicia sesión
```

## 📁 Estructura del Proyecto

```
.
├── biglexj/              # Scripts de instalación y utilidades
├── hypr/                 # Configuración de Hyprland
├── waybar/               # Configuración de Waybar
├── kitty/                # Configuración de Kitty
├── rofi/                 # Temas y configs de Rofi
├── swaync/               # Centro de notificaciones
├── fastfetch/            # Configuración de fastfetch
├── nvim/                 # Configuración de Neovim
├── ranger/               # Configuración de ranger
├── gtk-3.0/              # Temas GTK
├── qt5ct/                # Configuración Qt5
├── qt6ct/                # Configuración Qt6
└── README.md
```

## ⚡ Scripts Disponibles

Los scripts están ubicados en la carpeta `biglexj/`. Algunos ejemplos comunes:

- `install.sh` - Instalación automática de dotfiles
- `theme-switcher.sh` - Cambiar temas
- `wallpaper-changer.sh` - Cambiar fondos de pantalla
- `backup.sh` - Respaldar configuraciones

*(Revisa la carpeta para ver todos los scripts disponibles)*

## 🎨 Personalización

### Cambiar Tema de Colores

```bash
# Edita el archivo de configuración de Hyprland
nvim ~/.config/hypr/hyprland.conf

# O usa el script de temas
~/.config/biglexj/theme-switcher.sh
```

### Modificar Waybar

```bash
nvim ~/.config/waybar/config
nvim ~/.config/waybar/style.css
```

### Atajos de Teclado

Los atajos principales están en `~/.config/hypr/hyprland.conf`. Algunos básicos:

- `Super + Q` - Cerrar ventana
- `Super + Return` - Abrir terminal
- `Super + D` - Rofi/Wofi
- `Super + E` - Gestor de archivos

## 🔧 Solución de Problemas

### Waybar no se muestra
```bash
killall waybar
waybar &
```

### Temas no se aplican
```bash
# Reconstruir caché de GTK
gtk-update-icon-cache
```

### Problemas con Qt
```bash
# Asegúrate de tener las variables de entorno
export QT_QPA_PLATFORMTHEME=qt5ct
```

## 📝 Notas

- Esta es una versión refinada basada en experiencia práctica
- Los scripts en `biglexj/` facilitan la gestión del sistema
- Recomendado para usuarios con conocimientos intermedios de Linux
- Compatible con Arch Linux y derivados

## 🌐 Recursos

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Mi GitHub](https://github.com/biglexj)
- [Mi Canal de YouTube](https://youtube.com/@biglexj)
- [Biglex Dev](https://youtube.com/@biglexdev)

## 🤝 Contribución

¿Encontraste un bug o tienes una mejora? ¡Abre un issue o pull request!

## 📜 Licencia

MIT License - Siéntete libre de usar y modificar

---

**Hecho con ❤️ por [Biglex J](https://biglexj.net.pe)**

*Si te gusta este proyecto, considera darle una ⭐ en GitHub y suscribirte a mi canal de YouTube!*