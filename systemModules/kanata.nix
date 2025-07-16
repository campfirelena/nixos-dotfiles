{ pkgs, config, lib, ... }:{
options = {
  systemModules.kanata.enable = lib.mkEnableOption "";
};

config = lib.mkIf config.systemModules.kanata.enable {
  services.kanata = {
    enable = true;
    keyboards.internalKeyboard = {
      extraDefCfg = "process-unmapped-keys yes";
      config = ''
(defsrc
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  caps a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)
(deflayer qwerty
  @grl 1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  @cap a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)
(deflayer colemak
  @grl 1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    f    p    b    j    l    u    y    ;    [    ]    \
  @cap a    r    s    t    g    m    n    e    i    o    '    ret
  lsft z    x    c    d    v    k    h    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)
(defalias
  grl (tap-hold 200 200 grv (layer-toggle layers))
  qwr (layer-switch qwerty)
  cmk (layer-switch colemak)
  cap (tap-hold 200 200 esc lctl)
)
(deflayer layers
  _    @qwr @cmk lrld _    _    _    _    _    _    _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _              _              _    _    _
)
      '';
    };
  };
  boot.kernelModules = [ "uinput" ];
  hardware.uinput.enable = true;
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';
  users.groups.uinput = {};
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };
};
}
