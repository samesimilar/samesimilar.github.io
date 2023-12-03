# Nord on RPi
## Running the original Nord Modular G1 Editor (v3.03 Windows) on a Raspberry Pi 4/400
##### by Michael Spears, @samesimilar, October 2023, Toronto


For quite a while I've been running the [Nord Modular](https://en.wikipedia.org/wiki/Nord_Modular) editor on my MacBook. That is: the original Windows version of Clavia's editor, running using [Crossover For Mac](https://www.codeweavers.com/crossover) on macOS 14 (Sonoma), on an Apple Silicon (M1) MacBook Air has been working well as my setup for patching my Nord Modular. Recently I happened upon the [Box86](https://github.com/ptitSeb/box86) project and discovered that it could offer a similar environment on Raspberry Pi to the Rosetta/Crossover environment that I have working on my MacBook. So I was curious to try running the Nord Editor on a Raspberry Pi 400. 

I discovered that it worked quite well! So I wanted to share the steps for setting this up, in case it is useful to anyone else. 

One important caveat right now is that if WINE will not start up properly if a display is not plugged into the HDMI-out port of the Raspberry Pi. This is unfortunate since the RPi OS includes VNC Server (remote desktop).  If I learn how to make this work in "headless" mode, then I will update this post. For now, VNC with WINE and the Nord Editor *does* work, but you need to always have a display plugged into the RPi anyway, reducing the usefulness of this solution. 

*Feedback*

My website doesn't host comments, so I invite you to post feedback or questions using the *Issues* tab at this site's [repository at Github](https://github.com/samesimilar/samesimilar.github.io/issues).

![The nord modular editor running on Raspberry Pi](img/nordonpi_nordeditor.png)

## Hardware

What you'll need is:

* A Raspberry Pi 

I'm using a [Raspberry Pi 400](https://www.raspberrypi.com/products/raspberry-pi-400/), which is a convenient format for a beginner in this space. There is a kit available that includes an SD card, power supply, a mouse and even a printed manual.

I imagine a regular [Raspberry Pi 4](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/) should also work all the same, but I haven't tested it. I don't know what the minimum requirements are. 

The setup I am describing has been tested on *Raspberry Pi OS Bullseye*. The OS image for RPi was called *Raspberry Pi OS (Legacy) with desktop and recommended software*. It's the one that came installed on the SD card that came with the RPi 400 kit. It's a 32-bit operating system. 

* A USB - MIDI Interface

Generally you will need a USB MIDI interface that doesn't require special drivers (i.e. it should be "USB class compliant"). That is to make it easy for the RPi OS to recognize it. I have tested an M-Audio UNO USB-MIDI cable, and my MOTU M4 audio interface (with MIDI ports), and both have been functional for this purpose.

## TL;DR What you need to do

Here is a summary of the procedure in case you don't need the full description. The general idea is first to install [Pi-Apps](https://github.com/Botspot/pi-apps) on your RPi, which offers "one-click" installers for Box86 and WINE. Then you can download or copy the Nord Modular Editor for Windows onto your Pi and run it with the `wine` command.  

1. First install Pi-Apps: [https://github.com/Botspot/pi-apps](https://github.com/Botspot/pi-apps).
2. Open Pi-Apps and install Box86.
3. Also in Pi-Apps, install WINE (x86). The installer will take a long time, about an hour. Just let it run. *It takes for-freakin'-ever.* You may see some error messages in the terminal during the install but it seems to go ok.
4. Download the Nord Modular editor from the web: [https://www.nordkeyboards.com/downloads/nord-modular](https://www.nordkeyboards.com/downloads/nord-modular). You want the Windows version called *Nord Modular Editor v3.03.zip Download for Windows* 
5. Extract the editor .exe file from the downloaded archive and put it somewhere convenient.
6. Connect your MIDI interface to the RPi USB.
7. You can now run the editor from the command line with the `wine` command, e.g. `wine "/path/to/Nord Modular Editor v3.03.exe"` with the path name to the executable. I recommend adding a menu item to the Raspberry Pi menu. See below for details. Note: On my RPi 400 it takes a couple minutes for the app to start up (it may seem like nothing is happening). It runs well and is perfectly snappy once it starts up. 
8. You may also want to download the Windows Help File for the editor and also download an archive of modular patches to play with. More details below. 

When the editor starts up, you should see your MIDI interface listed in the Nord editor's MIDI setup dialog box (click Setup -> MIDI...). Once that is enabled, and assuming your Nord Modular is connected, it should pop up immediately. The editor will have access to all the files on the Linux file system, so you should be able to easily open patches that you have downloaded.

*Happy patching!*

### Read on if you would like to see some more details about these steps and some screenshots...

## Start up your new Raspberry Pi

Connect your RPi to a monitor, with a keyboard and mouse (the Pi 400 conveniently has a keyboard built in), and power it up. The first time you set it up you will go through a process to select your language, locale, username, password, and connect to a WiFi network. I recommend installing the updates when it offers to, to get that out of the way. When it's finished it will reboot to the RPi desktop. *Hint:* Choose a good password if you intend to enable SSH and VNC to use your RPi remotely.

![Initial desktop](img/nordonpi_firstdesktop.png)

On the top-left of the screen,  you'll have icons for (reading from left to right): 

1. The RPi menu (like the Windows start menu)
2. Web Browser (Chromium)
3. File browser
4. Terminal 

## Install Pi-Apps

*Pi-Apps* is an installer app that lists about 200 apps for Raspberry Pi, making it easy to install a bunch of useful items each with one click. We are going to use it to install Box86 and WINE (x86). To get there, though, Pi-Apps needs to be installed using the Terminal. 

1. Click the Web Browser icon and browse to the Pi-Apps repository on Github: [https://github.com/Botspot/pi-apps](https://github.com/Botspot/pi-apps).
2. Scroll down to see the Readme file for Pi-Apps. Look for where it says "Open a terminal and run the command". 
3. Click the Terminal icon on the top left of the RPi desktop to open a terminal window. Copy and paste the *entire* Pi-Apps installer command into the Terminal prompt and execute it. 

As of this writing you are looking for:
 `wget -qO- https://raw.githubusercontent.com/Botspot/pi-apps/master/install | bash`

* Give it a few minutes to install Pi-Apps.  When it's done it will say "Installation Complete" in the terminal window. You can close the terminal window.

![Installing pi-apps](img/nordonpi_installingpiapps.png)

## Start the Pi-Apps app and install Box86 and WINE (x86)

You can find the Pi-Apps app on the RPi 'start menu' under *Accessories*. 

1. Start up Pi-Apps.
2. Click the *All Apps* option.
3. Scroll down the list and click *Box86*. 
4. Click Install.

A terminal will open and some scripts will run for a few minutes. Wait until it says it is finished before installing WINE.

* Once Box86 is installed, go back down the list of apps and click WINE (x86). Click *Install* for this one also. 

This will take about an hour to install. You may see some error messages and stuff pop up while it installs, but I just ignored them and I bet you can too. 

![Installing WINE](img/nordonpi_installingwine.png)

![Waiting for the install to finish](img/nordonpi_winewait.png)

## Download the Nord Modular Editor

Ok we are mostly done now! Head over to the Nord Keyboards website at 	[https://www.nordkeyboards.com/downloads/nord-modular](https://www.nordkeyboards.com/downloads/nord-modular) to download the editor Windows editor (*Nord Modular Editor v3.03.zip*) to your RPi. Double-click the downloaded .zip file to open the archiver utility, and extract the .exe into a convenient location. I put mine in a `nord`  subfolder of the `Music` folder. 

Now we are ready to run the editor. Plug in your USB MIDI interface and run the .exe by passing its path to the `wine` command on the terminal.

For example, I would put the following command:

`wine "/home/samesimilar/Music/nord/Nord Modular Editor v3.03.exe"`

Take care with upper- and lower-case, and notice I enclosed the full path in quotes since the path/filename has spaces in it.

After a couple minutes of zen, ("a few moments later" as is said on Spongebob) the editor will finally start up, and you should be able to set up the MIDI connection and start patching, as usual. 

For further assistance with the editor and its communication with your wonderful Nord Modular synthesizer, I'll refer you to the classic [Nord Modular manual](https://www.nordkeyboards.com/sites/default/files/files/downloads/manuals/nord-modular/Nord%20Modular%20English%20User%20Manual%20v3.0%20Edition%203.0.pdf).

![Starting the editor](img/nordonpi_startingup.png)

## Download the Windows Help File

**This and the following steps are optional ideas to improve the functionality of your setup.**

At the same Nord Keyboards page you can download the Windows Help File for the editor app. If you just click to download it, the file type is not recognized as binary data and just loads on the Browser window as garbled text. To save the file:

1. Right-click the link to the *Nord Modular v3.03 Helpfile* and select *Save link as...*
2. Place the file in the same folder as the editor .exe file.
3. The file has a slightly incorrect name as downloaded. Rename the help file to *Nord Modular Editor v3.03.HLP*. You can rename files in the RPi file browser app.

## Download the Nord Modular patch archive

Since you have the Web Browser open, why not head over to [electro-music.com](https://electro-music.com/nm_classic/) and download the entire Nord Modular Classic archive? 

## Add a Nord Modular Editor item to the Raspberry Pi "start menu"

1. Click the Raspberry Pi start menu, go down to Preferences -> Main Menu Editor
2. On the left select the submenu where you want to place the Nord editor shortcut. I selected "Sound & Video".
3. On the right, click "New Item".
4. On the Launcher Properties dialog, type the Name you want to see on the menu, and the command to run. 

The command will be the same as the one we used to start wine on the terminal.

For me it was:

`wine "/home/samesimilar/Music/nord/Nord Modular Editor v3.03.exe"`

Click 'ok' to close the editor. You should now have a launcher item for the editor on your start menu.

## Other ideas and todos

* Find a way to get the editor app to start up automatically when the RPi starts up
* Find a way to get WINE and the editor to work on VNC when the RPi doesn't have a screen attached

## Conclusion

Good luck! I hope this article is useful. Remember you can post feedback or questions using the *Issues* tab at my site's [repository at Github](https://github.com/samesimilar/samesimilar.github.io/issues). 

