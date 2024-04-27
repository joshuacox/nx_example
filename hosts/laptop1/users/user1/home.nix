{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "user1";
  home.homeDirectory = "/home/user1";

  programs = {
    bash.enable = true; # see note on other shells below
    carapace = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      enableZshIntegration = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
    nushell = { enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      configFile.source = ./config.nu;
      # for editing directly to config.nu 
      extraConfig = ''
       let carapace_completer = {|spans|
       carapace $spans.0 nushell $spans | from json
       }
       $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false # case-sensitive completions
        quick: true    # set to false to prevent auto-selecting completions
        partial: true    # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
        # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true 
        # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100 
            completer: $carapace_completer # check 'carapace_completer' 
          }
        }
       } 
       $env.PATH = ($env.PATH | 
       split row (char esep) |
       prepend /home/myuser/.apps |
       append /usr/bin/env
       )
      '';
      shellAliases = {
        vi = "hx";
        vim = "hx";
        nano = "hx";
      };
    };  
    starship = { enable = true;
      settings = {
        add_newline = true;
        character = { 
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
    vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ vim-airline ];
      settings = { ignorecase = true; };
      extraConfig = ''
        set mouse=""
        set ttymouse=""
      '';
    };
    zsh = {
      initExtra = ". ~/.zshrc.user1";
      enable = true;
      enableCompletion = true;
      #autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };
      history.size = 20000;
      history.path = "/home/user1/.zsh_history";
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "python" "man" "kubectl" ];
        theme = "random";
      };
    };
  };
  
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    oh-my-zsh
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/user1/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
