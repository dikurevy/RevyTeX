#!/usr/bin/env perl
use 5.022;
use warnings;

die("Usage: ./make_vcf.pl <nick> <name> <email> <phone>") unless @ARGV==4;

my ($nick, $name, $email, $phone) = @ARGV;

my $vcard = <<EOF;
BEGIN:VCARD
VERSION;ENCODING=8BIT:3.0
FN;ENCODING=8BIT:$name
N;ENCODING=8BIT:$nick;;;;
PROFILE:VCARD
NICKNAME;ENCODING=8BIT,8BIT:$nick
ADR;ENCODING=8BIT:;;;;;;
TEL;ENCODING=8BIT:$phone
EMAIL;ENCODING=8BIT:$email
END:VCARD
EOF

open(my $f, '>', "$nick.vcf");
print $f $vcard;
close($f);
