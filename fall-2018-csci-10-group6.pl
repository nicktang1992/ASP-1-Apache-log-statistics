use strict;
use warnings;
use List::Util qw( min max );

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

 
#print $pattern;
my $count = 0;

#read file line by line till EOF
while (my $row = <$fh>) {
  chomp $row;
  
  #matching line with pattern
  if ($row =~ /${pattern}/x ){
    #print "$row\n";
	
	$count = $count+1;
	
	#print "date: ${1}\n";
	#print "status code: ${2}\n\n";
	$counts[$1-1]++;
  }

}

for($index = 0; $index < 31 ; $index++){
	my $tmp = $index+1;
	#print "$tmp = $counts[$index]\n";
}

#print "row count: ${count}\n";
#my $arrSize = scalar @counts;
#print "$arrSize\n";

#statistics 101
my $min = min @counts;
my $max = max @counts;
my $average = average(@counts);
my $median = median(@counts);
my $sd = standardDeviation($average,@counts);

print "minimum: $min\n";
print "maximum: $max\n";
print "average: $average\n";
print "median: $median\n";
print "standard deviation: $sd\n";
#TO-DO:
#Print results

sub average{
	my @data = @_;
	my $sum = 0;
	#print "@data\n";
	
	for my $i (0 .. $#data){
		$sum = $sum + $data[$i];
	}
	
	#print "$sum\n";
	#print scalar @data;
	#print "\n";
	my $average = $sum/scalar @data;
	return $average;
}


#need to pass integer before array. array before integer does not work. probably parameter of sub is just one giant concatenation of arrays.
#can be solved by passing reference. wont do it here. 
sub standardDeviation {
	my ($mean,@data) = (@_);
	#print "@data\n";
	#print "$mean\n";
	
	my $varianceSum = 0;
	#calculation
	for my $i (0 .. $#data){
		my $tmp = $data[$i] - $mean;
		$tmp = $tmp*$tmp;
		$varianceSum = $varianceSum + $tmp;
	}
	$varianceSum = $varianceSum/scalar @data;
	my $sd = sqrt($varianceSum);
	return $sd;
}

#got it form INTERNET. written by Jul 2005
sub median
{
    my @vals = sort {$a <=> $b} @_;
    my $len = @vals;
    if($len%2) #odd
    {
        return $vals[int($len/2)];
    }
    else #even
    {
        return ($vals[int($len/2)-1] + $vals[int($len/2)])/2;
    }
}
