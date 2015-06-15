##
## Put me in ~/.irssi/scripts, and then execute the following in irssi:
##
##       /load perl
##       /script load ns-notify.pl
##
##       script based on irssi-libnotify and by Luke Macken & Paul W. Frields 
##

use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
use HTML::Entities;

$VERSION = "1.0";
%IRSSI = (
    authors     => 'Félix Defrance',
    contact     => 'github@d2france.fr',
    name        => 'ns-notify.pl',
    description => 'Use notify-send to alert user to hilighted messages',
    license     => 'GNU General Public License',
    url         => 'https://github.com/FelixDefrance/irssi_ns-notify.git',
);

Irssi::settings_add_str('notify', 'notify_debug', '');

sub sanitize {
  my ($text) = @_;
  encode_entities($text,'\'<>&');
  my $apos = "&#39;";
  my $aposenc = "\&apos;";
  $text =~ s/$apos/$aposenc/g;
  $text =~ s/"/\\"/g;
  $text =~ s/\$/\\\$/g;
  $text =~ s/`/\\"/g;
  return $text;
}

sub notify {
    my ($server, $summary, $message) = @_;

    # Make the message entity-safe
    $summary = sanitize($summary);
    $message = sanitize($message);

    my $debug = Irssi::settings_get_str('notify_debug');
    my $nodebugstr = '- ';
    if ($debug ne '') {
        $nodebugstr = '';
    }

    my $cmd = `notify-send -t 500 -i ~/.irssi/icons/irssi.png "${summary}" "${message}"`;
    $server->command($cmd);
    }

sub message_private_notify {
    my ($server, $msg, $nick, $address) = @_;

    return if (!$server);
    notify($server, "PM ".$nick, ": ".$msg);
}
sub message_notice {
    my ($server, $msg, $nick, $address) = @_;

    return if (!$server);
    notify($server, "Notice ".$nick, ": ".$msg);
}


Irssi::signal_add('message private', 'message_private_notify');
Irssi::signal_add('message irc notice', 'message_notice');
