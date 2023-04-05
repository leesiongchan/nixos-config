{ config, pkgs, sops-nix, ... }:

{
  # imports = [
  #   <sops-nix/modules/home-manager/sops.nix>
  # ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "leesiongchan";
  home.homeDirectory = "/home/leesiongchan";

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.age
    pkgs.bat
    pkgs.du-dust
    pkgs.exa
    pkgs.fd
    pkgs.fzf
    pkgs.ripgrep
    pkgs.nil
    pkgs.starship
    pkgs.sublime-merge
    pkgs.zoxide
    # sops-nix
  ];


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Harvey";
    userEmail = "leesiongchan@duck.com";
    # extraConfig = {
    #   user.signing.key = "CE707A2C17FAAC97907FF8EF2E54EA7BFE630916";
    #   commit.gpgSign = true;
    # };
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
      source ~/.cache/starship/init.nu
      source ~/.zoxide.nu
    '';
    extraEnv = ''
      starship init nu | save -f ~/.cache/starship/init.nu
      zoxide init nushell | save -f ~/.zoxide.nu
    '';
  };

  programs.ssh = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    historySubstringSearch.enable = true;
    initExtra = ''
      # Scale HiDPI (WSL)
      export GDK_SCALE=2
      export GDK_DPI_SCALE=0.75

      # export GPG_TTY="$(tty)"

      alias cat=bat
      alias du=dust
      alias find=fd
      alias ls=exa

      eval "$(starship init zsh)"
    '';
    profileExtra = ''
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi
    '';
    oh-my-zsh = {
      enable = true;
      extraConfig = ''
        # @ref https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#disable_magic_functions
        DISABLE_MAGIC_FUNCTIONS=true

        # Oh My Zsh - Tmux
        # @ref https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux#configuration-variables
        ZSH_TMUX_AUTOSTART=true
        ZSH_TMUX_CONFIG=$HOME/.config/tmux/tmux.conf
        ZSH_TMUX_AUTOCONNECT=false

        # Oh My Zsh - Zellij
        # eval "$(zellij setup --generate-auto-start zsh)"
      '';
      plugins = [ "direnv" "docker" "docker-compose" "fzf" "git" "gitignore" "kubectl" "ripgrep" "rust" "tmux" "zoxide" ];
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    plugins = with pkgs; [
      tmuxPlugins.continuum
      tmuxPlugins.resurrect
      tmuxPlugins.sensible
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.dracula;
        extraConfig = ''
          set -g @dracula-plugins "cpu-usage ram-usage"
          set -g @dracula-refresh-rate 10
          set -g @dracula-show-battery false
          set -g @dracula-show-powerline true
        '';
      }
    ];
  };

  programs.zellij = {
    enable = false;
    settings = {
      default_layout = "compact";
      # simplified_ui = true;
      theme = "dracula";
      themes = {
        dracula = {
          bg = [ 40 42 54 ];
          red = [ 255 85 85 ];
          green = [ 80 250 123 ];
          yellow = [ 241 250 140 ];
          blue = [ 98 114 164 ];
          magenta = [ 255 121 198 ];
          orange = [ 255 184 108 ];
          fg = [ 248 248 242 ];
          cyan = [ 139 233 253 ];
          black = [ 0 0 0 ];
          white = [ 255 255 255 ];
        };
      };
    };
  };
}
