# penguin_setup
[Static Analysis](https://github.com/gabrgomes/penguin_setup/actions/workflows/pull-request.yml/badge.svg) [Functional Test](https://github.com/gabrgomes/penguin_setup/actions/workflows/funcional-test.yml/badge.svg)

This is a personal repo I use to install and configure may main work tools. It's not intended to be distributed, so don' expect everything to work, there is always something broken. 

I only update the code when I need to reinstall everything in a new computer, so most of the links used and software versions are very likely to be out of date. 

All things considered, feel free to clone and use as you wish.

## Requirements
- Ansible >= 2.10.8

The script prereqs.sh will install ansible and the required roles.

Tested (eventualy) on Ubuntu 20.04 (WSL), Debian 10 (Crouton), Deepin 20 and Pop!_OS 22.04. 

## Usage
```sh
ansible-playbook setup-penguin.yml
```

You can specify which roles you want to run by using tags. Ex:
```sh 
ansible-playbook setup-penguin.yml -t code,zsh
```
