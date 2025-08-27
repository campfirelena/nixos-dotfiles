{ pkgs, config, lib, inputs, ... }:{
  options = {
    systemModules.virt.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.systemModules.virt.enable {
    virtualisation.libvirtd.enable = true;
    virtualisation.libvirtd.qemu.swtpm.enable = true;
    programs.virt-manager.enable = true;
    environment.systemPackages = with pkgs; [
      qemu-utils
      swtpm
    ];
  };
}
