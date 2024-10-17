{
	description = "Graham's MacOS Flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		nix-darwin.url = "github:LnL7/nix-darwin";
		nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
		# Optional: Declarative tap management
		homebrew-core = {
			url = "github:homebrew/homebrew-core";
			flake = false;
		};
		homebrew-cask = {
			url = "github:homebrew/homebrew-cask";
			flake = false;
		};
		homebrew-bundle = {
			url = "github:homebrew/homebrew-bundle";
			flake = false;
		};
		homebrew-nikitabobko-tap = {
			url = "github:nikitabobko/homebrew-tap";
			flake = false;
		};
	};

	outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, homebrew-nikitabobko-tap, home-manager }:
		let
		configuration = { pkgs, config, ... }: {
			nixpkgs.config.allowUnfree = true;
			nixpkgs.config.allowBroken = true;

			environment.systemPackages = [
				pkgs._1password-gui
				pkgs._1password
				pkgs.aerc
				pkgs.bat
				pkgs.bottom
				pkgs.chafa
				pkgs.colima
				pkgs.curl
				pkgs.delta
				pkgs.discord
				pkgs.docker-credential-helpers
				pkgs.docker
				pkgs.fd
				pkgs.figlet
				pkgs.fish
				pkgs.fzf
				pkgs.git
				pkgs.gh
				pkgs.gnupg
				pkgs.gobang
				pkgs.grc
				pkgs.imagemagick
				pkgs.jq
				pkgs.lazydocker
				pkgs.lazygit
				pkgs.lolcat
				pkgs.lsd
				pkgs.mise
				pkgs.mkalias
				pkgs.ollama
				pkgs.pandoc
				pkgs.pinentry_mac
				pkgs.presenterm
				pkgs.neovim
				pkgs.ripgrep
				pkgs.sketchybar
				pkgs.slack
				pkgs.starship
				pkgs.w3m
				pkgs.wezterm
				pkgs.yq
				pkgs.zellij
				pkgs.zoxide

				pkgs.fishPlugins.autopair
				pkgs.fishPlugins.fzf-fish
				pkgs.fishPlugins.grc
				pkgs.fishPlugins.plugin-git
			];

			homebrew = {
				enable = true;
				casks = [
					"nikitabobko/tap/aerospace"
					"raycast"
					"zen-browser"
				];
			};


			system.activationScripts.applications.text = let
				env = pkgs.buildEnv {
					name = "system-applications";
					paths = config.environment.systemPackages;
					pathsToLink = "/Applications";
				};
			in pkgs.lib.mkForce ''
			# Set up applications.
			echo "setting up /Applications..." >&2
			rm -rf /Applications/Nix\ Apps
			mkdir -p /Applications/Nix\ Apps
			find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
			while read src; do
				app_name=$(basename "$src")
				echo "copying $src" >&2
				${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
			done
			'';
			fonts.packages = [ pkgs.fira-code-nerdfont ];

			# Auto upgrade nix package and the daemon service.
			services.nix-daemon.enable = true;
			# nix.package = pkgs.nix;

			# Necessary for using flakes on this system.
			nix.settings.experimental-features = "nix-command flakes";

			# Create /etc/zshrc that loads the nix-darwin environment.
			programs.zsh.enable = true;  # default shell on catalina
			programs.fish.enable = true;
			programs.zsh = {
				interactiveShellInit = ''
					if [[ $(ps -o command= -p "$PPID" | awk '{print $1}') != 'fish' ]]
						then
							exec fish -l
							fi
							'';
			};
			# Set Git commit hash for darwin-version.
			system.configurationRevision = self.rev or self.dirtyRev or null;

			# Used for backwards compatibility, please read the changelog before changing.
			# $ darwin-rebuild changelog
		        system.stateVersion = 5; # Please read the comment before changing.

			# The platform the configuration will be used on.
			nixpkgs.hostPlatform = "aarch64-darwin";

			system.defaults.dock.autohide = true;
			system.defaults.dock.static-only = true;
			system.defaults.dock.wvous-bl-corner = null;
			system.defaults.dock.wvous-br-corner = null;
			system.defaults.dock.wvous-tr-corner = null;
			system.defaults.dock.wvous-tl-corner = null;
			system.defaults.finder.AppleShowAllExtensions = true;
			system.defaults.finder.AppleShowAllFiles = true;
			system.defaults.finder.FXPreferredViewStyle = "clmv";
			system.defaults.loginwindow.GuestEnabled = false;
			system.defaults.loginwindow.DisableConsoleAccess = false;
			system.defaults.magicmouse.MouseButtonMode = "TwoButton";
			system.defaults.menuExtraClock.IsAnalog = true;

			users.users.gvqz.home = "/Users/gvqz";
			home-manager.backupFileExtension = "bak";
			nix.configureBuildUsers = true;
			nix.useDaemon = true;

			services.sketchybar.enable = true;

		};
	in
	{
		darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
			modules = [
				configuration
				nix-homebrew.darwinModules.nix-homebrew
				home-manager.darwinModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.gvqz = import ./home.nix;
				}
				{
					nix-homebrew = {
					            # Install Homebrew under the default prefix
						    enable = true;

						    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
						    enableRosetta = true;

						    # User owning the Homebrew prefix
						    user = "gvqz";

						    # Optional: Declarative tap management
						    taps = {
						      "homebrew/homebrew-core" = homebrew-core;
						      "homebrew/homebrew-cask" = homebrew-cask;
						      "homebrew/bundle" = homebrew-bundle;
						      "nikitabobko/homebrew-tap" = homebrew-nikitabobko-tap;
						    };

						    # Optional: Enable fully-declarative tap management
						    #
						    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
						    mutableTaps = false;
					};
				}
			];
		};

		darwinPackages = self.darwinConfigurations"macbook".pkgs;
	};
}
