{ ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = [ ];
        shellHook = ''
          echo "Development environment loaded"
        '';
      };
    };
}
