#!/usr/bin/env perl
use 5.012;
use warnings;
use Test::More;

my $tests = 3;
# Can we 'make pdf' in all three folders?

sub execute {
    my $arg = shift;
    say "\$ $arg";
    say `timeout -sKILL 15s $arg 2>&1`;
    ok($? == 0, "$arg - process exited with code: $?");
    $tests += 1;
    return;
}

execute('echo -e "TestRevy\n2020" | make ../make_pdf');
chdir('../make_pdf');

for my $dir (qw(sange sketches video)) {
    chdir($dir);
    execute('make pdf');
    ok(-f 'skabelon.pdf', "pdf generated for $dir/skabelon.tex");
    chdir('..');
}
chdir('../RevyTeX');

execute('rm -rf ../make_pdf');

done_testing($tests);
