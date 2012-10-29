#!/usr/local/wu/bin/perl
use Getopt::Long;
use Tie::File;
use Date::Manip
GetOptions( "f=s" => \$importfile); # -f=/path/file.txt
tie @mydata, 'Tie::File', $importfile or die "error opening $importfile";

$fmt0 = '.*(?<m>\d\d)/(?<d>\d\d)/(?<y>\d\d)\d\d:\d\d.*'; # hertz
$fmt1 = '.*(?<m>\d\d)/(?<d>\d\d)/(?<y>\d\d\d\d)\d\d:\d\d.*'; # concentra
$fmt2 = '.*(?<y>\d\d\d\d)-(?<m>\d\d)-(?<d>\d\d).*';
$fmt3 = '.*(?<m>\d\d)/(?<d>\d\d)/(?<y>\d\d\d\d).*';
$fmt4 = '.*(?<d>\d\d)\.(?<m>\d\d)\.(?<y>\d\d\d\d).*';
$fmt5 = '.*(?<m>\d\d)/(?<d>\d\d)/(?<y>\d\d).*';
$fmt6 = '.*(?<m>\d\d)/(?<d>\d)/(?<y>\d\d).*';
$fmt7 = '.*(?<m>\d)/(?<d>\d\d)/(?<y>\d\d).*';
$fmt8 = '.*(?<m>\d)/(?<d>\d)/(?<y>\d\d).*';

foreach $m (@mydata) {
	$m =~ s| ||g; # remove any spaces
	if ( $m =~ m{$fmt0|$fmt1|$fmt2|$fmt3|$fmt4|$fmt5|$fmt6|$fmt7|$fmt8}s ){
		$date = ParseDate("$+{m}/$+{d}/$+{y}");
		$dated = UnixDate($date, "%Y/%m/%d");
		print "$dated\n;"
	}
}