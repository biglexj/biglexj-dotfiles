#!/usr/bin/env python3
import os
import re
import subprocess
import sys

# Paths to the bind files
binds_file = os.path.expanduser("~/.config/hypr/conf/binds.conf")
binds_apps_file = os.path.expanduser("~/.config/hypr/conf/binds-apps.conf")

# Dictionary to hold variables (like $kitty = kitty, $mainMod = SUPER)
variables = {
    "$mainMod": "SUPER"
}

# List to hold parsed keybinds
keybinds = []

def parse_file(file_path):
    if not os.path.exists(file_path):
        return
    
    with open(file_path, "r", encoding="utf-8") as f:
        for line in f:
            line_str = line.strip()
            if not line_str or line_str.startswith("#"):
                continue
            
            # Match variable definitions like $kitty = kitty
            var_match = re.match(r"^(\$[a-zA-Z0-9_]+)\s*=\s*(.+)$", line_str)
            if var_match:
                var_name = var_match.group(1)
                var_val = var_match.group(2)
                # Remove end comments
                if "#" in var_val:
                    var_val = var_val.split("#")[0].strip()
                variables[var_name] = var_val
                continue
            
            # Match bind lines: bind = ..., bindm = ..., binde = ..., bindl = ..., bindel = ...
            bind_match = re.match(r"^bind[a-z]*\s*=\s*(.+)$", line_str)
            if bind_match:
                content = bind_match.group(1)
                # Split by comment if any
                comment = ""
                if "#" in content:
                    content, comment = content.split("#", 1)
                    comment = comment.strip()
                
                # Split content by commas
                # Format is usually: MODIFIER, KEY, ACTION, COMMAND_OR_ARG
                parts = [p.strip() for p in content.split(",")]
                if len(parts) >= 3:
                    mods = parts[0]
                    key = parts[1]
                    action = parts[2]
                    rest = ", ".join(parts[3:]) if len(parts) > 3 else ""
                    
                    # Resolve variables in rest
                    for var, val in variables.items():
                        if var in rest:
                            rest = rest.replace(var, val)
                            
                    # Build hotkey string
                    hotkey = ""
                    if mods:
                        # Resolve variables in mods (e.g. $mainMod)
                        resolved_mods = mods
                        for var, val in variables.items():
                            resolved_mods = resolved_mods.replace(var, val)
                        hotkey = " + ".join(resolved_mods.split())
                    
                    if key:
                        if hotkey:
                            hotkey += " + " + key
                        else:
                            hotkey = key
                    
                    # Formatting hotkey
                    hotkey = hotkey.replace("SHIFT", "Shift").replace("ctrl", "Ctrl").replace("alt", "Alt").replace("ctrl alt", "Ctrl + Alt")
                    if not hotkey.startswith("SUPER") and not hotkey.startswith("Ctrl") and not hotkey.startswith("Alt") and hotkey.startswith(" + "):
                        hotkey = hotkey.replace(" + ", "", 1)
                    
                    # Clean up empty modifiers or formatting issues
                    hotkey = re.sub(r'^\s*\+\s*', '', hotkey)
                    
                    # Action display name
                    if action == "exec":
                        # If it runs an app/script
                        cmd_clean = rest.strip()
                        
                        # Use comment as description if exists, else clean command name
                        if comment:
                            desc = comment
                        else:
                            if "/" in cmd_clean:
                                app_name = os.path.basename(cmd_clean.split()[0])
                            else:
                                app_name = cmd_clean.split()[0] if cmd_clean else ""
                            desc = f"Lanzar {app_name}"
                        
                        keybinds.append((hotkey, desc, cmd_clean))
                    else:
                        # Internal Hyprland action (like close window, workspace change, etc.)
                        if comment:
                            desc = comment
                        else:
                            # Map system actions to friendly spanish names
                            if action == "killactive":
                                desc = "Cerrar ventana activa"
                            elif action == "exit":
                                desc = "Cerrar sesión de Hyprland"
                            elif action == "togglefloating":
                                desc = "Alternar ventana flotante"
                            elif action == "fullscreen":
                                desc = "Alternar pantalla completa"
                            elif action == "workspace":
                                desc = f"Ir a área de trabajo {rest}"
                            elif action == "movetoworkspace":
                                desc = f"Mover ventana a área de trabajo {rest}"
                            elif action == "togglespecialworkspace":
                                desc = "Alternar área de trabajo especial (Scratchpad)"
                            else:
                                desc = f"Acción Hyprland: {action} {rest}".strip()
                        
                        # For system actions, we run them via hyprctl dispatch
                        keybinds.append((hotkey, desc, f"hyprctl dispatch {action} {rest}".strip()))

parse_file(binds_file)
parse_file(binds_apps_file)

# Format list for rofi
menu_lines = []
for hotkey, desc, cmd in keybinds:
    # Format each line like: "SUPER + RETURN  ->  Abrir terminal (kitty)"
    menu_lines.append(f"{hotkey:<22} ->  {desc}")

# Join lines
menu_input = "\n".join(menu_lines)

# Run rofi
rofi_cmd = [
    "rofi", "-dmenu", "-i",
    "-p", "Atajos de Teclado",
    "-theme", os.path.expanduser("~/.config/rofi/conf/keybindings.rasi"),
    "-mesg", "<b>Atajos de Hyprland:</b> Presiona <b>Enter</b> en cualquier atajo para ejecutar la aplicación o acción."
]

process = subprocess.Popen(rofi_cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
stdout, _ = process.communicate(input=menu_input)

if stdout:
    selected = stdout.strip()
    # Find matching command and execute
    for hotkey, desc, cmd in keybinds:
        # Match using hotkey and description
        if selected.startswith(hotkey) and desc in selected:
            if cmd:
                # Run command in background disowned
                subprocess.Popen(cmd, shell=True, start_new_session=True)
            break
