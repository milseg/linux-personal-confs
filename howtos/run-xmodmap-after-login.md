
---

## 1. Create service

Use:
`/home/youruser/.config/systemd/user/keymappings.service`:

```ini
[Unit]
Description=Run keymap scripts
After=graphical-session.target

[Service]
Type=simple
ExecStart=/usr/bin/bash -lc "sleep 60 && /home/youruser/custom/custom-startup.sh"

[Install]
WantedBy=default.target
```

---

## 2. Import graphical environment into systemd

Run once from your logged-in graphical terminal:

```bash
systemctl --user import-environment DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS XDG_RUNTIME_DIR
```

---

## 3. Run

### 3.1 First run
```bash
# enable
systemctl --user daemon-reexec
systemctl --user enable keymappings.service

# start immediately(optional). Can wait until next user session startup, instead
systemctl --user start keymappings.service
```

### 3.2 Reload

```bash
systemctl --user daemon-reload
systemctl --user restart keymappings.service
```

---

# Check


```bash
systemctl --user show-environment | grep DISPLAY
#probably outputs "DISPLAY=1"

journalctl --user -u keymappings.service -b
cat /tmp/keymappings.log
```


---

# Why

GNOME launches the graphical session separately from the systemd user manager.

So your shell knows:

* DISPLAY
* DBUS_SESSION_BUS_ADDRESS
* XDG_RUNTIME_DIR

…but systemd user services do not automatically inherit them unless imported.

This is a very common issue with GUI apps launched from systemd user services on Linux desktops.

