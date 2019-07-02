#!/usr/bin/env perl
use 5.012;
use warnings;
use Test::More;

my $tests = 0;
# Does 'make' work as we would expect?

sub execute {
    my $arg = shift;
    say "\$ $arg";
    say `timeout -sKILL 1m $arg 2>&1`;
    ok($? == 0, "$arg - process exited with code: $?");
    $tests += 1;
    return;
}

execute('echo -e "TestRevy\n2020" | make ../make_manus');
chdir('../make_manus');

open(my $f, '>', 'aktoversigt.plan');
print $f <<EOF;
Akt 1
sange/skabelon.tex

Akt 2
sketches/skabelon.tex

Akt 3
video/skabelon.tex
EOF
close($f);

execute('make');

my @dirs = (qw{ www www/Individuelt });
ok(-d $_, "$_ directory made") for @dirs;
$tests += @dirs;

my @files = qw{Aktoversigt.pdf Individuelt/Skuespiller.pdf json.js json.js2.js Kontaktliste.pdf Manuskript.pdf Rekvisitliste.pdf Rolleoversigt.pdf Rolletilmelding.pdf Sangmanuskript.pdf};
ok(-f "www/$_", "www/$_ file exists") for @files;
$tests += @files;

chdir('../RevyTeX');
execute('rm -rf ../make_manus');

done_testing($tests);
