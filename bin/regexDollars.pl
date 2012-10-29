#!/usr/local/wu/bin/perl
use Getopt::Long;
use Tie::File;
GetOptions( "f=s" => \$importfile); # -f=/path/file.txt
tie @array, 'Tie::File', $importfile or die "error opening $importfile";

# note these formats are reversed due to legacy implementation
$fmt =  '.*(\d{2}\.\d{6}\s*\$).*';
$fmt0 = '.*(\d{2}\.\d{5}\s*\$).*';
$fmt1 = '.*(\d{2}\.\d{4}\s*\$).*';
$fmt2 = '.*(\d{2}\.\d{3}\s*\$).*';
$fmt3 = '.*(\d{2}\.\d{2}\s*\$).*';
$fmt4 = '.*(\d{2}\.\d{1}\s*\$).*';
$fmt5 = '.*(\d{2}\.\s*\$).*';

$fmt6  = '.*(\d{2}\s\d{6}\s*\$).*';
$fmt7  = '.*(\d{2}\s\d{5}\s*\$).*';
$fmt8  = '.*(\d{2}\s\d{4}\s*\$).*';
$fmt9  = '.*(\d{2}\s\d{3}\s*\$).*';
$fmt10 = '.*(\d{2}\s\d{2}\s*\$).*';
$fmt11 = '.*(\d{2}\s\d{1}\s*\$).*';
$fmt12 = '.*(\d{2}\s\s*\$).*';

$fmt13 = '.*(\d{2}\.\d{6}\s*).*';
$fmt14 = '.*(\d{2}\.\d{5}\s*).*';
$fmt15 = '.*(\d{2}\.\d{4}\s*).*';
$fmt16 = '.*(\d{2}\.\d{3}\s*).*';
$fmt17 = '.*(\d{2}\.\d{2}\s*).*';
$fmt18 = '.*(\d{2}\.\d{1}\s*).*';
$fmt19 = '.*(\d{2}\.\s*).*';

$fmt20 = '.*(\d{6}\s*\$).*';
$fmt21 = '.*(\d{5}\s*\$).*';
$fmt22 = '.*(\d{4}\s*\$).*';
$fmt23 = '.*(\d{3}\s*\$).*';
$fmt24 = '.*(\d{2}\s*\$).*';
$fmt25 = '.*(\d{1}\s*\$).*';

@formats = ($fmt, $fmt0, $fmt1, $fmt2, $fmt3, $fmt4, $fmt5
	        ,$fmt6, $fmt7, $fmt8, $fmt9, $fmt10, $fmt11, $fmt12
	        ,$fmt13, $fmt14, $fmt15, $fmt16, $fmt17, $fmt18, $fmt19
	        ,$fmt20, $fmt21, $fmt22, $fmt23, $fmt24, $fmt25
	       );
$highestPrice = 0;
$v = 0;

foreach $a (@array) {
	if ($a =~ m|cash|i) {
		;
	} elsif ($a =~ m|change|i) {
		;
	} else {
		foreach $f (@formats) {
			if (reverse($a) =~ m{$f}) {
				$v = reverse($1);
				$v =~ s|\$| |g; # remove the dollar sign
				$v = trim($v);  # trim whitespace from begin and end
				$v =~ s| |\.|g; # remaining possible white space rather than period, so but the period in
				if ($v > $highestPrice) {
					$highestPrice = $v;
				}
			}
		}
	}
}
if ($highestPrice > 0) {
	print "$highestPrice";
}
exit;

sub trim {
    my($str) = shift =~ m!^\s*(.+?)\s*$!i;
    defined $str ? return $str : return '';
}