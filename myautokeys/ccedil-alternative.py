# Enter script code
import subprocess

# Função para checar o estado do Caps Lock
def is_caps_lock_on():
    output = subprocess.run(["xset", "q"], capture_output=True, text=True).stdout
    return "Caps Lock:   on" in output

if is_caps_lock_on():
    keyboard.send_keys("Ç")
else:
    keyboard.send_keys("ç")