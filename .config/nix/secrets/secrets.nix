let
  keys = import ./keys.nix;
in {
  "wg-private.age".publicKeys = [ 
        keys.defiantly
        keys.nixosvm
  ];
  "user-password.age".publicKeys = [ 
        keys.defiantly
        keys.nixosvm
  ];
}
