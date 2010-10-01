use Test::More tests => 2;
use Net::MusixMatch;

my $apikey = $ENV{ APIKEY };

SKIP: {

    skip "APIKEY env variable not defined!", 2 unless $apikey;

    my $mxm = Net::MusixMatch->new( apikey => $apikey );

    ok( my $lyrics = $mxm->get_lyrics( lyrics_id => 123 ));
    diag $lyrics->body;
    diag $lyrics->lyrics_id;

    ok( my @lyrics = $mxm->search_lyrics( q_track => 'Yesterday' ));
    foreach my $l ( @lyrics ) {
        diag $l->lyrics_id;
        diag $l->body;
    }
}
