# My curious cc build environment
## Background
This is a container with a compiler and emacs pre installed, along with bits for
pulling seamlessly from github. It runs a sshd server, so that starting after starting an X server on the host, one can get a remote emacs X11 session:
```
% ssh -Y localhost:2222
% emacs&
```

Why do we do this. I/O on both MacOS and WSL2 are both pretty bad. Also, we want to run the full IDE features under lsp-mode, including clangd, etc. This is the easiest way I have found.

# Installation
Assuming you have docker installed, edit the variables in build.sh to select the linux distro, distro version, toolchain, and toolchain version you want. Then just
```
% ./build.sh
```
