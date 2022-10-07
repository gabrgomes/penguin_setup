# Install crouton
https://github.com/dnschneid/crouton#the-easy-way-assuming-you-want-an-ubuntu-lts-with-xfce
Download: https://goo.gl/fd3zc
Open shell: (Ctrl+Alt+T, type shell and hit enter)
```
sudo install -Dt /usr/local/bin -m 755 ~/Downloads/crouton
```

# Install bionic beaver chroot
https://github.com/dnschneid/crouton/wiki/3-Steps-to-Install-Bionic-Beaver
```
sudo crouton -r bionic -t core,audio,cli-extra
sudo enter-chroot
sudo apt-get install xterm xinit
exit
sudo crouton -r bionic -t xiwi,extension,keyboard,touch -u
```

# Configure audio
https://github.com/dnschneid/crouton/wiki/Access-audio-hardware-directly-(ALSA,-JACK)
```bash
sudo enter-chroot
sudo usermod -a -G hwaudio "$USER"
sudo apt-get install jackd2
sudo dpkg-reconfigure -p high jackd
```

# Install bitwig-studio

# Create start script
sudo enter-chroot
vim start-bitwig.sh
```
#!/bin/sh
export JACK_NO_AUDIO_RESERVATION=1

###jack-to-cras
#/usr/bin/jackd -r -s -v -d alsa -P cras &

###direct access to hardware (Scarlett 2i2)
/usr/bin/jackd -dalsa -dhw:USB -r44100 -p256 -n2 &

xiwi -F bitwig-studio

killall jackd
```
chmod +x start-bitwig.sh

# Create alias on cros
cd
vim .bashrc
```
alias bitwig="sudo initctl stop cras && sudo enter-chroot xiwi -T '/home/gabrgomes/start-bitwig.sh' && sudo initctl start cras"
```


 
