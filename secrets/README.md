# Secrets

## Add a new machine 
1) Obtain an age identity
```bash
nix run nixpkgs#ssh-to-age -- \
  -private-key \
  -i $HOME/.ssh/id_ed25519 \
  -o $HOME/.config/sops/age/keys.txt
```

2) Obtain age recipient for the machine
```bash
cat /etc/ssh/ssh_host_ed25519_key.pub | nix run nixpkgs#ssh-to-age | wl-copy
```

3) Paste obtained key into `.sops.yaml`
4) Re-encrypt old files 
```bash
sops updatekeys secrets/default.sops.yaml
```
