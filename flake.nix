{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages = {
        default = pkgs.stdenv.mkDerivation {
          name = "deckbd";
          src = ./.;
          buildInputs = with pkgs; [
            libevdev
            glib.dev
          ];
          nativeBuildInputs = with pkgs; [
            pkg-config
          ];
          makeFlags = [ "PREFIX=$(out)" ];
        };
      };

      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          libevdev
          glib.dev
        ];
      };
    });
}
