{ pkgs, config, lib, inputs, ... }:{
  options = {
    systemModules.virt.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.systemModules.virt.enable {
    boot.kernelModules = [ "kvm-intel" ];
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
