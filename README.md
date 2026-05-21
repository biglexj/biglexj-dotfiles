# 💎 biglexj-dotfiles (ROOT - Orquestador Multi-Perfil)

¡Bienvenido a mi repositorio principal de configuraciones de sistema! Este repositorio actúa como el **orquestador central (ROOT)** para arrancar y configurar de forma completamente automatizada un entorno Linux vPremium (centrado en Hyprland, Waybar, Zsh, y SDDM), ofreciendo dos perfiles distintos según tus necesidades.

El instalador principal está diseñado para ejecutarse mediante **un solo comando `curl` (One-Command Bootstrapper)**. Está pensado para ejecutarse en sistemas limpios: tú solo ejecutas el comando, seleccionas tu perfil, vas a tomar un té, y al regresar tienes tu entorno de escritorio 100% configurado y listo para usar.

---

## 🎭 Perfiles Disponibles

Al ejecutar el script de instalación principal `install.sh`, se presentará un menú interactivo premium para elegir entre dos perfiles:

1. **🍀 Perfil Base (Normal):**
   * Diseñado para un entorno de escritorio Hyprland premium, sumamente rápido y optimizado.
   * **Componentes:** Hyprland, Waybar, Rofi, Kitty, Dunst, fastfetch.
   * **Navegador:** Brave Browser configurado por defecto (Firefox desinstalado automáticamente).
   * **Temas:** Copia y despliegue del tema de terminal real Zsh (`Terminal-Linux-Theme`) y de la pantalla de acceso SDDM (`hypr-ely-neon`).
   * **Utilidades:** Selector gráfico de fondos `waypaper` (con backend dinámico `awww`/`swww`) e intercambio de archivos en red local (`localsend-bin`).

2. **🔥 Perfil Prime (Vitamina / Premium Completo):**
   * Orientado a creadores de contenido, artistas digitales y desarrolladores.
   * **Todo el Stack Base:** Incluye el 100% de la configuración y herramientas del Perfil Base.
   * **Herramientas Creativas y de Desarrollo:** Instala nativamente **OBS Studio**, **Krita**, **Blender**, **VS Code (`code`)** y el motor de temas Qt **Kvantum**.
   * **Dictado por Voz Offline:** Descarga, compila y configura el asistente inteligente **Vocalinux** con rutinas de auto-corrección de enlace dinámico para Python.

---

## 🚀 Filosofía de la Arquitectura Modular

Para garantizar que el instalador sea **fácil de mantener, escalar y auditar**, hemos dividido la lógica de instalación en sub-scripts modulares clasificados **por tecnología** dentro de la carpeta `scripts/`:

1. **`install.sh` (Orquestador Raíz):** Muestra el selector premium de perfiles en consola y coordina el flujo secuencial llamando a los sub-scripts. Al finalizar, copia de forma limpia las configuraciones de la carpeta `.config/` del repositorio a tu `~/.config/` y despliega la colección de wallpapers en `~/Imágenes/Wallpapers/`.
2. **`scripts/install_pacman.sh` (Sistema Nativo):** Gestiona la instalación de paquetes esenciales base de Arch Linux (incluyendo el gestor de fondos nativo `awww`), y desinstala Firefox.
3. **`scripts/install_prime.sh` (Productividad Prime):** Instala las herramientas extras del Perfil Prime vía pacman (`obs-studio`, `krita`, `blender`, `code`, `kvantum`).
4. **`scripts/install_yay.sh` (Comunidad AUR):** Instala el asistente de AUR `yay` si falta, descarga paquetes de la comunidad y configura Brave como predeterminado.
5. **`scripts/install_pip.sh` (Python):** Asegura y valida la disponibilidad de Python y `pip` para utilidades de comandos.
6. **`scripts/setup_zsh.sh` (Terminal & Shell):** Clona `Terminal-Linux-Theme.git` a un directorio temporal, inyectando el `.zshrc` real, copiando los archivos de configuración de `.config/` y de `Wallpapers/` de forma nativa al HOME del usuario, y aplicando permisos de ejecución a los scripts y utilidades.
7. **`scripts/setup_sddm.sh` (Pantalla de Acceso & Fuentes):** Clona tu tema SDDM personalizado `hypr-ely-neon.git`, busca recursivamente archivos de fuentes tipográficas locales (`.ttf`, `.otf`) colocados directamente en el repositorio (incluyendo la tipografía proprietary **Kefa** y **Ndot**), los instala en el sistema y activa el servicio SDDM.
8. **`scripts/setup_vocalinux.sh` (Dictado por Voz):** Lanza de forma interactiva el instalador de **Vocalinux** y realiza la autocompilación y reinstalación de `pywhispercpp` en su entorno virtual para solucionar problemas de dependencias en Arch/CachyOS.

---

## 📂 Estructura del Repositorio

* **`install.sh`:** Script ejecutable de arranque rápido con selector HSL interactivo.
* **`.config/`:** Carpeta que alberga todas tus configuraciones reales (`hypr`, `waybar`, `rofi`, `kitty`, `fastfetch`, `biglexj`, etc.). Al ejecutarse la instalación, se copian de forma limpia directamente a tu `~/.config/` personal (reutilizable para cualquier usuario).
* **`Wallpapers/`:** Colección local de fondos de pantalla que se copia automáticamente a `~/Imágenes/Wallpapers/` para eliminar dependencias externas o discos NTFS inexistentes.
* **`scripts/`:** Contiene los archivos modulares descritos arriba y `utils.sh` (responsable de la cabecera estilizada, logs a color Coral/Menta/Lavanda, spinners y elevación sudo segura).

---

## 🛠️ Cómo Ejecutar

Para inicializar tu computadora por primera vez (o para que cualquier persona en la comunidad instale tu configuración), abre una terminal y corre el siguiente comando único:

```bash
curl -fsSL https://raw.githubusercontent.com/biglexj/biglexj-dotfiles/main/install.sh | bash
```

### Para Desarrolladores (Ejecución Local de Pruebas)
Si estás editando los scripts en tu espacio de trabajo local y deseas probar la orquestación antes de subir tus cambios a GitHub:
1. Asegura permisos de ejecución:
   ```bash
   chmod +x install.sh scripts/*.sh
   ```
2. Ejecuta el orquestador principal:
   ```bash
   ./install.sh
   ```

---

## 🎙️ Control por Voz (Vocalinux)

Vocalinux proporciona un sistema de dictado por voz impecable y respetuoso con tu privacidad:
* Funciona de manera **100% local y offline** usando `whisper.cpp` y `VOSK`.
* Admite modos de activación por empuje (*Push-to-Talk*) o palanca (*Toggle*).
* Puedes usar la combinación de teclas global **`SUPER + D`** (configurada en tu Hyprland real) para activar el micrófono, hablar en español y ver cómo transcribe automáticamente tu voz en la ventana activa.
