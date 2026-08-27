{
  pkgs,
  ...
}:
let
  backup-cli = (
    pkgs.writeShellApplication {
      name = "backup-cli";
      text = ''
        #!/usr/bin/env bash

        set -euo pipefail

	BACKUP_FOLDER="/home/r3ddy/backup"
        OUTPUT="$BACKUP_FOLDER/$(date +%Y%m%d-%H%M%S).tar.gz"

        if [ "$USER" != "root" ]
        then
            echo "Please run this as root or with sudo"
            exit 2
        fi

	mkdir -p $BACKUP_FOLDER
        TMP_DIR="/tmp/backup"
        mkdir -p $TMP_DIR
        mkdir -p $TMP_DIR/actual

        cp /var/lib/yamtrack/db.sqlite3 $TMP_DIR/yamtrack.db.sqlite3
        cp /var/lib/actual/user-files/* $TMP_DIR/actual/
        cp /var/lib/vaultwarden/db.sqlite3 $TMP_DIR/vaultwarden.db.sqlite3
        cp /var/lib/homebox/data/homebox.db $TMP_DIR/homebox.db

        tar -czf "$OUTPUT" \
            -C /tmp/backup . 

        echo "Archivio creato: $OUTPUT"      
      '';
    }
  );
in
{
  environment.systemPackages = [
    backup-cli
  ];
}
