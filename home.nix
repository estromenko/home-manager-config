{
  config,
  pkgs,
  nixgl,
  lib,
  ...
}: {
  home.username = "estromenko";
  home.homeDirectory = "/home/estromenko";
  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  nixGL.packages = import nixgl {inherit pkgs;};
  nixGL.vulkan.enable = true;

  home.packages = with pkgs; [
    vim
    zellij
    (config.lib.nixGL.wrap telegram-desktop)
    google-chrome
    # For language servers
    nodejs
    nixd
    nil
  ];

  home.sessionVariables = {EDITOR = "vim";};

  home.file.".config/rio/config.toml".text = ''
    [window]
    mode = "maximized"
    opacity = 0.9
  '';

  programs.home-manager.enable = true;
  programs.fish.enable = true;
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };
  programs.rio = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.rio;
  };
  programs.zed-editor = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.zed-editor;
    extensions = ["nix" "python" "dockerfile" "yaml"];
    userSettings = {vim_mode = true;};
  };
  programs.git = {
    enable = true;
    userEmail = "estromenko@mail.ru";
    userName = "estromenko";
    extraConfig.init.defaultBranch = "master";
  };

  xdg.configFile."shell".source = lib.getExe pkgs.fish;
}
