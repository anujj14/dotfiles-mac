<div align="center">

# ❄️ anuj's dotfiles

**A declarative macOS workspace. Nix Flakes + nix-darwin + home-manager.**
**Apple Silicon. Terminal-first. Opinionated. Zero bloat.**

[![macOS](https://img.shields.io/badge/macOS-Apple_Silicon-000000?style=flat-square&logo=apple&logoColor=white)](#)
[![Nix Flakes](https://img.shields.io/badge/Nix-Flakes-7E9BE0?style=flat-square&logo=nixos&logoColor=white)](#)
[![nix-darwin](https://img.shields.io/badge/nix--darwin-system-7E9BE0?style=flat-square&logo=nixos&logoColor=white)](#)
[![home-manager](https://img.shields.io/badge/home--manager-24.05-7E9BE0?style=flat-square&logo=nixos&logoColor=white)](#)
[![shell](https://img.shields.io/badge/shell-zsh-89e051?style=flat-square&logo=gnubash&logoColor=white)](#)
[![AeroSpace](https://img.shields.io/badge/WM-AeroSpace-ebbcba?style=flat-square&logo=git&logoColor=black)](#)

</div>

---

> Built for me. Tried not to bloat it; only stuff I actually use daily. Clone it, rip out what you don't need, make it yours.

---

## 🧭 Overview

One `darwin-rebuild switch` and the machine is mine — Finder tamed, dock stripped, touch-ID-for-sudo on, apps installed, dotfiles symlinked, shell loaded. Wipe the Mac, run the command, come back to an identical machine.

Why Nix over `brew install` lists and `stow` symlinks:

- **Reproducible.** Same flake + same commit = same system. No drift. Roll back with `darwin-rebuild --rollback`.
- **Atomic.** A switch either fully applies or doesn't. No half-installed state when the network dies.
- **Layered.** `darwin.nix` owns the system, `home.nix` owns the user, `config/` owns program configs. Nothing lives only in a GUI preference pane.

---

## 🚀 Installation & Setup

Only for Apple Silicon. Tested on a fresh M1 MacBook Air. Read it through once before pasting.

### 0. Match the flake to *your* machine
These strings are **mine**, not yours. Change them or the rebuild fails:

| File | What | Change to |
|---|---|---|
| `flake.nix` | `darwinConfigurations."anuj-macbook"` | your hostname |
| `flake.nix` | `username = "anujpokhriyal"` | your short username |
| `modules/git.nix` | `programs.git.settings.user` (`"Your Name"` / `"your.email@example.com"`) | your git identity |
| `modules/git.nix` | `user.signingkey` | path to your SSH key (or remove signing block) |

Check your current hostname:
```bash
scutil --get LocalHostName
```
Either rename the machine (`sudo scutil --set LocalHostName "your-host"`) or edit `flake.nix` — your call. Also review `darwin.nix` for the `casks` list, `dock.persistent-apps`, and the `loginwindow.LoginwindowText` ("Stay Away — Anuj Pokhriyal") — make them yours or remove them. Same for the configs in `config/`.

### 1. Prerequisites
```bash
xcode-select --install
```

### 2. Install Nix (multi-user)
```bash
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh
```
Restart your terminal, then verify:
```bash
nix --version
```

### 3. Clone the repo
```bash
git clone https://github.com/anujj14/dotfiles.git ~/nix-darwin
cd ~/nix-darwin
```

### 4. First switch
```bash
nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .#anuj-macbook
```
(replace `anuj-macbook` with the hostname from step 0)

First run is slow — it's compiling/downloading your whole system. Subsequent runs are seconds. After it finishes:
```bash
exec zsh
```
…and restart the Mac once so the system-level defaults (`dock`, `finder`, `loginwindow`) pick up cleanly.

> If macOS prompts about `iina` or any app from an unidentified developer, approve it in **System Settings → Privacy & Security**. One-time thing.

> **⚠️ Note on Existing Configs:** If you already have existing dotfiles (like `~/.config/aerospace`), this flake will **not** delete them. Home Manager will safely back them up by appending `.bak` to the folder name before linking the new configs.
>
> **📱 Note on Immich (Dock Icon):** The dock configuration expects Immich to be installed as a Safari Web App. After your first switch, open Safari, navigate to your Immich instance, and click `File > Add to Dock`. If you don't use Immich, remove its path from `darwin.nix` before building or just remove dock icon later.
---

## 🌙 NightTab Configuration
If you like the start page in my browser screenshots, I use the NightTab extension. You can grab my layout file here: **[user.json](./config/nightTab.json)**.
Just import it via `Settings -> Data -> Restore -> Import from file`.

---

## 🔁 Day-to-Day Usage

### Apply changes after editing the flake
```bash
cd ~/nix-darwin
sudo darwin-rebuild switch --flake .#anuj-macbook
```
Idempotent — Nix computes the diff and only touches what changed.

### Update inputs (bump `flake.lock`)
```bash
nix flake update --flake .
darwin-rebuild switch --flake .#anuj-macbook
git add flake.lock && git commit -m "chore: bump flake inputs"
```
`flake.lock` is the reproducibility contract — always commit it. Do this every week or two to pull fresh `nixpkgs-unstable`.

### Roll back a bad switch
```bash
darwin-rebuild --rollback
# or pick a specific generation:
darwin-rebuild --list-generations
darwin-rebuild switch --generation <N>
```

### Garbage-collect old generations
```bash
nix-collect-garbage --delete-older-than 14d
```

### Quick reference
| Task | Command |
|---|---|
| Apply changes | `darwin-rebuild switch --flake .#anuj-macbook` |
| Update all inputs | `nix flake update --flake .` |
| Rollback | `darwin-rebuild --rollback` |
| List generations | `darwin-rebuild --list-generations` |
| Garbage collect | `nix-collect-garbage --delete-older-than 14d` |
| Inspect flake | `nix flake show` |

---

## 🧪 Ad-hoc Dev Environments

The whole point of not bloating the main desktop. Drop a `flake.nix` in any project:

```nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs = { nixpkgs, ... }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [ python311 k3d opentofu kubectl helm ];
    };
  };
}
```

```bash
nix develop        # enter the env

exit               # leave it — nothing installed globally, nothing to uninstall
```

Isolated packages for just one project? Python, brew, and `pip` drama — you know it I know it. Nix fixes the whole mess.

### One-off tools with `nix shell`

Don't even want a project flake for a single command? `nix shell` drops you into
a shell with a package available, then forgets about it the moment you leave:

```bash
nix shell nixpkgs#ffmpeg

ffmpeg -i input.mp4 output.gif

exit               # ffmpeg is gone from PATH, nothing was "installed"
```

Or skip the subshell entirely and run it as one line:

```bash
nix shell nixpkgs#ffmpeg -c ffmpeg -i input.mp4 output.gif
```

No `brew install ffmpeg` you'll forget about six months later, no version
conflicts with some other tool that also wants `ffmpeg`. The package is pulled
from the Nix store and cached — so the next `nix shell nixpkgs#ffmpeg` is
instant — but it never touches your PATH outside that shell or this flake.
Run `nix-collect-garbage --delete-older-than 14d` occasionally to reclaim disk
space from packages you've stopped using.

---

## ⚙️ What's Inside

### System (`darwin.nix`)
- `nix-homebrew` for declarative casks/taps. Rosetta off. Auto-migrate from legacy brew.
- Touch ID for `sudo` (`security.pam.services.sudo_local.touchIdAuth`).
- Finder: list view, pathbar + statusbar, all extensions + hidden files visible, desktop icons killed, search scoped to current folder, new windows open at `$HOME`.
- Key repeat cranked (`InitialKeyRepeat 15`, `KeyRepeat 2`), press-and-hold disabled, trackpad scaling 2.0, tap-to-click, three-finger drag. No auto-capitalization, no spell-correct.
- Dock: autohide, tile 57, magnify to 67, `scale` minimize, minimize-to-application, recents off.
- Screenshots → `~/Pictures/Screenshots` as `.jpg`. Siri off, Time Machine nagging off, no `.DS_Store` on network/USB volumes.
- Loginwindow text: **"Stay Away — Anuj Pokhriyal"**.

### Apps (casks)
| App | Why it's here |
|---|---|
| **Ghostty** | Default look is so good I barely configure it. |
| **AeroSpace** | Tiling WM in native Swift. No SIP disable like yabai |
| **JankyBorders** | Via native `darwin.nix`. Borders for active and inactive windows.
| **Zed** | Opens instantly, real vim bindings, written in Rust. I live in nvim; Zed is for when I actually need to code. |
| **Zen** | Arc that still gets updates. Firefox-based. f chrome. |
| **Helium** | Ungoogled, de-bloated Chromium for the few times Chromium is unavoidable. Sips RAM. |
| **OrbStack** | The Docker Desktop replacement on Apple Silicon. Sips CPU/RAM. Podman on macOS isn't there yet. |
| **Tailscale** | Mac as exit-node for my phones, reaching the homelab from anywhere. |
| **IINA** | Best video player on macOS. |
| **LocalSend** | Open-source AirDrop. |
| **Shottr** | Miles better than default screenshots. Quick copy, edit, done. |
| **Signal / WhatsApp / Telegram** | Privacy + have to use what people use :( |
| **ImageOptim + Handbrake** | Trim photos/videos before they bloat my Immich server. |
| **AppCleaner** | Because macOS still doesn't know how to uninstall an app. |
| **Keka** | Because macOS also doesn't know how to handle zips properly. |
| **Impactor** | IPA sideloader for iPhone/iPad. FU to Apple for not letting me install what I want on devices I own. |
| **Iris** | Quick webcam check(HandMirror alt). |

### Userland (`home.nix`)
**CLI packages** (from `nixpkgs-unstable`):

| Tool | Why |
|---|---|
| **neovim** | The best editor. I keep it mostly default — no heavy modding. Config in `config/nvim/`. |
| **tmux** | Terminal multiplexer. You know what it does. |
| **starship** | So I don't have to configure oh-my-zsh and its bloat. Starship defaults are already the best. |
| **zoxide** | `cd` with memory. `z proj` jumps to `~/code/projects` after one visit. |
| **fzf** | For the searches macOS Spotlight can't do. `--height 40% --border`. |
| **btop** | Activity Monitor is painfully slow. btop is faster — though it's inaccurate sometimes. |
| **yazi** | File explorer in the terminal. For when I don't want to leave the shell. |
| **fastfetch** | Updated neofetch. For those cool screenshots. |
| **tree** | Visual `ls` for viewing file/directory structure. |
| **pass** | Unix password manager. (not fully migrated yet, but trying). |
| **android-tools** | `adb` into my Android TV and phones. |
| **cmatrix** | The Matrix screensaver. Pure flex for the screenshot. |

**Shell:** Zsh — macOS default. home-manager manages: autosuggestions, syntax highlighting, completion. Starship prompt. Zoxide for `z`. fzf integrated with zsh.


---

## 🫡 Acknowledgements

- [**LnL7/nix-darwin**](https://github.com/LnL7/nix-darwin) — declarative macOS.
- [**nix-community/home-manager**](https://github.com/nix-community/home-manager) — declarative home.
- [**zhaofengli/nix-homebrew**](https://github.com/zhaofengli/nix-homebrew) — declarative Homebrew.
- [**nikitabobko/AeroSpace**](https://github.com/nikitabobko/AeroSpace) — for making this awesome window manager for macOS.
- [**mitchellh/ghostty**](https://github.com/mitchellh/ghostty) — For making the best macOS terminal.
- [**FelixKratz/JankyBorders**](https://github.com/FelixKratz/JankyBorders) — He does a lot of macOS ricing work. Creator of Sketchybar & JankyBorders. Check him out.
- Everyone shipping the open-source apps above.

---

<div align="center">

<sub>Built for me. Shared so you can build for you.</sub>

</div>
