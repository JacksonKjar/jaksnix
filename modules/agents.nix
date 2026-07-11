{ ... }:
{
  flake.modules.homeManager.agents =
    { pkgs, ... }:
    {
      programs.codex = {
        enable = true;
      };
    };
}
