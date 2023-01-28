let
  pkgs = import <nixpkgs> { };
  elmPkgs = pkgs.elmPackages;
  elm-start = pkgs.writeShellScriptBin "elm-start" ''
      elm-live src/Main.elm --start-page=index.html -v --hot --pushstate -- --output=main.js
      '';
  elm-make = pkgs.writeShellScriptBin "elm-make" ''
      elm make src/Main.elm --output=main.js
      '';
in
pkgs.mkShell {
  buildInputs = [
    elmPkgs.elm
    elmPkgs.elm-live
    elm-start
    elm-make
    ];
}
