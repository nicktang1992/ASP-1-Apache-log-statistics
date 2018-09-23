use strict;
use warnings;
use List::Util qw( min max );
use Statistics::Basic qw(:all);

#read argument for filename
my $filename = $ARGV[0];

#open file
open(my $fh, '<:encoding(UTF-8)', $filename) 
or die "Could not open file '$filename' $!";

#array of integers, counters of requests by date
my @counts = ();

#initialize counts
my $index;
for($index = 0; $index < 31 ; $index++){
	$counts[$index]=0;
}

#regex pattern
my $pattern = qq/\^
	#ip address
	\\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}
	\\s
	
	# user info
	\\S*\\s\\S*\\s
	
	#date and time
	\\[
		(\\d{2})\/May\/\\d{4}:\\d{2}:\\d{2}:\\d{2}\\s\\+\\d{4}
	\\]
	\\s
		
	#request
	\\"[^\\"]*\\"
	\\s
	
	#Success status code
	(2\\d{2})
	\\s
	
	#content length
	#\\d*
	#\\s

	#rest of the line
	.*\$/;

 
print $pattern;
my $count = 0;

#read file line by line till EOF
while (my $row = <$fh>) {
  chomp $row;
  
  #matching line with pattern
  if ($row =~ /${pattern}/x ){
    print "$row\n";
	
	$count = $count+1;
	
	print "s1: ${1}\n";
	print "s2: ${2}\n\n";
	@counts[$1-1]++;
  }

}

for($index = 0; $index < 31 ; $index++){
	print "$index = $counts[$index]\n";
}

print "row count: ${count}\n";
my $arrSize = scalar @counts;
print "$arrSize\n";

#statistics 101
my $min = min @counts;
my $max = max @counts;

#TO-DO:
#Implement Average
#Implement Mean
#Implement Standard Deviation

print "minimum: $min\n";
print "maximum: $max\n";

#TO-DO:
#Print results

