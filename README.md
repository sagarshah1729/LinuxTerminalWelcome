LinuxTerminalWelcome
=========

<img src="https://raw.githubusercontent.com/sagarshah1729/LinuxTerminalWelcome/master/BeautifulLogin.png">

Features 
--------
 * Minimal and Clean UI
 * All important parameters like OS Info, Processor Info, Memory Usage & Weather Info present
 * Simple one step install
 * Automatic detection of OS and Shell for installation
 * For manual installation, check the Banner.sh file and manually import in your distros.

Getting Started 
--------------- 
To get started with the Setup, you'll need to get 
familiar with [Git and Repo](https://source.android.com/setup/develop.html).

Initialize the Repository 
-------------------------

    git clone https://github.com/sagarshah1729/LinuxTerminalWelcome
    cd LinuxTerminalWelcome

This will clone the repository in your system!

Injecting the Banner 
--------------------
Before injecting, make sure to change the city for Weather in Banner.sh file. 
Default value which I am using here is of Bengaluru.

Install customised Welcome Message in your system with the installWelcome.sh script using this command:

     source installWelcome.sh

This will automatically inject the Welcome Banner in your system by automatically detecting your OS and Shell.

Contact Info
------------
Find me in [Telegram](https://t.me/sagarshah1729) or Email me at sagarshah2326@gmail.com.
