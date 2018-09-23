use strict;
use warnings;
 

my @myArray=(4,8,45,21,80,7);
my $average = average(@myArray);

#print $average;
#print "\n";


my $sd = standardDeviation($average,@myArray);
print "$sd\n";

my $median = median(@myArray);
print "$median\n";


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
	print "@data\n";
	print "$mean\n";
	
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
