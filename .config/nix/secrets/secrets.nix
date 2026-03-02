let
  keys = import ./keys.nix;
in {
  "wg-private.age".publicKeys = [ 
        keys.defiantly
        keys.archies-home-worklab
  ];
  "user-password.age".publicKeys = [ 
        keys.defiantly
        keys.archies-home-worklab
  ];
}
