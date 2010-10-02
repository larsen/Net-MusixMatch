package Net::MusixMatch;
use Moose;

use Net::MusixMatch::Track;
use Net::MusixMatch::Lyrics;
use HTTP::Request::Common;
use LWP::UserAgent;
use JSON;
use Data::Dump qw/ dump /;
use Carp;

use version; our $VERSION = qv('0.0.1');

has 'base_url' => ( 
    is => 'ro', 
    default => 'http://api.musixmatch.com/'
);

has 'base_path' => (
    is => 'ro',
    default => 'ws/1.0/'
);

has 'method' => (
	isa => 'Str',
	is => 'ro',
	default => 'GET'
);

has 'apikey' => ( is => 'ro' );


sub _call_api {
	my $self = shift;

	my $api_method = shift;
	my %params = @_;

	$params{ format } //= 'JSON';
	$params{ apikey } = $self->apikey;

	my $uri = URI->new( $self->base_url );
	$uri->path( $self->base_path . $api_method );
	$uri->query_form( %params );

    my $ua = LWP::UserAgent->new;
    my $response = $ua->request( GET $uri->as_string );

    if ( $response->is_success ) {
    	
        my $json = JSON->new();
        my $decoded_structure = $json->decode( $response->decoded_content );

        return $decoded_structure;
    }
    else { 
    	warn $response->code
    }
}


sub get_track {
    my $self = shift;
    my %params = @_;

    return unless $params{ track_id } 
               || $params{ track_mbid };

    my $result = $self->_call_api( 'track.get', %params );

    my $track = Net::MusixMatch::Track->new( 
        $result->{ message }->{ body }->{ track_list }->[0]->{ track } 
    );
	return $track;
}


sub search_track {
    my $self = shift;
    my %params = @_;

    return unless $params{ q } 
               || $params{ q_track }
               || $params{ q_artist };

    my $result = $self->_call_api( 'track.search', %params );

    # We build a set of Tracks objects
    my @tracks;
    foreach my $track_structure ( @{$result->{ message }->{ body }->{ track_list }} ) {

        push @tracks, Net::MusixMatch::Track->new( $track_structure->{ track } );
    }

    return @tracks;
}


sub get_lyrics {
    my $self = shift;
    my %params = @_;

    return unless $params{ lyrics_id };

    my $result = $self->_call_api( 'lyrics.get', %params );

    my $lyrics = Net::MusixMatch::Lyrics->new( 
        $result->{ message }->{ body }->{ lyrics_list }->[0]->{ lyrics } 
    );
	return $lyrics;
}


sub search_lyrics {
    my $self = shift;
    my %params = @_;

    return unless $params{ q } 
               || $params{ q_track }
               || $params{ q_artist };

    my $result = $self->_call_api( 'lyrics.search', %params );

    # We build a set of Tracks objects
    my @lyrics;
    foreach my $lyrics_structure ( @{$result->{ message }->{ body }->{ lyrics_list }} ) {

        push @lyrics, Net::MusixMatch::Lyrics->new( $lyrics_structure->{ lyrics } );
    }

    return @lyrics;
}



1; # Magic true value required at end of module
__END__

=head1 NAME

Net::MusixMatch - Perl interface for MusixMatch API


=head1 VERSION

This document describes Net::MusixMatch version 0.0.1


=head1 SYNOPSIS

    use Net::MusixMatch;
    use Data::Dump qw/ dump /;

    my $apikey = '...';

    my $mxm = Net::MusixMatch->new( apikey => $apikey );

    my ($track)  = $mxm->search_track( q_track => 'Yesterday', q_artist => 'Beatles' );
    my ($lyrics) = $mxm->get_lyrics( lyrics_id => $track->lyrics_id );  

say $lyrics->body;

=head1 DESCRIPTION

This module implements MusixMatch API, as documented here: http://developer.musixmatch.com/

=head1 INTERFACE 

=head2 get_track( %options )

Get a track info from MusixMatch's database.



=head2 get_lyrics( %options )

Retreive the lyrics of a track identified by a lyrics id.

=head2 search_lyrics( %options )

Deprecated

=head2 search_track( %options )

Search for a track in our database


=head1 CONFIGURATION AND ENVIRONMENT

Net::MusixMatch requires no configuration files or environment variables.


=head1 DEPENDENCIES

None.


=head1 INCOMPATIBILITIES

None reported.


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-net-musixmatch@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.


=head1 AUTHOR

Stefano Rodighiero  C<< <stefano.rodighiero@gmail.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2010, Stefano Rodighiero C<< <stefano.rodighiero@gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
