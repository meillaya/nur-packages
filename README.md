# nur-packages

Personal [NUR](https://github.com/nix-community/NUR) packages for
[hoard](https://github.com/meillaya/hoard).

After the repository is registered in NUR, use:

```sh
nix shell nixpkgs#nixpkgs -c nix-shell -p nur.repos.meillaya.hoard-artifact --run hoard --version
```

or with flakes:

```nix
{
  inputs.nur.url = "github:nix-community/NUR";
  inputs.nur.inputs.nixpkgs.follows = "nixpkgs";
}
```

```nix
nur.legacyPackages.${system}.repos.meillaya.hoard-artifact
```

The package installs the `hoard` artifact CLI and the `hoard-gguf` inspector.
The attribute is `hoard-artifact` because `hoard` is already used by an
unrelated nixpkgs package.
