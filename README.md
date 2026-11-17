# nur-packages

Personal [NUR](https://github.com/nix-community/NUR) repository for
[hoard](https://github.com/meillaya/hoard).

## Packages

| Attribute | Contents |
| --- | --- |
| `hoard-artifact` | The `hoard` artifact CLI and the `hoard-gguf` inspector. |

The attribute is `hoard-artifact` because `hoard` is already used by an
unrelated nixpkgs package. The installed binaries keep their upstream names.

## Usage

With the NUR flake input:

```nix
{
  inputs.nur.url = "github:nix-community/NUR";
  inputs.nur.inputs.nixpkgs.follows = "nixpkgs";
}
```

```nix
environment.systemPackages = [
  nur.legacyPackages.${system}.repos.meillaya.hoard-artifact
];
```

Or build this repository directly:

```sh
nix build .#hoard-artifact
./result/bin/hoard --version
```

## Licence

The NUR packaging files in this repository are MIT licensed. The packaged
upstream software is Apache-2.0.
