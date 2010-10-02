use Test::More tests => 9;

use Net::MusixMatch;

ok( my $mxm = Net::MusixMatch->new( api_key => '' ));

can_ok( $mxm, 'get_track' );
can_ok( $mxm, 'search_track' );

can_ok( $mxm, 'get_lyrics' );
can_ok( $mxm, 'search_lyrics' );

can_ok( $mxm, '_get_lwp_useragent' );
can_ok( $mxm, '_get_json_parser' );

my $lwp_useragent = $mxm->_get_lwp_useragent;
isa_ok( $lwp_useragent, 'LWP::UserAgent' );
my $second_lwp_useragent = $mxm->_get_lwp_useragent;
ok( $lwp_useragent eq $second_lwp_useragent, 
    "Multiple calls to _get_lwp_useragent return the same instance" );


