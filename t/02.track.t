use Test::More tests => 6;
use Net::MusixMatch;
use Data::Dump qw/ dump /;

my $apikey = $ENV{ APIKEY };

SKIP: {

    skip "APIKEY env variable not defined!", 6 unless $apikey;

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


    ok( my @chart = $mxm->get_track_chart );

}
