# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Personal NixOS flake (with home-manager) for four hosts: `katana` (gaming desktop, niri), `workstation` and `frog` (work, gnome), `bomba` (headless home server).

## Commands

All via `just` (see `Justfile`); host is taken from `$HOSTNAME`.

- `just switch` / `just test`: `nh os switch|test` for the current host (`test` doesn't set the boot default)
- `just switch-bomba`: deploy `bomba` remotely to `r3ddy@192.168.1.223`
- `just update [input]`: `nix flake update`, optionally a single input
- `just clean-code`: format with `nixfmt-tree` and strip dead code with `deadnix`; run before committing
- Evaluate a host without switching: `nix build .#nixosConfigurations.<host>.config.system.build.toplevel --dry-run`

There are no tests. New files must be `git add`ed before the flake can see them.

## Architecture

- `flake.nix` declares each host with `mkSystem "<name>" { system, user, email, gamingSystem, workSystem, desktopEnvironment, enableZram, additionalModules }`. Host-only flake modules (nixflix, mailserver on `bomba`) go in `additionalModules`.
- `lib/mksystem.nix` puts together every system: `modules/nix-config` + `modules/packages.nix` + home-manager (`home/`) + sops-nix + `machines/<name>/default.nix`. It passes these `specialArgs` to NixOS and home-manager modules alike:
  - flags: `gamingSystem`, `workSystem`, `enableZram`
  - identity: `currentSystemName`, `currentSystemUser`, `currentSystemEmail`
  - `currentSystemDe`: list of `niri` / `gnome` / `plasma` / `none`
  - extra package sets: `pkgs-unstable`, `pkgs-small` (pinned commit), `pkgs-25-11`, `pkgs-my-features` (the owner's nixpkgs fork), and `inputs` (e.g. `inputs.nixpkgs-master`)
- Desktop- and role-specific config is switched on by these args, not by separate profiles. For example, `modules/programs/default.nix`, `home/default.nix` and `modules/nix-config/default.nix` import `niri.nix`/`gnome.nix`/`plasma.nix` based on `builtins.elem "<de>" currentSystemDe`, and `modules/packages.nix` uses `lib.optionals gamingSystem/workSystem`. Follow this pattern when adding DE- or role-specific config.
- `machines/<name>/` holds host-specific config split by concern (hardware, networking, services, virtualisation…). On `bomba`, each self-hosted service is one file in `machines/bomba/services/` (imported in its `default.nix`) and is exposed through a Caddy vhost in `services/caddy.nix`.
- `assets/` holds raw config files (niri KDL, noctalia TOML) that home-manager modules reference.

## Secrets

Secrets use sops-nix with age keys taken from each host's SSH key (`.sops.yaml`). `secrets/default.sops.yaml` is shared by all hosts; `secrets/bomba.sops.yaml` is for `bomba` only. Declare them in `machines/bomba/secrets.nix`. Never decrypt or print secret values. To add a host, see `secrets/README.md` (add the recipient to `.sops.yaml`, then `sops updatekeys`).

## Conventions

- Commits follow Conventional Commits with a scope, e.g. `fix(mail): ...`, `feat(katana): ...`, `ci: ...`.
- A GitHub workflow updates `flake.lock` automatically.
- The `patrickcanal.it` container image on `bomba` must be pulled with `sudo podman pull` to update.
