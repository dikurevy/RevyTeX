#!/usr/bin/env perl
use 5.012;
use warnings;
use utf8::all;

=head1 NAME

overview.pl - Run in folder of a given year, to get an overview of everything in the plan.

=head1 DESCRIPTION

Useful for getting an overview of all materials. To get an overview of this:

 make aktoversigt.plan www/json.js
 path/to/overview.pl www/json.js > overview.md

=cut

use JSON qw/from_json/;

open(my $f, '<', $ARGV[0]);
my $json = do { local $/; <$f> };
close($f);

my $data = from_json($json);

for my $act (@{ $data->{acts} }) {
    printf("# %s\n\n", $act->{title});
    for my $material (@{ $act->{materials} }) {
        my $melody = "";
        if ($material->{melody}) {
            $melody = sprintf(" (%s - %s)", $material->{composer} // 'Ukendt kunstner', $material->{melody} // 'Ukendt melodi');
        }
        printf("## %s%s\n", $material->{title}, $melody);
        printf("* Filnavn: %s\n", $material->{location});
        printf("* Forfattere: %s\n", $material->{author});
        printf("* Status: %s\n", $material->{status});
        printf("* Version: %s\n", $material->{version});
        say "";
    }

}

