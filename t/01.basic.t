use Test::More tests => 5;

use Net::MusixMatch;

ok( my $mxm = Net::MusixMatch->new( api_key => '' ));

can_ok( $mxm, 'get_track' );
can_ok( $mxm, 'search_track' );

can_ok( $mxm, 'get_lyrics' );
can_ok( $mxm, 'search_lyrics' );

