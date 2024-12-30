### Docker Terminal Utilities
Needs to be placed in a valid $PATH directory, can be moved to `~/.local/bin/` using `appimage-installer.sh`. or elsewhere manually before these commands can be used:
- Enter container bash shell: `dku bash [CONTAINER NAME/ID]`
- Enter container sh shell: `dku sh  [CONTAINER NAME/ID]`
- Print container's docker IP/bound ports (leave name/id blank to see all containers] : `dku net [CONTAINER NAME/ID]`
=======
Needs to be placed in valid `$PATH` and renamed `dku` to use commands without invoking the appimage file:
- **Any Type of Sudoless Docker Setup is Required for It to Function (working on it)**
	- Enter container bash shell: `dku bash [CONTAINER NAME/ID]`
	- Enter container sh shell: `dku sh  [CONTAINER NAME/ID]`
	- Print container's docker IP/bound ports (leave name/id blank to see all containers] : `dku net [CONTAINER NAME/ID]`
