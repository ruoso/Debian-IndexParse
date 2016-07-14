#!/usr/bin/env perl6

use Test;

use-ok('Debian::IndexParse::Grammar');
use Debian::IndexParse::Grammar;

my ($string, $match);

$string = "Package: foo\n";
$match = Debian::IndexParse::Grammar.parse($string);
ok($match, 'matched');

$string = "Package: foo\nThis: That\n";
$match = Debian::IndexParse::Grammar.parse($string);
ok($match, 'matched');

$string = "Package: foo\nThis: That\n\nPackage: bar\nThat: This\n";
$match = Debian::IndexParse::Grammar.parse($string);
ok($match, 'matched');

$string = "Package: foo\nThis: That\n\nPackage: bar\nThat: This\n";
$match = Debian::IndexParse::Grammar.parse($string);
ok($match, 'matched');

$string = "Package: foo\nThis: That\n\nPackage: bar\nThat: This\n cont\n";
$match = Debian::IndexParse::Grammar.parse($string);
ok($match, 'matched');

my $data = $match.made;

is($data.elems, 2, 'two paragraphs');
is($data[0]<Package>, 'foo', 'Package name is foo');
is($data[1]<Package>, 'bar', 'Package name is bar');

done-testing();
