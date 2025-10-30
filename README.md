# Mis Dotfiles

¡Bienvenido a mis dotfiles! Este repositorio contiene mi configuración personal para un entorno de escritorio Linux moderno y personalizado, centrado en [Hyprland](https://hyprland.org/), un compositor dinámico de Tiling para Wayland.

## Filosofía

Mi objetivo es tener un entorno de escritorio que sea a la vez funcional y estéticamente agradable, con un flujo de trabajo eficiente y centrado en el teclado. La configuración está diseñada para ser modular y fácil de mantener.

## Componentes Principales

| Componente              | Aplicación                                                 | Ubicación de la Configuración                                 |
| ----------------------- | ---------------------------------------------------------- | ------------------------------------------------------------- |
| **Compositor Wayland**  | [Hyprland](https://hyprland.org/)                          | `~/.config/hypr/`                                             |
| **Barra de Estado**     | [Waybar](https://github.com/Alexays/Waybar)                | `~/.config/waybar/`                                           |
| **Lanzador**            | [Rofi](https://github.com/davatorium/rofi)                 | `~/.config/rofi/`                                             |
| **Terminal**            | [Kitty](https://sw.kovidgoyal.net/kitty/)                  | `~/.config/kitty/kitty.conf`                                  |
| **Shell**               | [Zsh](https.www.zsh.org/)                                  | `~/home/Arch/.zshrc`                                          |
| **Editor de Código**    | [Neovim](https://neovim.io/)                               | `~/.config/nvim/`                                             |
| **Notificaciones**      | [Swaync](https://github.com/Lentil-Soup/swaync)            | `~/.config/swaync/`                                           |
| **Pantalla de Bloqueo** | [Hyprlock](https://github.com/hyprwm/hyprlock)             | `~/.config/hypr/hyprlock.conf`                                |
| **Gestor de Archivos**  | [Ranger](https://ranger.github.io/) / [PCManFM](https://wiki.archlinux.org/title/PCManFM) | `~/.config/ranger/` / `~/.config/pcmanfm/` |
| **Theming**             | [Pywal](https://github.com/dylanaraps/pywal) / Kvantum     | Scripts en `~/.config/biglexj/`                               |

## Características Destacadas

*   **Theming Dinámico:** Los colores se generan a partir del fondo de pantalla actual usando `pywal` y se aplican a Waybar, Rofi, Kitty y otros componentes para una apariencia cohesiva.
*   **Scripts Personalizados:** Una colección de scripts en `~/.config/biglexj/scripts/` para gestionar fondos de pantalla, atajos de teclado, notificaciones y más.
*   **Menús de Control con Rofi:** Menús interactivos para gestionar Wi-Fi, portapapeles y otras utilidades del sistema.
*   **Configuración Modular de Hyprland:** Los archivos de configuración de Hyprland están divididos en `~/.config/hypr/conf/` para una mejor organización (animaciones, atajos, reglas de ventanas, etc.).
*   **Integración con GTK y Qt:** Se utilizan Kvantum, `qt5ct` y `qt6ct` para asegurar que las aplicaciones gráficas sigan el tema general del sistema.

## Instalación

**Advertencia:** Estos dotfiles están altamente personalizados. Se recomienda hacer un fork y adaptarlos a tus propias necesidades en lugar de clonarlos directamente.

1.  **Clona el repositorio:**
    ```sh
    git clone https://github.com/tu_usuario/dotfiles.git
    ```

2.  **Instala las dependencias:**
    Asegúrate de tener instaladas todas las aplicaciones mencionadas en la tabla de "Componentes Principales". Los nombres de los paquetes pueden variar según tu distribución de Linux.

3.  **Crea Enlaces Simbólicos:**
    Puedes usar un gestor de dotfiles como `stow` o crear los enlaces manualmente. Por ejemplo:
    ```sh
    ln -s /ruta/a/tus/dotfiles/.config/hypr ~/.config/hypr
    ln -s /ruta/a/tus/dotfiles/.config/waybar ~/.config/waybar
    # ... y así sucesivamente para las demás configuraciones.
    ```

4.  **Recarga la configuración:**
    Reinicia tu sesión de Hyprland para que todos los cambios surtan efecto.

## Atajos de Teclado

Los atajos de teclado más importantes están definidos en `~/.config/hypr/conf/binds.conf` y `~/.config/hypr/conf/binds-apps.conf`. Algunos de los atajos por defecto son:

*   `Super + Enter`: Abrir terminal (Kitty)
*   `Super + D`: Abrir lanzador de aplicaciones (Rofi)
*   `Super + Q`: Cerrar ventana activa
*   `Super + [1-9]`: Cambiar a espacio de trabajo

¡Espero que disfrutes de la configuración!
