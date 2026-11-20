{ config, lib, pkgs, ... }:

rec {
  imports = [];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jcaspar";
  home.homeDirectory = "/home/jcaspar";

  xdg.enable = true;

  # Env variables
  home.sessionVariables."EDITOR" = "code --wait";

  # Let Home manager install and manager itself.
  programs.home-manager.enable = true;

  # Find packages that provide unknown commands
  programs.command-not-found.enable = true;

  # Firefox
  programs.firefox.enable = true;

  # Git
  programs.git = {
    enable = true;
    settings.user = {
      name = "JeanCASPAR";
      email = "55629512+JeanCASPAR@users.noreply.github.com";
    };
  };

  # VsCode
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      # French Language Pack
      ms-ceintl.vscode-language-pack-fr
      # Rust
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
      tamasfe.even-better-toml
      # LaTeX
      james-yu.latex-workshop
      tecosaur.latex-utilities
      # neo-ltex.vscode-ltex-plus
      # Python
      ms-python.python
      # OCaml
      ocamllabs.ocaml-platform
      # Coq
      rocq-prover.vsrocq
      # Nix
      bbenoist.nix
      # Miscellaneous
      mkhl.direnv
      gruntfuggly.todo-tree
    ];
  };

  # Bash
  programs.bash = {
    enable = true;
    enableVteIntegration = true;
  };

  programs.starship = {
    enable = true;
    # settings = {
    # TODO  
    # };
  };

  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Thunderbird
  programs.thunderbird = {
    enable = true;
  };

  # TeX Live
  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };
    packageSet = pkgs.texlive;
  };

  # Services

  # GNUPG
  # services.gpg-agent = {
  #   enable = true;
  #   enableSshSupport = true;
  #   pinentryFlavor = "curses";
  # };

  # Bluetooth
  services.mpris-proxy.enable = true;

  services.gnome-keyring.enable = true;

  # Packages
  home.packages = with pkgs; [
    gcr_4
    discord
    mattermost-desktop
    (python3.withPackages(ps: with ps; [
      numpy tkinter requests
      pygments # for the LaTeX package minted
      beautifulsoup4
    ]))
    rustup
    nixpkgs-fmt
    gcc
    ocamlPackages.ocaml
    ocamlPackages.utop
    dune_3
    lldb

    unzip
    p7zip

    gimp
    inkscape
    zotero
    # gparted Must be install as root

    pdftk
    pdfchain

    xeyes

    # LibreOffice
    libreoffice-qt
    hunspell
    hunspellDicts.fr-any
    hunspellDicts.en-us

    # Video Player
    vlc

    # VPN
    openconnect
    networkmanager-openconnect
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.11";

  # Run home-manager-help for manual.
  manual.html.enable = true;
  manual.manpages.enable = true;
  programs.man.enable = true;

  # Notify for news when running home-mananger.
  news.display = "notify";
}
