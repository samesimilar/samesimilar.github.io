## (Optional) Enable SSH and VNC

*draft*

##### Important: In writing this post, I have noticed that there were issues installing and running WINE over VNC in a situation where the RPi is not also connected to a monitor (i.e. it is running "headless"). It looks like some kind of configuration issue, where WINE expects a monitor to be attached. If I find a solution I will update this note. 

You may wish to enable both SSH (remote terminal access) and the VNC Server (remote desktop) on your RPi, in case you want to access it over a local network. If you are just going to use your RPi all the time connected to a monitor, keyboard and mouse, you can skip this step. 

1. Open the RPi menu and go to Preferences -> Raspberry Pi Configuration.
2. Click the *Interfaces* tab and enable SSH and VNC.
3. Click OK.

With the RPi connected to the same local network as my MacBook, I can SSH or VNC to it by connecting to `raspberrypi.local` (that's the default host name). On Windows you may need to install some extra software to find it by name. 

I also found that connecting using the [RealVNC Viewer](https://apps.apple.com/us/app/realvnc-viewer-remote-desktop/id352019548) app on my iPad works well. Especially now since it supports native mouse control for remote computers on iPad. 

Please note, detailed info regarding SSH, VNC and all the various issues getting this working on your network is out of the scope of this article, but you can find plenty of info about it online.

![Pi configuration screen for SSH and VNC](img/nordonpi_sshconfig.png)