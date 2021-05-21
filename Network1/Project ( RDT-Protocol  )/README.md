# Reliable-Data-Transfer-Protocol


We have implemented a reliable data transfer protocol like TCP using raw socket. This protocol has been used in a hypothetical transportation system.
You can get more information about how this transportation system works by reading the ``Transportation_Sytem_Project.pdf`` and ``Transportation_Sytem_Demo.pdf`` files.


## Usage guide

### Requirements
* Python 3.4+
* Konsole (Konsole is a terminal emulator built on the KDE Platform). See [Konsole installation guide](https://www.howtoinstall.me/ubuntu/18-04/konsole/)

### Step 1: Download Python Codes & Text Files

### Step 2: Copy Text Files Into Current RDT-Protocol Directory
```
rm -rf RDT-Protocol/.git
cd RDT-Protocol

cp ./files/path.txt .
cp ./files/maps.txt .
cp ./files/balance.txt .
```

### Step 3: Change Scripts Permission
```
chmod +x ./script.sh
chmod +x ./script_ip.sh
```

You may have to modify ``wlp3s0`` in the `./script.sh` file according to your network interface. You can get your network interface using `ifconfig` command.

Finally, run `./script.sh` file.
