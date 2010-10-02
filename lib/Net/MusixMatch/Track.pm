package Net::MusixMatch::Track;
use Moose;

has 'track_name' => (
    is => 'ro',
    isa => 'Str'
);
has 'artist_name' => (
    is => 'ro',
    isa => 'Str'
);
has 'lyrics_id' => (
    is => 'ro',
    isa => 'Str'
);

1;
__END__

=head1 NAME

Net::MusixMatch::Track - Net::MusixMatch implementation of track object

=head1 DESCRIPTION

This class implements track objects

=head1 AUTHOR

Stefano Rodighiero  C<< <stefano.rodighiero@gmail.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2010, Stefano Rodighiero C<< <stefano.rodighiero@gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.
 

