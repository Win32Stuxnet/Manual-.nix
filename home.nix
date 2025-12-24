{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alanaa";
  home.homeDirectory = "/home/alanaa";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.11";

  # User-specific packages
  # Move packages from users.users.alanaa.packages here for better management
  home.packages = with pkgs; [
    kdePackages.kate
    # thunderbird
  ];

  # Programs configuration
  programs = {
    # Git configuration
    git = {
      enable = true;
      userName = "alanaa";
      userEmail = ""; # Set your email here
    };

    # Neovim configuration
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    # Firefox is already enabled in system config, but you can add user-specific settings here
    # programs.firefox.enable = true; # Already in system config
  };

  # Home Manager can also manage your environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

