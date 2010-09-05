class Nonogram;

has @.colspec;
has @.rowspec;

has @.field-rows = @.rowspec.map: { [ '?' xx @.colspec ] };

method max-colspec-elems {
    [max] @.colspec>>.elems;
}

method max-rowspec-elems {
    [max] @.rowspec>>.elems;
}

method Str {
    my $max-c = $.max-colspec-elems;
    my $max-r = $.max-rowspec-elems;
    my @result;
    sub sep-line {
        @result.push: '-' x $max-r;
        @result.push: '+';
        @result.push: '-' x @.colspec;
        @result.push: "+\n";
    }
    # header rows
    for ^$max-c -> $row-num {
        @result.push: '#' x $max-r;
        @result.push: '|';
        for @.colspec -> $c {
            my $i = $row-num + $c.elems - $max-c;
            if $row-num == $max-c - 1 {
                @result.push: $c[$i] // '0';
            } else {
                @result.push: $i < 0 ?? ' ' !! $c[$i];
            }
        }
        @result.push: "|\n";
    }
    sep-line();

    # rows
    for @.rowspec.kv -> $row-num, $r {
        if $r {
            @result.push: ' ' x ($max-r - $r.elems);
            @result.push: $r.join;
        } else {
            @result.push: ' ' x ($max-r - 1);
            @result.push: '0';
        }
        @result.push: '|';
        @result.push: @.field-rows[$row-num].join();
        @result.push: "|\n";
    }
    sep-line();

    @result.join;
}


# vim: ft=perl6
