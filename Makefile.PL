use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Net::MusixMatch',
    AUTHOR              => 'Stefano Rodighiero <stefano.rodighiero@gmail.com>',
    VERSION_FROM        => 'lib/Net/MusixMatch.pm',
    ABSTRACT_FROM       => 'lib/Net/MusixMatch.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'version'    => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Net-MusixMatch-*' },
);
