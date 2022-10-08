# penguin_setup
![Static Analysis](https://github.com/gabrgomes/penguin_setup/actions/workflows/pull-request.yml/badge.svg) ![Functional Test](https://github.com/gabrgomes/penguin_setup/actions/workflows/funcional-test.yml/badge.svg)

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

## Options
###  General stuff
| Role  | Description | Tags | 
| ------------- | ------------- |  ------------- |
| debian  | Prereq packages for debian  | debian |
| deepin  | Keyboard fixes for deepin  | deepin |
| config_dns  | Add DNS servers  | dns |
| install_konsole  | Install and config konsole terminal  | [konsole, never] |
| install_solaar  | Install and config solaar (support for Logitech mouse) | solaar |

### Development tools
| Role  | Description | Tags | 
| ------------- | ------------- |  ------------- |
| install_zsh  | Install and config zsh, ohmyzsh and plugins | [zsh, dev] |
| config_git  | Install git and config pre-commit hooks for linters | [git, dev] |
| install_code  | Install vscode and some extensions | [code, dev] |
| install_postman  | Install postman | [postman, dev]  |
| install_directorystudio  | Install Apache Directory Studio (Ldap IDE) | [ldap, dev] |
| install_robo3t  | Install Robo3T (MongoDB IDE) | [robo3t, dev] |

### Container tools
| Role  | Description | Tags | 
| ------------- | ------------- |  ------------- |
| install_docker  | Install and config docker | [docker, container] |
| install_kubectl  | Install git and config kubectl, kubectx and stern | [kubectl, container] |
| install_helm  | Install Helm | [helm, container] |

### IaC tools
| Role  | Description | Tags | 
| ------------- | ------------- |  ------------- |
| config_ansible  | Install and config ansible | [ansible, iac] |
| install_packer  | Install Packer | [packer, iac] |
| install_terraform  | Install Helm | [terraform, iac] |

### Collaboration
| Role  | Description | Tags | 
| ------------- | ------------- |  ------------- |
| install_teams  | Install MS Teams | [teams, collab] |
