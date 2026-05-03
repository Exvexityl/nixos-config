# Modules/garbage.nix — Nix GC / store maintenance
# (was already in your config, kept as separate module)
{
  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;
}
