# Running `nix-shell` in this directory will load this file, create the
# necessary derivations and pop a shell with everything required to build and
# run all client tests, plus required infrastructure. All without modifying any
# file in your system.
#
# For more info see:
# https://nixos.wiki/wiki/Development_environment_with_nix-shell

let
	pkgs = import <nixpkgs> {};
in
	pkgs.mkShell {
		buildInputs = [
			# terminal
			pkgs.zsh
			pkgs.bash
		];
		packages = [
			# general pkgs.curl
			pkgs.jq
			pkgs.gnumake
			pkgs.libiconv
			pkgs.darwin.apple_sdk.frameworks.Security
			# rust
			pkgs.rustup
			pkgs.cargo
			# LSPs
			pkgs.nixd
		];

		# Additional environment
		env = {
			IS_THIS_NIX = "yes";
		};
		# Shell initialization
		shellHook = ''
		  unset PROMPT_COMMAND
		  export PS1='\n\w \[\e[2;31m\]>\[\e[0;31m\]>\[\e[1;31m\]>\[\e[0m\] '
		'';

	}
