use ExtUtils::MakeMaker;
use strict;
use Config;
use Cwd;

my $start_dir = Cwd::cwd;
my $libgit2_repo = 'git://github.com/ingydotnet/libgit2.git';
my $libgit2_dir = 'libgit2';
my $libgit2_build = "$libgit2_dir/build";
my $libgit2_path = "$libgit2_build/libgit2.o";

if (not(-e $libgit2_dir)) {
    system("git clone $libgit2_repo $libgit2_dir") == 0
        or die "Can't git clone $libgit2_repo";
}

if (not(-f $libgit2_path)) {
    chdir $libgit2_dir
        or die "Can't chdir $libgit2_dir";
    system("git checkout static-build") == 0
        or die "Can't checkout static-build branch";

    mkdir 'build'
        or die "Can't chdir build";
    chdir 'build'
        or die "Can't chdir build";

    system("cmake ..") == 0
      or die "Can't cmake libgit2. Maybe you need to install cmake.";

    system("cmake --build .") == 0
      or die "Can't cmake libgit2. Maybe you need to install cmake.";

    chdir $start_dir
        or die "Can't chdir to $start_dir";
}

my $obj_files = join ' ', map {
    my $c = $_;
    $c =~ s/\.c$/$Config::Config{_o}/;
    $c;
} glob("*.c"), 'LibGit2.c';

WriteMakefile(
    NAME => 'Git::XS::LibGit2',
    PREREQ_PM => {},
    # CCFLAGS => '-ansi -pedantic -Wall',
    # CCFLAGS => '-ansi -Wall',
    # CCFLAGS => '-pedantic -Wall',
    # CCFLAGS => '-Wall',
    LIBS => ['-lgit2'], # e.g., '-lm'
    INC => "-I.",
    OBJECT => $obj_files,
    ABSTRACT_FROM => 'lib/Git/XS/LibGit2.pm',
    AUTHOR => 'Ingy döt Net <ingy@cpan.org>',
);
