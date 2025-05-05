{
	stable,
	inputs,
	system,
}:
let
	isDarwin = (import inputs.nixpkgs-unstable { inherit system; }).stdenv.isDarwin;
	darwin = if stable then inputs.darwin-stable else inputs.darwin-unstable;
	nixpkgs-stable = inputs."nixpkgs-unstable";
	nixpkgs = if stable then nixpkgs-stable else inputs.nixpkgs-unstable;
	home-manager = inputs.home-manager-unstable;
in
{
	inherit isDarwin nixpkgs-stable;
	systemFunc = if isDarwin then darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
	home-manager = if isDarwin then home-manager.darwinModules else home-manager.nixosModules;
	inherit (import nixpkgs { inherit system; }) lib;
}

