use Test::More tests => 3;

use Git::XS;
use File::Path;

my $repo = "t/test_repo";

File::Path::rmtree($repo);

mkdir $repo or die;

my $g = Git::XS->new;

ok $g->open($repo), 'open() succeeded';

ok $g->init(), 'init() succeeded';

ok -f("$repo/.git/config"), 'init() actually worked';
