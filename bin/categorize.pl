#!/usr/local/wu/bin/perl
use Getopt::Long;
use Tie::File;
GetOptions( "f=s" => \$importfile,  # -f=/path/file.txt
            "l=s" => \$listfile);   # -l=/path/file.txt
tie @mydata, 'Tie::File', $importfile or die "error opening $importfile";
tie @array, 'Tie::File', $listfile or die "error opening $listfile";
foreach $l (@array) {
	foreach $m (@mydata) {
		if ($m =~ m|.*$l.*|i ) {
			print "$l\n";
		} else {
			$l =~ s| ||g; # remove any spaces
			if ($m =~ m|.*$l.*|i ) {
				print "$l\n";
			}
		}
	}
}
