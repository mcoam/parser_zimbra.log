#!/usr/bin/perl -w
use strict;

my $client_ip;
my $mail_from;
my $mail_to;
my $message_id;
my $message_size;
my $message_time;
my $nr_recipient;
my $mail_id_status;


open(FILE, "zimbra.log") or die "Couldn't open mail.log: $!; aborting";
while (<FILE>) {
if ($_ =~ /(\S+ .* \d+:\d+:\d+) .* postfix\/smtpd\[.*\]: (\S+): client=.*\[(\d+\.\d+\.\d+\.\d+)\]$/) {
$message_time = $1;
$message_id = $2;
$client_ip = $3;

print "Message-ID: \t", $message_id,"\n";
print "Message-Time: \t", $message_time,"\n";
print "Client-IP: \t", $client_ip,"\n\n";
} elsif ($_ =~ /.* postfix\/qmgr\[.*\]: (\S+): from=<(\S+)>, size=(\d+), nrcpt=(\d+)/) {
$message_id = $1;
$mail_from = $2;
$message_size = $3;
$nr_recipient = $4;

print "Message-ID: \t", $message_id,	"\n";
print "Mail from: \t",	$mail_from,	"\n";
print "Messagesize: \t",	$message_size,	"\n";
print "No recipients:\t",	$nr_recipient,	"\n\n";
#} elsif ($_ =~ /.* postfix\/.*: (\S+): to=<(\S+)>/) {
} elsif ($_ =~ /.* postfix\/.*: (\S+): to=<(\S+)>, relay=.*, delay=.*, delays=.*, dsn=.*, status=.*: 250 2.0.0 Ok: queued as (\S+)/) {
$message_id = $1;
$mail_to = $2;
$mail_id_status = substr($3, 0,13);

print "Message-ID: \t",	$message_id,	"\n";
print "Mail to: \t",	$mail_to,	"\n";
print "Mail ID status: \t",	$mail_id_status,	"\n\n";

}
}
close(FILE);
