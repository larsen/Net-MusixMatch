use Test::More tests => 5;
use Net::MusixMatch;

my $apikey = $ENV{ APIKEY };

SKIP: {

    skip "APIKEY env variable not defined!", 5 unless $apikey;

    my $mxm = Net::MusixMatch->new( apikey => $apikey );

    ok( my $track = $mxm->get_track( track_id => 9113737 ));

    isa_ok( $track, 'Net::MusixMatch::Track' );
        can_ok( $track, 'track_name' );
        can_ok( $track, 'artist_name' );

    diag( "Track name: " . $track->track_name );
    diag( "Artist name: " . $track->artist_name );

    ok( my @tracks = $mxm->search_track( q_track => 'Yesterday' ));

    foreach my $t ( @tracks ) {
        diag $t->track_name;
    }

}
