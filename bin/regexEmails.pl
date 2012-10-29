#!/usr/local/wu/bin/perl
use Getopt::Long;
use Tie::File;
GetOptions( "f=s" => \$importfile); # -f=/path/file.txt
tie @mydata, 'Tie::File', $importfile or die "error opening $importfile";
$fmt =  '.*\s(\S+@\S+)\s.*';
#$fmt = '/.*?\s+<?(\S+?)>?\s+F=/';
@formats = ($fmt);
foreach $a (@formats) {
	foreach $m (@mydata) {
		if ( $m =~ m{$a} ){	
			$email = $1;
			if ( $email =~ m{.*\w+@\w+.*} ) {
				print "$email\n";
			}
		}		
	}
}