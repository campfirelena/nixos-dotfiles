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
(deflayer qwerty-mods
  @grl 1     2     3     4     5     6     7     8     9     0     -     =     bspc
  tab  q     w     e     r     t     y     u     i     o     p     [     ]     \
  @cap @qrta @qrts @qrtd @qrtf g     h     @qrtj @qrtk @qrtl @qrt; '     ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)
(deflayer colemak
  @grl 1     2     3     4     5     6     7     8     9     0     -     =     bspc
  tab  q     w     f     p     b     j     l     u     y     ;     [     ]     \
  @cap @cmka @cmkr @cmks @cmkt g     m     @cmkn @cmke @cmki @mko  '    ret
  lsft z     x     c     d     v     k     h     ,     .     /     rsft
  lctl lmet  lalt             spc                ralt  rmet  rctl
)
(defalias
  grl (tap-hold 200 200 grv (layer-toggle layers))
  qwr (layer-switch qwerty)
  cmk (layer-switch colemak)
  qrm (layer-switch qwerty-mods)
  cap (tap-hold 200 200 esc lctl)
  cmka (tap-hold 200 200 a lalt)
  cmkr (tap-hold 200 200 r lctl)
  cmks (tap-hold 200 200 s lmet)
  cmkt (tap-hold 200 200 t lsft)
  cmkn (tap-hold 200 200 n lsft)
  cmke (tap-hold 200 200 e lmet)
  cmki (tap-hold 200 200 i lctl)
  cmko (tap-hold 200 200 o lalt)
  qwra (tap-hold 200 200 a lalt)
  qwrs (tap-hold 200 200 a lctl)
  qwrd (tap-hold 200 200 a lmet)
  qwrf (tap-hold 200 200 a lsft)
  qwrj (tap-hold 200 200 a lsft)
  qwrk (tap-hold 200 200 a lmet)
  qwrl (tap-hold 200 200 a lctl)
  qwr; (tap-hold 200 200 a lalt)
)
(deflayer layers
  _    @qwr @cmk @qrm _    _    _    _    _    _    _    _    _
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
