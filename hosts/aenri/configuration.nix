{ configs, pkgs, ... }:

{
    imports = 
        [
            ./hardware-configuration.nix
        ];
    
    boot.loader.efi.canTouchEfiVariables = true;
    # not telling systemd-boot to exist, as we're booting from opencore already.
    boot.loader.systemd-boot.enable = false;

    networking.hostName = "desplendyne";

    networking.networkmanager.enable = true;

    time.timeZone = "America/Indiana/Indianapolis";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };


    users.users.aenri = {
        isNormalUser = true;
        description = "Aenri Lovehart";
        extraGroups = [ "wheel" "networkmanager" ];
        packages = with pkgs; [ ];

    };

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [ ];

    system.stateVersion = "24.05";
}