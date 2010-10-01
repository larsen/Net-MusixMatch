package Net::MusixMatch::Lyrics;
use Moose;

has 'lyrics_id' => (
    is => 'ro',
    isa => 'Str'
);
has 'lyrics_body' => (
    is => 'rw', # FIXME
    isa => 'Str'
);

sub body {
	my $self = shift;

	if ( $self->lyrics_body ) {
		return $self->lyrics_body;
    }
    else {
    	return;
        # TODO Another call to the API to fetch the body ?
    }
}


1;
__END__

=head1 NAME

Net::MusixMatch::Lyrics - Net::MusixMatch implementation of lyrics object

=head1 DESCRIPTION

This class implements lyrics objects

=head1 INTERFACE 

=head2 body

TODO implement fetching body when we only have metadata

=head1 AUTHOR

Stefano Rodighiero  C<< <stefano.rodighiero@gmail.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2010, Stefano Rodighiero C<< <stefano.rodighiero@gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.
 


