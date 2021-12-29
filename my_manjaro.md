# my manjaro

## situation before install

- sda     - 500Gb ssd
- nvme0n1 - 500Gb nvme
- sdc     - 1Tb   hdd
- sdb     - 120Gb ssd   - reserved
- sdd     - 32Gb  flash - install support

I will distribuite my system on sda, sdc e nvme0n1.

- nvme0n1 - main drive
- sda     - home folder and swap
- sdc     - for big files

I want to try btrfs futures so the system will be

- nvme0n1 - btrfs ( will be formatted )
- sda     - btrfs ( will be formatted )
- sdc     - ext4  ( won't be formatted )

## install procedure

- backup your data!
- make a live usb with manjaro kde (i have a pendrive with ventoy but whatever boot is ok)
- boot the live with proprietary driver
- install with calamares on the nvme0n1, chose:
  - automatic partitioning
  - btrfs
  - no swap
- reboot

## Right after install

install gparted with the store and let it do the updates it need.

With gparted create a new partition table for sda (be sure, there is no undo), chose GPT. Than create the swap, i have 32Gb of rab so 50Gb of swap, and the remaining space a btrfs partition.

![gparted](assets/2021-12-26-17-14-37.png)

and the output of this should be simimar.

```bash
> lsblk --fs
NAME        FSTYPE FSVER LABEL    UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
sda
├─sda1      swap   1              5618d796-e5de-40ac-98ee-704cbd0d94b4                [SWAP]
└─sda2      btrfs                 8c881877-e7f4-493d-a658-5422c701aca5  394,9G     0%
sdb
├─sdb1      vfat   FAT32          5AEA-94DB
├─sdb2
├─sdb3      ntfs                  2C1AEBA61AEB6AF2
└─sdb4      ntfs                  BC52CA1152C9D076
sdc
└─sdc2      ext4   1.0            a81b9eac-926e-4b3c-a6e0-7a56d5117021
sdd
├─sdd1      exfat  1.0   Ventoy   1D1B-BDD3
└─sdd2      vfat   FAT16 VTOYEFI  36FE-745E
nvme0n1
├─nvme0n1p1 vfat   FAT32 NO_LABEL 9DC0-3A68                             298,8M     0% /boot/efi
└─nvme0n1p2 btrfs                 08c1a849-60c7-4f1b-aeca-1b2815a7cdb2  454,7G     2% /var/log
                                                                                      /var/cache
                                                                                      /home
                                                                                      /
```

### Enable swap

We created the swap partition but we neet to add it to fstab. So, edit `/ect/fstab` and add and the bottom

```bash
UUID=5618d796-e5de-40ac-98ee-704cbd0d94b4 none swap defaults 0 0
```

The uuid need to be the one of the swap partition so `sda1`

### enable ssd trim

Manjaro already have the [service](https://forum.manjaro.org/t/solved-support-of-trim-on-my-ssd-hardware/38699) for that, just enable it with

```bash
> sudo systemctl enable --now fstrim.timer
```

## Move home to sda2

After the install manjaro create automatically 4 subvolumes

```bash
> sudo btrfs subvolume list -p /
ID 259 gen 798 parent 5 top level 5 path @log
ID 263 gen 798 parent 5 top level 5 path @
ID 258 gen 749 parent 5 top level 5 path @home
ID 260 gen 608 parent 5 top level 5 path @cache
```

all of those are mounted in `/etc/fstab`

```bashj
UUID=08c1a849-60c7-4f1b-aeca-1b2815a7cdb2 /              btrfs   subvol=/@,defaults,noatime,autodefrag,compress=zstd 0 0
UUID=08c1a849-60c7-4f1b-aeca-1b2815a7cdb2 /home          btrfs   subvol=/@home,defaults,noatime,autodefrag,compress=zstd 0 0
UUID=08c1a849-60c7-4f1b-aeca-1b2815a7cdb2 /var/cache     btrfs   subvol=/@cache,defaults,noatime,autodefrag,compress=zstd 0 0
UUID=08c1a849-60c7-4f1b-aeca-1b2815a7cdb2 /var/log       btrfs   subvol=/@log,defaults,noatime,autodefrag,compress=zstd 0 0
```

The uuid is always the same because they are all on `nvme0n1p2`.

We will move `@home` and `@cache` to sda2 to save space in the root ssd.

### move home to second ssd

I will follow [this](https://www.reddit.com/r/btrfs/comments/iqmbgi/comment/g4szgdl/?utm_source=share&utm_medium=web2x&context=3) for most of the steps

create mountpoint for sda2 ( name doesn't matter)

```bash
> sudo mkdir /data/ssd
```

mount the partition

```bash
> mount /dev/sda2 /data/ssd
```

Now we can check if the system recognize it.

```bash
> sudo btrfs filesystem show
Label: none  uuid: 08c1a849-60c7-4f1b-aeca-1b2815a7cdb2
        Total devices 1 FS bytes used 9.07GiB
        devid    1 size 465.46GiB used 11.02GiB path /dev/nvme0n1p2

Label: none  uuid: 8c881877-e7f4-493d-a658-5422c701aca5
        Total devices 1 FS bytes used 236.86MiB
        devid    1 size 397.13GiB used 3.02GiB path /dev/sda2
```

home is a subvolume of /

```bash
> sudo btrfs subvolume list / |grep home
ID 257 gen 313 top level 5 path @home
```

To move it to another drive we need to create a snapshot and copy it to the second drive.

```bash
> sudo btrfs subvolume snapshot -r /home /home_snap
Create a readonly snapshot of '/home' in '//home_snap'
```

```bash
> btrfs filesystem sync /
```

Now we have 2 subvolume, `@home` and `home_snap`

```bash
> sudo btrfs subvolume list / |grep home
ID 257 gen 313 top level 5 path @home
ID 255 gen 315 top level 5 path home_snap
```

Send the readonly snapshot to new drive which is mounted as `/data/ssd`

```bash
> btrfs send /home_snap | btrfs receive /data/ssd
```

```bash
> btrfs filesystem sync /data/ssd
```

Now rename it to desired name and made it read-write

```bash
> sudo btrfs subvolume snapshot /data/ssd/home_snap /data/ssd/@home
Create a snapshot of '/data/ssd/home_snap' in '/data/ssd/@home'
```

Removed unnecessary snapshots

```bash
> btrfs subvolume delete /data/ssd/home_snap /home_snap
```

update `/etc/fstab`

```bash
UUID=9DC0-3A68                            /boot/efi      vfat    umask=0077 0 2
UUID=08c1a849-60c7-4f1b-aeca-1b2815a7cdb2 /              btrfs   subvol=/@,defaults,noatime,autodefrag,compress=zstd 0 0

# need to update this line with the new uuid, but if wrong the pc will not boot, so for fast recovery leave it commented and copy past it to the bottom
#UUID=08c1a849-60c7-4f1b-aeca-1b2815a7cdb2 /home          btrfs   subvol=/@home,defaults,noatime,autodefrag,compress=zstd 0 0

UUID=08c1a849-60c7-4f1b-aeca-1b2815a7cdb2 /var/cache     btrfs   subvol=/@cache,defaults,noatime,autodefrag,compress=zstd 0 0
UUID=08c1a849-60c7-4f1b-aeca-1b2815a7cdb2 /var/log       btrfs   subvol=/@log,defaults,noatime,autodefrag,compress=zstd 0 0


# this is the new line, the uuid is of /dev/sda2 (same as above)
UUID=8c881877-e7f4-493d-a658-5422c701aca5 /home          btrfs   subvol=/@home,defaults,noatime,autodefrag,compress=zstd 0 0


UUID=5618d796-e5de-40ac-98ee-704cbd0d94b4 none swap defaults 0 0
```

now reboot and if it boot

```bash
NAME        FSTYPE FSVER LABEL    UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
sda
├─sda1      swap   1              5618d796-e5de-40ac-98ee-704cbd0d94b4                [SWAP]
└─sda2      btrfs                 8c881877-e7f4-493d-a658-5422c701aca5  394,9G     0% /home

sdb
├─sdb1      vfat   FAT32          5AEA-94DB
├─sdb2
├─sdb3      ntfs                  2C1AEBA61AEB6AF2
└─sdb4      ntfs                  BC52CA1152C9D076
sdc
└─sdc2      ext4   1.0            a81b9eac-926e-4b3c-a6e0-7a56d5117021
sdd
├─sdd1      exfat  1.0   Ventoy   1D1B-BDD3
└─sdd2      vfat   FAT16 VTOYEFI  36FE-745E
nvme0n1
├─nvme0n1p1 vfat   FAT32 NO_LABEL 9DC0-3A68                             298,8M     0% /boot/efi
└─nvme0n1p2 btrfs                 08c1a849-60c7-4f1b-aeca-1b2815a7cdb2  454,7G     2% /var/log
                                                                                      /var/cache
                                                                                      /
```

we see that home is under `sda2`, check if everything is there!

To remove the old subvolume `/@home` we need to:

```bash
> sudo mkdir /data/temp
> sudo mount -o subvolid=0 /dev/nvme0n1p2 /data/temp
> sudo btrfs subvolume delete /data/temp/@home
```

and than reboot.

### move cache to second ssd

currently we have

```bash
> sudo btrfs subvolume list /
ID 256 gen 388 top level 5 path @
ID 258 gen 383 top level 5 path @cache
ID 259 gen 388 top level 5 path @log
```

The step are similar to the one above:

```bash
> sudo btrfs subvolume snapshot -r /var/cache /var/cache_snap
Create a readonly snapshot of '/var/cache' in '/var/cache_snap'
```

```bash
> btrfs filesystem sync /
```

```bash
> sudo mount /dev/sda2 /data/ssd
```

```bash
> sudo btrfs send /var/cache_snap | sudo btrfs receive /data/ssd
At subvol /var/cache_snap
At subvol cache_snap
```

```bash
> btrfs filesystem sync /data/ssd
```

```bash
> sudo btrfs subvolume snapshot /data/ssd/cache_snap /data/ssd/@cache
Create a snapshot of '/data/ssd/cache_snap' in '/data/ssd/@cache'
```

```bash
> sudo btrfs subvolume delete /data/ssd/cache_snap /var/cache_snap
Delete subvolume (no-commit): '/data/ssd/cache_snap'
Delete subvolume (no-commit): '/var/cache_snap'
```

update fstab

```bash
> vim /etc/fstab
UUID=9DC0-3A68                            /boot/efi      vfat    umask=0077 0 2
UUID=08c1a849-60c7-4f1b-aeca-1b2815a7cdb2 /              btrfs   subvol=/@,defaults,noatime,autodefrag,compress=zstd 0 0
# UUID=08c1a849-60c7-4f1b-aeca-1b2815a7cdb2 /home          btrfs   subvol=/@home,defaults,noatime,autodefrag,compress=zstd 0 0
# UUID=08c1a849-60c7-4f1b-aeca-1b2815a7cdb2 /var/cache     btrfs   subvol=/@cache,defaults,noatime,autodefrag,compress=zstd 0 0
UUID=08c1a849-60c7-4f1b-aeca-1b2815a7cdb2 /var/log       btrfs   subvol=/@log,defaults,noatime,autodefrag,compress=zstd 0 0


UUID=8c881877-e7f4-493d-a658-5422c701aca5 /home          btrfs   subvol=/@home,defaults,noatime,autodefrag,compress=zstd 0 0
UUID=8c881877-e7f4-493d-a658-5422c701aca5 /var/cache     btrfs   subvol=/@cache,defaults,noatime,autodefrag,compress=zstd 0 0


UUID=5618d796-e5de-40ac-98ee-704cbd0d94b4 none swap defaults 0 0
```

reboot!

and now we have `@cache` on the ssd too

```bash
> lsblk --fs
NAME        FSTYPE FSVER LABEL    UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
sda
├─sda1      swap   1              5618d796-e5de-40ac-98ee-704cbd0d94b4                [SWAP]
└─sda2      btrfs                 8c881877-e7f4-493d-a658-5422c701aca5  394,5G     0% /var/cache
                                                                                      /home
sdb
├─sdb1      vfat   FAT32          5AEA-94DB
├─sdb2
├─sdb3      ntfs                  2C1AEBA61AEB6AF2
└─sdb4      ntfs                  BC52CA1152C9D076
sdc
└─sdc2      ext4   1.0            a81b9eac-926e-4b3c-a6e0-7a56d5117021
nvme0n1
├─nvme0n1p1 vfat   FAT32 NO_LABEL 9DC0-3A68                             298,8M     0% /boot/efi
└─nvme0n1p2 btrfs                 08c1a849-60c7-4f1b-aeca-1b2815a7cdb2  454,9G     2% /var/log
                                                                                      /
```

we still need to delete the old one

```bash
> sudo mount -o subvolid=0 /dev/nvme0n1p2 /data/temp
> sudo btrfs subvolume delete /data/temp/@cache
```

reboot again to confirm the everithing is ok

## basic programs

- gimp      ( official repo )
- telegram  ( official repo )
- alacritty ( official repo )
- redshift  ( official repo )
- xclip     ( official repo ) - is needed by the vscode extensions
- vscode    ( aur - visual-studio-code-bin )
- redshift tray icon ( aur - [plasma5-applets-redshift-control-git](https://aur.archlinux.org/packages/plasma5-applets-redshift-control-git/) )

### error fixup

While installing things i got a lot this type of error in the log of pamac:

```bash
ftp://mirror.easyname.at/manjaro/stable/core/x86_64/core.db: Operation not supported
```

and after searching around:

```bash
sudo pacman-mirrors --country all --api --protocols all --set-branch stable && sudo pacman -Syyu
```

this will requery all mirrors ( can take a while )

### redshift config

To add the tray icon as plasma widget:

1. go into edit panel mode

    ![panel](assets/2021-12-26-16-45-00.png)

2. press on add widgets

    ![add](assets/2021-12-26-16-46-12.png)

3. search for the redshift one

    ![widget](assets/2021-12-26-18-42-45.png)

4. drag and frop it on the panel

    ![panle](assets/2021-12-26-18-43-34.png)

5. to configure it, righclick and:

    ![configure](assets/2021-12-26-18-44-37.png)
    ![config](assets/2021-12-28-16-08-13.png)

### vscode basic config ( needed to edit this file )

install the "markdown" and "paste-image" extensions:

![extensions](assets/2021-12-26-16-44-15.png)

this allows basic markdown edit and the ability to paste screenshot from Spectacle directly into vscode.

## Pipewire and sound test

Install:

- `manjaro-pipewire` - Officail repo
- `spotify`          - Aur

from the store, it will remove a bunch of pakages and install some others.

Now reboot and test the audio.

### errors fixup

If you get:

```bash
==> Validating source files with sha512sums...
    spotify.protocol ... Passed
    LICENSE ... Passed
    spotify-1.1.72.439-x86_64.deb ... Passed
    spotify-1.1.72.439-3-Release ... Skipped
    spotify-1.1.72.439-3-Release.sig ... Skipped
    spotify-1.1.72.439-3-x86_64-Packages ... Skipped
==> Verifying source file signatures with gpg...
    spotify-1.1.72.439-3-Release ... FAILED (unknown public key 5E3C45D7B312C643)
==> ERROR: One or more PGP signatures could not be verified!
Failed to build spotify
```

Check on the [aur page](https://aur.archlinux.org/packages/spotify):

```bash
> curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --import -
```

And rebuild.

With pipewire you can select the codec for every device.

## Firefox setup

If you have your old profile folder:

1. launch firefox from terminal with `firefox -P`, deselect the checkbox
2. press crate profile and name it what you want
3. start firefox and go to help -> Troubleshooting information -> profile directory -> open directory
4. go one level back with the directories:

    ```bash
    56cnzqg5.default  
    'Crash Reports'  
    installs.ini   
    o0txjmgx.default-release  
    'Pending Pings'   
    profiles.ini   
    sav6owru.general   
    xp5m27qq.work-cloe
    ```

5. close every instance of firefox
6. open the pofile you have just created and paste the content of the your backup, overwrite everithing
7. reopen firefox and it should ask what profile you want to open, otherwhise lunch it with `firefox -P`

## plasma setup

### panel

edit the panel to have:

![panel](assets/2021-12-28-15-33-04.png)

1. application launcher
2. global menu
3. spacer
4. icon only task manager
   - in settings select:
        - do not group
        - sort alphabetically
        - clik the active task does nothing
        - middle click does nothing
        - mouse whell does nothing
        - show only task from current desktop
5. spacer
6. pager
7. redshift control
8. caffeine plus
9. system tray
10. digital clock

### tiling

install [`kwin-bismuth`](https://github.com/Bismuth-Forge/bismuth) from aur, than:

1. go to settings -> workspace behavior -> virtual desktops, select 4 rows and add 5 desktop for every row. 20 desktop total
2. windown managment -> window tiling -> enable tiling
3. next we need to take care of the shortcuts
    - Alacritty
       - New=Meta+Return
    - kwin
        - Window Close=Meta+Shift+Q
        - Switch One Desktop Down=Meta+Down
        - Switch One Desktop Up=Meta+Up
        - Switch One Desktop to the Left=Meta+Left
        - Switch One Desktop to the Right=Meta+Right
        - Switch Window Down=Meta+Alt+Down
        - Switch Window Left=Meta+Alt+Left
        - Switch Window Right=Meta+Alt+Right
        - Switch Window Up=Meta+Alt+Up
        - Window One Desktop Down=Meta+Ctrl+Shift+Down
        - Window One Desktop Up=Meta+Ctrl+Shift+Up
        - Window One Desktop to the Left=Meta+Ctrl+Shift+Left
        - Window One Desktop to the Right=Meta+Ctrl+Shift+Right
        - Window Fullscreen=Meta+Alt+F
        - bismuth_next_layout=Meta+\\
        - bismuth_prev_layout=Meta+|
        - bismuth_rotate=Meta+R
        - bismuth_rotate_part=Meta+Shift+R
        - ExposeAll=Meta+Ctrl+Tab
        - ShowDesktopGrid=Meta+Tab
    - spectacle
        - RectangularRegionScreenShot=Meta+Shift+S

### google integration

1. install `kio-gdrive`
2. go to setting -> online accounts -> add google
3. select drive
4. now you have drive in dolphin -> network -> google drive
5. for calendar install `KOrganizer` and configure it

### vscode settings

1. install `gnome-keyring`
2. login on vscode with github
3. for the font:
    1. install `ttf-fira-code`
    2. restart vscode, for any error see [this](https://github.com/tonsky/FiraCode/wiki/VS-Code-Instructions)
4. if the font in the terminal is wrong edit in the settings

    ```json
    "terminal.integrated.fontFamily": "Fira Code",
    ```

5. for spellright:
    1. install `hunspell-en_US` and `hunspell-it`
    2. confirm that the dictionaries are present in `/usr/share/hunspell/*`
    3. `mkdir ~/.config/Code/Dictionaries`
    4. `ln -s /usr/share/hunspell/* ~/.config/Code/Dictionaries`
    5. select the dictioraries from the eye like icon in the lower right

### git and github

