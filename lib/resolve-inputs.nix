{
	stable,
	inputs,
	system,
}:
let
	nixpkgs-stable = inputs."nixpkgs-unstable";
	nixpkgs = if stable then nixpkgs-stable else inputs.nixpkgs-unstable;
	home-manager = inputs.home-manager-unstable;
in
{
	systemFunc = nixpkgs.lib.nixosSystem;
	home-manager = home-manager.nixosModules;
	inherit (import nixpkgs { inherit system; }) lib;
}

