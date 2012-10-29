#!/usr/local/wu/bin/perl
use Getopt::Long;
use File::Slurp;
GetOptions( "f=s" => \$importfile); # -f=/path/file.txt
my $mydata = read_file($importfile);
$fmt =  '.*\s(\S+@\S+)\s.*';
@formats = ($fmt);
$email = "";
foreach $a (@formats) {
	if ( $mydata =~ m{$a} ) {
		$email = $1;
		if ( $email =~ m{.*\w+@\w+.*} ) {
			print "$email\n";
		}
	}
}