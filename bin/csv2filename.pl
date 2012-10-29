#!/usr/local/wu/bin/perl
use Getopt::Long;
use File::Slurp;
GetOptions( "f=s" => \$importfile); # -f=/path/file.txt
my $mydata = read_file($importfile);
$mydata =~ s| ||g;
$mydata =~ s|,|_|g;
$mydata =~ s|/|-|g;
$mydata =~ s|\.|-|g;
print "$mydata";