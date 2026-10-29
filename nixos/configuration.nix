# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, spicetify-nix, zen-browser, sonora, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # hardware graphics
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  }; # Optionally, set the environment variable

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CO.UTF-8";
    LC_IDENTIFICATION = "es_CO.UTF-8";
    LC_MEASUREMENT = "es_CO.UTF-8";
    LC_MONETARY = "es_CO.UTF-8";
    LC_NAME = "es_CO.UTF-8";
    LC_NUMERIC = "es_CO.UTF-8";
    LC_PAPER = "es_CO.UTF-8";
    LC_TELEPHONE = "es_CO.UTF-8";
    LC_TIME = "es_CO.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  services.gnome.gnome-keyring.enable = true;

  #tlp
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      WIFI_PWR_ON_BAT = true;
    };
  };


  # Configure console keymap
  console.keyMap = "us-acentos";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."j" = {
    isNormalUser = true;
    description = "j";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  #docker 
  virtualisation.docker.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.hyprland.enable = true;
  programs.neovim = {
	enable = true;
	defaultEditor = true;
  };
  programs.git = {
  	enable = true;
  };
  programs.git.prompt.enable = true;
  programs.dconf.enable = true;
  programs.nix-ld.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
    ];
  };

  programs.mango.enable = true;

  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
      adblock
    ];
  };
  services.tumbler.enable = true;
  services.gvfs.enable = true;
  services.upower.enable = true;
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
        user = "greeter";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #utils
    wget
    foot
    btop
    bash-completion
    librewolf
    nodejs_22
    pnpm
    python3
    opencode
    powertop
    brightnessctl
    ddcutil
    killall
    noctalia
    fastfetch
    xdg-utils
    nwg-look

    # nvim - lsp
    neovim
    tinymist
    nixd
    lua-language-server
    typescript-language-server
    bash-language-server
    pyright
    tailwindcss-language-server
    viu
    chafa
    ueberzugpp
    tree-sitter
    ripgrep
    fzf

    papirus-icon-theme
    tokyonight-gtk-theme
    pavucontrol
    typst
    zathura
    tmux
    mpv
    feh
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    sonora.packages.${pkgs.system}.default
    imagemagick

    #disk-utils
    testdisk
    ddrescue

    # utils
    wl-clipboard
    wl-screenrec
    slurp
    ffmpeg
  ];
	
  nix.settings.experimental-features = [
	  "nix-command"
	  "flakes"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

   fonts = {
	   fontconfig.enable = true;
	   packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	   ];
   };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
