use v6;
use Test;
plan *;

BEGIN { @*INC.push('lib') }

use Nonogram;

my $n = Nonogram.new(
    colspec => ([], [9], [9], [2, 2], [2, 2], [4], [4], []),
    rowspec => ([], [4], [6], [2, 2], [2, 2], [6], [4], [2], [2], [2], []),
);

lives_ok { $n.solve() }, 'can run .solve';

# note: traling spaces here must be preserved!
my $solved =
q[       
 ?????? 
 ###### 
 ## ??? 
 ## ??? 
 ###### 
 ####   
 ##     
 ##     
 ?????? 
        ];
for $solved.split("\n").kv -> $j,  $line {
    my $i = 0;
    for $line.comb -> $c {
        if $c ne '?' {
            is $n.field-rows[$j][$i], $c, "($j, $i) is '$c'";
        }
        $i++;
    }
}
done_testing;
