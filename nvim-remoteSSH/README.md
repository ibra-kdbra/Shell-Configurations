# ssh.nvim

WIP solution for Linux machines to use Neovim remotely. This is semi-automated
as of now, but can be developed into a plugin later on.

## Installation

We use GNU stow to symlink the files into the home directory. Alternatively you
can use `ln -s` to make symlinks yourself. Requires:

- neovim >= 0.9.0
- openssh
- systemd
- stow (optional)

Here we assume the remote machine is accessible via the URL `myremote.server`.
Replace it with the IP address or URL of your server.

### Server

Connect to the remote server for example, `ssh myremote.server`

```sh

stow -v server
systemctl start --user nvim-headless.service
systemctl enable --user nvim-headless.service
```

### Client

```sh
stow -v client
```

## Usage

From the client machine

```sh
nvim-remote-init myremote.server
nvim-remote
```
