# Enter script code
# Mapeamento das vogais para suas versões com acento agudo
from time import sleep
from pynput import keyboard

import subprocess

from Xlib.error import ConnectionClosedError

accented_vowels = {
    'a': 'à',
    'e': 'è',
    'i': 'ì',
    'o': 'ò',
    'u': 'ù',
    'A': 'À',
    'E': 'È',
    'I': 'Ì',
    'O': 'Ò',
    'U': 'Ù'
}

def is_caps_lock_on():
    output = subprocess.run(["xset", "q"], capture_output=True, text=True).stdout
    return "Caps Lock:   on" in output

# Função para monitorar as teclas e acentuar vogais
def accent_vowel(vowel):
    if vowel in accented_vowels:
        keyboard.Controller().press(keyboard.Key.backspace)
        keyboard.Controller().release(keyboard.Key.backspace)
        if(is_caps_lock_on()):
            keyboard.Controller().press(accented_vowels[vowel.capitalize()])
            keyboard.Controller().release(accented_vowels[vowel.capitalize()])
        else:
            keyboard.Controller().press(accented_vowels[vowel])
            keyboard.Controller().release(accented_vowels[vowel])
        exit()

# Configuração para capturar as teclas
def on_press(key):
    try:
        # Verifica se a tecla pressionada é uma vogal que pode ser acentuada
        if key.char in accented_vowels:
            accent_vowel(key.char)
            return False  # Para de capturar depois de acentuar
    except AttributeError:
        pass

# Inicia a captura de teclas
while True:
    try:
        with keyboard.Listener(on_press=on_press) as listener:
            listener.join()
    except ConnectionClosedError:
        #leave after placing a backtick
        exit()
    sleep(0.1)
