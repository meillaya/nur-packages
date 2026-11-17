{ pkgs ? import <nixpkgs> { } }:

{
  hoard-artifact = pkgs.callPackage ./pkgs/hoard-artifact { };
}
