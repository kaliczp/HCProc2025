#!/usr/bin/perl
# Use: rm publik.txt; for i in `ls *txt`; do perl ../nevsorgen.pl $i >> publik.txt; done
use strict;
use warnings;

my $file = $ARGV[0];
open my $abstract, $file or die "Could not open $file: $!";

my $number = 0;
my $moreinst = 0;
my $inst_was = 0;
my $title = "Test";
my $authors = "Peter Kalicz";
my $articleid = $file;
print $articleid,"\n";
while (my $line = <$abstract>)
{
    $number++;
    $line =~ s/\r//g;
    chomp $line;
    # Cím kiszedés
    if($number == 1){
	$title = $line;
    }
    if($number == 2){
	# Szerzők nevének kisezdése
	my $rawauth = $line;
	if($rawauth =~ /[2-9]/){
	    $rawauth =~ s/[1-9]//g;
	    $rawauth =~ s/,,,/,/g;
	    $rawauth =~ s/,,/,/g;
	    $rawauth =~ s/, $//g;
	    $moreinst = 1;
	} else {
	    $rawauth =~ s/1//g;
	}
	# Miután a szerzők megvannak mehet a lista
	print $rawauth,"\n";
	print $title;
    }
}
print "\n\n";
close $abstract;
