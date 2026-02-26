# Enter script code
from pynput.mouse import Controller, Button

mouse = Controller()

for _ in range(4):
    mouse.click(Button.left)
    time.sleep(0.05)  # Add a small delay between clicks if needed