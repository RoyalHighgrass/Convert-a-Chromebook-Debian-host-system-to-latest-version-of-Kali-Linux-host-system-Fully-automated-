# Convert-a-Chromebook-Debian-host-system-to-latest-version-of-Kali-Linux-host-system-Fully-automated-
The provided file:

  *'chromebook_kali_config.sh'*

Is a bash script, *designed specifically for Chromebook users*, automates the process of converting the default Debian (Buster, Bullseye or Bookworm) Linux environment generally available with Chromebooks to a Kali Linux environment instead. This script was inspired by *Ruth Ake*'s youtube video titled '*Install Kali Linux On A Chromebook (No Rooting!)*'.

Although designed for Chromebook users, it is very possible that it will work fine on any debian system & comes with its own **Kali Linux xfce4 desktop environment** that can be launched or shutdown with a simple terminal command. Users of Debian systems not running on a Chromebook may possibly experience unexpected issues. If so please raise an issue for it so I can implement a fix for it.


# How to use:
1 - Download '*chromebook_kali_config.sh*' script & place in your Debian linux home directory.
**note** - Linux environment must already be setup if using a Chromebook.

2 - Make the file executable. ( **chmod +x chromebook_kali_config.sh** ).

3 - Execute file. ( **./chromebook_kali_config.sh** ).
**note** - The entire process of a full host system conversion can take up to 3 hours or more depending on your system specs.
**note** - User inputs regarding system configurations required at the start & roughly about an hour into the process. The process will be paused until user inputs are provided. Once provided the process will continue for at least another hour. Once complete, shutdown linux.

4 - Shutdown device.

5 - Turn on device.
**note** - None Chromebook users are likely to be taken straight to the *kali xfce4 desktop*, although this is where any problems are likely to occur.
**note** - Start Penguin if using a Chromebook. Launch kali xfce4 desktop with *gox* terminal command. ( **gox** ).
**note** - Once the *xfce4 desktop* has launched, click on the menu button & search for '**Synaptic Package Manager**', right click on it & select '*Edit application*'. Replace existing command with '*gox_lauch*'. Click save. Now *SPM* can properly be used to install & uninstall packages.

6 - Shutdown kali xfce4 desktop with *xgo* terminal command. ( **xgo** ). *Shutdown linux normally*.
