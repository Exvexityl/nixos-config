{ pkgs, ... }:
{
  systemd.services.delete-old-profiles = {
    description = "deletes oldprofiles";
    serviceConfig.Type = "oneshot";
    path = with pkgs; [
      coreutils
      findutils
      gnused
    ];
    script = ''
      set -euo pipefail
      (
        cd /nix/var/nix/profiles
        echo system-*-link | tr ' ' '\n' | sort -t- -k2nr | sed 1,5d | xargs rm -v
      )
    '';
    startAt = "15:0 | tr ' ' '\n' | sort -t- -k2nr | sed 1,5d | xargs rm -v
         )
       '';0";
  };
}
