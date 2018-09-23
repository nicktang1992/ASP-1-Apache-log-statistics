use strict;
use warnings;
 
my $text = "test extraction test";  

$text=~m/(extraction)/;

print "${1}";