# A tool for running vagrant VMs

This tool is meant to be used with vagrant debian/bullseye64 VMs
and is really just meant to be used with those made from the
[makevm](https://github.com/beshleman/makevm) tool.

## Usage

### Container

#### Boot a VM
```bash
docker run \
	-v$(pwd):$(pwd) \
	-w$(pwd) \
	-v/var/run/libvirt:/var/run/libvirt \
	-v/path/to/images:/path/to/images \
	--privileged \
	--network host \
	-it beshleman/runvm boot \
	-k /path/to/images/kernel -i /path/to/images/initrd -d /path/to/images/disk
```

#### SSH into VM
```bash
docker run \
	-v$(pwd):$(pwd) \
	-v/var/run/libvirt:/var/run/libvirt \
	-w$(pwd) \
	--network host \
	-it beshleman/runvm ssh
```

### Script

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
