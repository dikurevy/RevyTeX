#!/usr/bin/env perl
use 5.012;
use warnings;
use Test::More;

# Are folders created correctly?

my $tests = 13;

sub execute {
    my $arg = shift;
    say "\$ $arg";
    say `timeout -sKILL 15s $arg 2>&1`;
    ok($? == 0, "$arg - process exited with code: $?");
    $tests += 1;
    return;
}

execute('echo -e "TestRevy\n2020" | make ../make_manus');
chdir('../make_manus');

ok(-l 'Makefile' && -f 'Makefile', 'makefile in root exists and is symlink');
ok(-l 'revy.sty' && -f 'revy.sty', 'revy.sty in root exists and is symlink');
ok(-f '.config.mk',                 '.config.mk in root exists');

open(my $fh, '<', '.config.mk');
my $config = do { local $/; <$fh> };
close($fh);
like($config, qr{scriptdir := .*/RevyTeX/scripts}, 'scriptdir variable set in .config.mk');

for my $dir (qw(sange sketches video)) {
    chdir($dir);

    ok(-f 'skabelon.tex',              "skabelon in $dir exists");
    ok(-l 'Makefile' && -f 'Makefile', "makefile in $dir exists and is symlink");
    ok(-l 'revy.sty' && -f 'revy.sty', "revy.sty in $dir exists and is symlink");

    chdir('..');
}

chdir('../RevyTeX');
execute('rm -rf ../make_manus');

done_testing($tests);
