package Git::XS::LibGit2;
use 5.008003;
use strict;
use warnings;

use XSLoader;
XSLoader::load 'Git::XS::LibGit2';
use base 'Exporter';

our @EXPORT_OK = qw(Load Dump);

1;

=head1 NAME

Git::XS::LibGit2 - An XS Wrapper Module of libgit2

=cut
