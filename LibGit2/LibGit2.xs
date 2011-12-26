#include <perl_libgit2.h>

MODULE = Git::XS::LibGit2		PACKAGE = Git::XS::LibGit2		

PROTOTYPES: DISABLE

void
Object ()
        PPCODE:
        PL_markstack_ptr++;
        Object();
        return;

