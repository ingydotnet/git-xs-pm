use Test::More tests => 2;

use Git::XS;
use File::Path;

my $repo = "t/test_repo";

File::Path::rmtree($repo);

mkdir $repo or die;

my $g = Git::XS->new(repo => $repo);

ok $g, 'new() succeeded';

ok $g->init(), 'init() succeeded';

my $exists = -f "$repo/.git/config";

# ok $exists, 'init() actually worked';
