Here's an expanded README file for the Linux-Automation-Scripts repository:

# Linux-Automation-Scripts

This centralized repository contains a collection of useful Bash scripts for Red Hat Enterprise Linux (RHEL). These scripts can help automate common tasks, improve system performance, and streamline the administration of RHEL servers.

## Scripts

### rhel-setup.sh

This script helps to configure new RHEL devices. It uses the nmcli command-line tool, which does not require Network Manager or changes to network adapter configuration files. The script prompts the user for the device's IP address, netmask in CIDR notation, gateway, DNS address, and hostname. It then sets the device's network configuration and hostname.

#### Usage

Make sure to allow the script to be executable with `chmod +x rhel-setup.sh` before running. Then, run the following command:

```bash
./rhel-setup.sh
```

### rhel-update-script.sh

This script updates the RHEL system by installing available updates. The user is prompted to confirm the update before it is installed. The script logs its output to `/var/log/update_script.log`.

#### Usage

To use the script, run the following command:

```bash
./rhel-update-script.sh
```

### github-login.sh

This script configures Git on a Linux system and logs in to GitHub using the user's GitHub account. The script prompts the user for their email address, GitHub username, and SSH private key name (located in ~/.ssh). It then sets the Git configuration options and tests the SSH connection to GitHub. 

#### Usage

To use the script, run the following command:

```bash
./github-login.sh
```

## License

These scripts are released under the Apache License, Version 2.0. For more information, see the `LICENSE.txt` file in the root directory of this repository.