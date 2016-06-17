#!/bin/perl
#Author: Corey Thomason	

my $num_args=$#ARGV + 1;
if ($num_args != 1) {
	print "Please include the Record File as a command line argument and try again\n";
	exit;
}
my $filename=$ARGV[0];

open(my $fh, '<:encoding(UTF-8)', $filename)
	or die "Could not open file '$filename'";

my $count=0;
while (my $row = <$fh>) {

	chomp $row;
	$array[$count]=$row;
	$count++;

}

sub sortAlphabeticalFirstName {
	my @sorted=sort { lc($a) cmp lc($b) } @array;
	print "------------------------------------------------------------------------\n";
	print "All Records printed in Alphabetical order by First Name\n";
	print "------------------------------------------------------------------------\n";
	for ($i=0; $i<$#array+1; $i++) {
		print $sorted[$i], "\n";
	}
	print "------------------------------------------------------------------------\n";
	
}

sub sortAlphabeticalLastName {
	print "------------------------------------------------------------------------\n";
	print "All Records printed in Alphabetical order by Last Name\n";
	print "------------------------------------------------------------------------\n";
	my @sorted = sort { (split(/\s+/, $b))[1] cmp (split(/\s+/, $a))[1] } @array;
	for ($i=$#array; $i>=0; $i--) {
		print $sorted[$i], "\n";
	}
	print "------------------------------------------------------------------------\n";
}

sub sortReverseFirstName {
	print "------------------------------------------------------------------------\n";
	print "All Records printed in Reverse Alphabetical order by First Name\n";
	print "------------------------------------------------------------------------\n";
	my @sorted=sort { lc($a) cmp lc($b) } @array;	
	for ($i=$#sorted; $i>=0; $i--) {
		print $sorted[$i], "\n";
	}
	print "------------------------------------------------------------------------\n";
}

sub sortReverseLastName {

	print "------------------------------------------------------------------------\n";
	print "All Records printed in Reverse Alphabetical order by Last Name\n";
	print "------------------------------------------------------------------------\n";
	my @sorted = sort { (split(/\s+/, $b))[1] cmp (split(/\s+/, $a))[1] } @array;
	for ($i=0; $i<=$#sorted; $i++) {
		print $sorted[$i], "\n";
	}
	print "------------------------------------------------------------------------\n";
}	

sub searchRecordLastName {

	print "Enter last name to be searched: ";
	my $lastname = <STDIN>;
	chomp $lastname;
	print "------------------------------------------------------------------------\n";
	print "Record with the Last Name ", $lastname, "\n";
	print "------------------------------------------------------------------------\n";
	for ($i=0; $i<$#array+1; $i++) {

		my $strings=$array[$i];
		if ($strings =~ /\Q$lastname\E/) {
			print $array[$i], "\n";
		}
	}
	print "------------------------------------------------------------------------\n";
}

sub searchRecordBirthday {

	print "Enter birthday to be searched (Month/Day/Year): ";
	my $birthday = <STDIN>;
	chomp $birthday;
	print "------------------------------------------------------------------------\n";
	print "Record with the birthday ", $birthday, "\n";
	print "------------------------------------------------------------------------\n";
	for ($i=0; $i<$#array+1; $i++) {
		my $strings=$array[$i];
		if ($strings =~ /\Q$birthday\E/) {
			print $array[$i], "\n";
		}
	}
	print "------------------------------------------------------------------------\n";
}



my $input=0;


while ($input != 7) {
	print "------------------------------------------------------------------------\n";
	print "(1) List records in alphabetical order by First Name\n";
	print "(2) List records in alphabetical order by Last Name\n";
	print "(3) List records in reverse alphabetical order by First Name\n";
	print "(4) List records in reverse alphabetical order by Last Name\n";
	print "(5) Search for a record by Last Name\n";
	print "(6) Search for a record by Birthday\n";
	print "(7) Quit\n";
	print "Enter choice: ";
	$input = <STDIN>;

	if ($input == 1) {
		&sortAlphabeticalFirstName;
	}
	elsif ($input == 2) {
		&sortAlphabeticalLastName;
	}
	elsif ($input == 3) {
		&sortReverseFirstName;
	}
	elsif ($input == 4) {
		&sortReverseLastName;
	}
	elsif ($input == 5) {
		&searchRecordLastName;
	}
	elsif ($input == 6) {
		&searchRecordBirthday;
	}
	elsif ($input == 7) {
		print "Thank you for using\n";
		exit
	}
	else {
		print "Please enter a valid choice\n";
		next;
	}
}
