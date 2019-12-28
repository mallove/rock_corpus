#!/usr/bin/env perl
#
# src/get-notes-from-melody-file.pl
#
use Data::Dumper;

while (<>) {

  # print "\$_ = " . Dumper($_);

  # Skip headers and comments
  #
  # TODO: What do these headers mean?
  #   [E] [......b] [OCT=3] R*8 | 
  #   [......b] 
  #   [..b...b]
  if ($_ =~ /^[\%\[]/) {
    next;
  }

  @t = split(/\s+/, $_);

  # ...
  # tok: $VAR1 = '..';
  # tok: $VAR1 = '5.';
  # tok: $VAR1 = '71';
  # tok: $VAR1 = '..';
  # tok: $VAR1 = '|';
  # tok: $VAR1 = 'n3.';
  # ...
  foreach $t (@t) {

    # print "tok: " . Dumper($t);

    ###########################################################
    # Single notes
    ###########################################################

    # We need to separate into individual notes, e.g., 5 7 1 n3
    #
    # FIXME: What are the v and n note prefixes?  E.g., v1, v6, n3?
    # FIXME: How can we end up with 0's in the melodic line?
    # while ($t =~ /([a-z]?\d)/ig) {
    #     $note = $1;
    #
    #     # Strip off 'n' and 'v', since we don't know what it means.
    #     $note =~ s/[nv]//g;
    #
    #     print "$note ";
    # }


    ###########################################################
    # Note pairs (within a bar/measure)
    ###########################################################

    # Gather note pairs that fall within a single bar
    #
    while ($t =~ /([^|]+)/ig) {
      while ($t =~ /([a-z]?\d)/ig) {
        $notes_in_measure = $1;

        # Strip off 'n' and 'v', since we don't know what it means.
        $note =~ s/[nv]//g;

        print "$note ";
      }
    }
  }
}

print "\n";
