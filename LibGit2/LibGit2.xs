#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include "git2.h"
#include <helpers.c>

typedef struct {
    git_repository *repo;
} git_t;

MODULE = Git::XS		PACKAGE = Git::XS
PROTOTYPES: DISABLE
VERSIONCHECK: DISABLE

void
_build(self)
    SV *self
    PREINIT:
        git_t *git;
    CODE:
        Newx(git, sizeof(git_t), git_t);
        xs_object_magic_attach_struct(aTHX_ SvRV(self), git);
        SV *repo = call_getter(self, "repo");
        if (call_test(self, "repo_exists", repo))
            git_repository_open(&(git->repo), SvPV_nolen(repo));

SV *
init(self)
    SV *self
    PREINIT:
        int rc;
        git_t *git = xs_object_magic_get_struct_rv(aTHX_ self);
    CODE:
        RETVAL = self;
        SV *repo = call_getter(self, "repo");
        char *path = SvPV_nolen(repo);
        git_repository **pptr = &(git->repo);
        rc = git_repository_init(pptr, path, 0);
        if (rc != GIT_SUCCESS)
            croak("git init failed with code: %d", rc);
    OUTPUT:
        RETVAL
