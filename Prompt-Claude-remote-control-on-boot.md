Set up Claude Code's `remote-control` feature to start automatically on boot/login on this machine, so I can reach local sessions from claude.ai/code or the mobile app without manually launching it.

Detect the OS and use its native, idiomatic autostart mechanism (don't hand-roll something generic):
- Linux with systemd: a systemd service (system-level unit under /etc/systemd/system, or a user unit with `loginctl enable-linger` if it should run without an active login session).
- macOS: a LaunchAgent (~/Library/LaunchAgents) if it only needs to run while logged in, or a LaunchDaemon (/Library/LaunchDaemons) if it needs to run before login / system-wide.
- Windows: a Scheduled Task triggered "at startup" or "at log on" running as the correct user, or a Windows Service (e.g. via NSSM) if it must run without any user logged in.
- Linux without systemd (e.g. containers, older init): fall back to whatever init the system actually has (rc.local, OpenRC, etc.) — check before assuming systemd is present.

Whatever mechanism you use, it must satisfy all of these:

1. Wait for real internet connectivity before starting the process — not just "network interface up." Poll a lightweight HTTPS endpoint (e.g. https://api.anthropic.com) with a short per-attempt timeout (2-3s) and retry for up to ~60 seconds before giving up and starting anyway. This matters because `claude remote-control`'s initial handshake has a short timeout of its own, and starting it before the network is actually usable (e.g. mid-DHCP at boot) makes it die silently with no useful error. Use the OS's native "wait for network" boot ordering too if one exists (e.g. systemd's network-online.target), but add this application-level check as well — don't rely on ordering alone.

2. Run as the correct user account — specifically the one that already has `claude` authenticated (run `claude login` first if needed, verify with a quick `claude remote-control --help`/`claude --version` sanity check). Make sure HOME (or USERPROFILE on Windows) resolves correctly for that user in whatever context the service runs, so it can find stored credentials.

3. Log all stdout/stderr to a persistent file with timestamps, so failures can be debugged after the fact. Don't let logs grow unbounded — use log rotation if the platform makes it easy (logrotate, systemd journal limits, etc.), otherwise just note where the log lives.

4. Auto-restart on crash, using the service manager's native restart policy rather than a custom retry loop (e.g. systemd `Restart=on-failure` + `RestartSec`, launchd `KeepAlive`, Windows Task Scheduler's failure-restart settings or an NSSM-managed service).

5. Reference the full path to the `claude` binary rather than relying on PATH, since PATH may not be fully set up in whatever minimal environment boot-time services run in.

After setting it up:
- Simulate or actually trigger a restart/re-login and confirm the process comes up on its own.
- Tail the log file and confirm it shows a successful connection (not stuck retrying).
- Confirm a new session actually appears in claude.ai/code or the mobile app.

Report back what mechanism you used, the file(s) you created, and the log file location.
