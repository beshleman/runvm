# A tool for running vagrant VMs

This tool is meant to be used with vagrant debian/bullseye64 VMs
and is really just meant to be used with those made from the
[makevm](https://github.com/beshleman/makevm) tool.

## Usage

```bash
Usage: runvm SUBCOMMAND [options]

Subcommands:
  boot               Boot a system
  ssh                Connect to the VM

Options for Subcommand 'boot':
  -k <kernel>        Path to kernel (required)
  -i <initrd>        Path to initrd (required)
  -d <disk>          Path to disk (required)
  -s <source>        Path to linux source (optional, shared with guest over 9p)

Examples:
  runvm boot -k /path/to/kernel -i /path/to/initrd -d /path/to/disk
  runvm ssh
```
