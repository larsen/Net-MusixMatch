use Test::More tests => 2;
use Net::MusixMatch;

sub diag_if_verbose {
	diag shift if $ENV{ VERBOSE };
}

my $apikey = $ENV{ APIKEY };

SKIP: {

    skip "APIKEY env variable not defined!", 2 unless $apikey;

    my $mxm = Net::MusixMatch->new( apikey => $apikey );

    ok( my $lyrics = $mxm->get_lyrics( track_id => 9113737 ));
    diag_if_verbose $lyrics->body;
    diag_if_verbose $lyrics->lyrics_id;

    ok( my @lyrics = $mxm->search_lyrics( q_track => 'Yesterday' ));
    foreach my $l ( @lyrics ) {
        diag_if_verbose $l->lyrics_id;
        diag_if_verbose $l->body;
    }
}

