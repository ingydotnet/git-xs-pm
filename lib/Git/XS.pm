##
# name:      Git::XS
# abstract:  Perl XS Wrapper of libgit2
# author:    Ingy döt Net <ingy@cpan.org>
# license:   perl
# copyright: 2011

use 5.010;
use strict;
use warnings;
use Mo 0.30 ();

package Git::XS;
use Mo qw'default';
use Git::XS::LibGit2;

our $VERSION = '0.01';

has repo_path => ();
has stdout => ();
has stderr => ();
has error => ();
has is_open => (default => sub {0});
has is_closed => (default => sub {0});

sub open {
    my $self = shift;
    die "Git::XS object already open" if $self->is_open;
    die "Git::XS object already closed" if $self->is_closed;
    $self->open(1);
}

sub close {
    my $self = shift;
    die "Git::XS object is not open" unless $self->is_open;
    die "Git::XS object already closed" if $self->is_closed;
    $self->close(1);
}

1;

=head1 SYNOPSIS

    use Git::XS;

    my $git = Git::XS->new();
    
    $git->open("path/to/git/repo");

    print $git->status;

    $git->add('file.name');

    $git->commit('-m' => 'It works');

    $git->fetch;

    $git->push('--all');

    $git->close;

=head1 DESCRIPTION

This module is a Perl binding to libgit2. It attempts to do things
