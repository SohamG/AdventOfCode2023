{
  description = "Advent of Code 2023 by SohamG";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/23.05";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = import nixpkgs { inherit system; }; in
        {
          devShells.default = pkgs.mkShell {
					  name="Advent of Scheme";
						packages=with pkgs;[ roswell sbcl racket ];
        	};
				});
} 
