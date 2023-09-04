{
  description = "elm-either";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      name = "elm-either";

      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix;

      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      devShells = forAllSystems (system:
        let pkgs = nixpkgsFor.${system}; in
        {
          ${name} = pkgs.mkShell {
            inherit name;
            buildInputs = with pkgs; [
              nixpkgs-fmt
              elmPackages.elm
              elmPackages.elm-format
            ];
          };

          default = self.devShells.${system}.${name};
        });
    };
}
