======================
Irssi ns-notify script
======================
Use this script if you use irssi and you just want enable notifications from irc channels when anybody speak with you. 

This script is based on Luke Macken & Paul W. Frields irssi-libnotify 

How to use it ?
===============
Clone this repository :

  - git clone https://github.com/FelixDefrance/ns-notify.git

Link your irssi config ::

  ln -s path_where_you_clone/ns-notify/ns-notify.pl ~/.irssi/scripts/ns-notify.pl
  ln -s path_where_you_clone/ns-notify/icons/irssi.png ~/.irssi/icons/irssi.png

And run into irssi ::

  /load perl
  /script load ns-notify
