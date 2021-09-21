# My curious cc build environment
## Background
This is a container with a compiler and emacs pre installed, along with bits for
pulling seamlessly from github. It runs a sshd server, so that after starting an X server on the host, one can get a remote emacs X11 session:
```
% DISPLAY=:0 ssh -Y localhost:2222
% emacs&
```

Why do we do this? I/O on both MacOS and WSL2 are both pretty bad. Also, we want to run the full IDE features under lsp-mode, including clangd, etc. This is the easiest way I have found.

# Installation
Assuming you have docker installed, edit the variables in build.sh to select the linux distro, distro version, toolchain, and toolchain version you want. You need your github ssh key (mine is `~/shared/keys/github_ecdsa`), and another key to use between the container and the host (mine is `~/shared/keys/docker_ecvsa`). If your keys are somewhere else, edit `build.sh`. 


The [my .emacs.d config](https://github.com/stelfer/emacs.d) is hard-coded in Dockerfile. If you want to point somewhere else, up to you to figure that out.

Then just
```
% ./build.sh
```
This will start a new container on port 2222.


In `~/.ssh/config` on your local machine
```
Host github.com 
     IdentityFile ~/shared/keys/github_ecdsa

Host dev
     HostName 127.0.0.1
     Port 2222
     IdentityFile ~/shared/keys/docker_ecdsa
     ForwardX11 yes
     ForwardX11Trusted yes
     
```

Then you can access the container with
```
% DISPLAY=:0 ssh dev
```
Of course, you can arrange to set `DISPLAY` as you wish.

If there's trouble with the size of the X11 window, there are two options that
might work, thanks to the [Arch
wiki](https://wiki.archlinux.org/title/Xorg#Display_size_and_DPI). First run
`xdpyinfo` to get the detected resolution. Make sure that when you started the X
server you didn't specify any manual dpi settings. Something like this might
appear.

```
% xdpyinfo |  xdpyinfo.exe  | grep -B2 resolution
screen #0:
  dimensions:    3840x2160 pixels (677x381 millimeters)
  resolution:    144x144 dots per inch
```

If the value is wildly off, it's usually because X has detected the pixel count
correctly, but the screen size incorrectly. There are various remedies for this
depending on which platform you are on. The X tool `xrandr` is usually the way
to go, but some experimentation will be required. It's possible to modify
`xorg.conf` if your X server supports the file.  Since version 1.20.12 at least,
Cygwin/X XWin doesn't support the `--dpi` flag anymore, so options on Windows
may be very limited.

Whatever you do to get X to have the correct dpi, you will probably need to set `Xft.dpi` in `~/.Xresources`. You can check to see what the current setup is by doing

```
% xrdb -query | grep dpi
Xft.dpi: 96
```
If this value is not correct (mine should be 144), then place the correct value in `~/.Xresources` and run
```
% xrdb -merge ~/.Xresources
```


