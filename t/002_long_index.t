#!/usr/bin/env perl6

use Test;

use-ok('Debian::IndexParse::Grammar');
use Debian::IndexParse::Grammar;

sub MAIN($file?) {
    if (!$file) {
        skip('No file input',1);
    } else {
        my $string = slurp $file;
        my $match = Debian::IndexParse::Grammar.parse($string);
        warn $match.made.elems, " paragraphs found";
    }
}


