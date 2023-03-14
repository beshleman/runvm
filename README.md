# A tool for running vagrant VMs

This tool is meant to be used with vagrant debian/bullseye64 VMs
and is really just meant to be used with those made from the
[makevm](https://github.com/beshleman/makevm) tool.

## Usage

## Example using wrappers
```bash
# Download wrappers
$ wget https://raw.githubusercontent.com/beshleman/makevm/main/wrappers/makevm
$ wget https://raw.githubusercontent.com/beshleman/runvm/main/wrappers/boot
$ wget https://raw.githubusercontent.com/beshleman/runvm/main/wrappers/ssh
$ chmod +x makevm boot ssh

# Clone kernel
$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

# Download Debian certs (required by the vsock.x86_64 config used below, not required by other non-Debian configs)
$ mkdir -p linux/debian/certs
$ wget https://salsa.debian.org/kernel-team/linux/-/raw/master/debian/certs/debian-uefi-certs.pem \
          -O linux/debian/certs/debian-uefi-certs.pem

# Create an images directory, build the kernel, and download everything
# required to have have working Debian VM
$ mkdir -p ./images
$ ./makevm ./linux \
	https://raw.githubusercontent.com/beshleman/configs/master/vsock.x86_64 \
	./images

# The images dir now contains everything needed to work with Debian Linux
$ tree ./images
images/
├── config-6.3.0-rc1+
├── debian_bullseye.qcow2
├── initrd.img-6.3.0-rc1+
├── System.map-6.3.0-rc1+
├── vagrant.key
├── vagrant.pub
├── vmlinux
└── vmlinuz-6.3.0-rc1+

0 directories, 8 files

# In one shell/tmux session
$ ./boot -k images/vmlinuz-6.3.0-rc1+ -i ./images/initrd.img-6.3.0-rc1+ -d ./images/debian_bullseye.qcow2

# In another shell/tmux session
$ ./ssh uname -a
Linux debian11.localdomain 6.3.0-rc1+ #5 SMP PREEMPT_DYNAMIC Mon Mar 13 16:18:16 UTC 2023 x86_64 GNU/Linux
```

Save time by using a config file:

```bash
./boot -c config.sh
```

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
