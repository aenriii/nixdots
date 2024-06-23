{ config, lib, pkgs, modulesPath, ... }:

{
    imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "usbhid" "xhci_pci" "nvme" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
    { device = "/dev/disk/by-uuid/ae4185b7-512f-4e1e-8888-c3a3c99d470b";
      fsType = "ext4";
    };

    fileSystems."/substrate" =
    { device = "/dev/disk/by-uuid/98cca72b-eef4-46b3-8992-f20f202ab7af";
      fsType = "ext4";
    };

    fileSystems."/boot" =
    {
        device = "/dev/disk/by-uuid/67E3-17ED";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
    };

    swapDevices = [ ]

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}