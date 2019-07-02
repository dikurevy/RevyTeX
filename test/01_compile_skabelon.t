#!/usr/bin/env perl
use 5.012;
use warnings;
use Test::More;

my $tests = 3;
# Can we compile skabelon.tex in all three folders?

sub execute {
    my $arg = shift;
    say "\$ $arg";
    say `timeout -sKILL 15s $arg 2>&1`;
    ok($? == 0, "$arg - process exited with code: $?");
    $tests += 1;
    return;
}

execute('echo -e "TestRevy\n2020" | make ../compile_skabelon');
chdir('../compile_skabelon');
for my $dir (qw(sange sketches video)) {
    chdir($dir);
    execute('pdflatex skabelon.tex');
    ok(-f 'skabelon.pdf', "pdf generated for $dir/skabelon.tex");
    chdir('..');
}
chdir('../RevyTeX');
execute('rm -rf ../compile_skabelon');

done_testing($tests);
