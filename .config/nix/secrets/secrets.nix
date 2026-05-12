let
  keys = import ./keys.nix;
in {
  "wg-private.age".publicKeys = [ 
    keys.defiantly
    keys.archies-home-worklab
    keys.backup_key
  ];
  "user-password.age".publicKeys = [ 
    keys.defiantly
    keys.archies-home-worklab
    keys.backup_key
  ];
  "triton-wg.age".publicKeys = [
    keys.triton
    keys.backup_key
  ];
}
