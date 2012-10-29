#!/usr/local/wu/bin/perl
use Getopt::Long;
GetOptions( "i=s" => \$input); # -i=somefile.cat.category.txt
if ( $input =~ m|.*\.cat\.(.*)\.txt| ){
	print "$1\n";
}