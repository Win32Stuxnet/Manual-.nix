# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable FUSE for AppImages
  boot.supportedFilesystems = [ "fuse" ];

  boot.initrd.luks.devices."luks-3fd1b1b7-0a08-42c6-b8c9-577261e6e767".device = "/dev/disk/by-uuid/3fd1b1b7-0a08-42c6-b8c9-577261e6e767";
  networking.hostName = "iusenixosBTW"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Phoenix";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    #media-session.enable = true;
  };

  # services.xserver.libinput.enable = true;

  users.users.alanaa = {
    isNormalUser = true;
    description = "alanaa";
    extraGroups = [ "networkmanager" "wheel" "fuse" ];
    # User-specific packages are now managed via Home Manager in home.nix
    # System-wide packages remain in environment.systemPackages below
  };
  programs.firefox.enable = true;
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.gparted
    wget
    pkgs.git
    winetricks
    wineWowPackages.stable
    pkgs.neovim
    pkgs.discord
    pkgs.vesktop
    appimage-run  # Helper for running AppImages with proper FUSE support
  ];
  # AppImage support
  programs.nix-ld.enable = true;
  programs.appimage.binfmt = true;
  programs.nix-ld.libraries = with pkgs; [
    # Core system libraries
    glibc
    stdenv.cc.cc
    zlib
    
    # X11 libraries
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXi
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXfixes
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libxshmfence
    xorg.libXxf86vm
    
    # OpenGL and graphics
    libGL
    libglvnd
    mesa
    
    # GTK and GUI libraries
    gtk3
    gtk4
    glib
    cairo
    pango
    gdk-pixbuf
    atk
    
    # Audio/video
    alsa-lib
    libpulseaudio
    
    # Network and system
    dbus
    fontconfig
    freetype
    openssl
    curl
    
    # Additional common dependencies
    libuuid
    libselinux
    nspr
    nss
    cups
    libdrm
  ];
  # ====[SYSTEM SERVICES]===
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "gtk";
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "alanaa";

  services.flatpak.enable = true;
  nixpkgs.config.allowUnfree = true;
  # programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };


  # services.openssh.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = true;

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
# RE:  did I read?
# no

}
