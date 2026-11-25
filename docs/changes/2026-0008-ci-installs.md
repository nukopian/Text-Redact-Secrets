# 2026-0008. CI installs only what each job needs, and caches it

**Status:** in progress

**Decisions:** D1 settled: Windows installs as before, uncached. D2
settled: the test jobs name only Test2::Harness and UUID of the
develop modules. None open.

**Origin:** a TODO task from Ekorn-Pipeline's session, 2026-11-16
(Ekorn-Pipeline ace1c4266093b47fba654ce6708e1cfabf0ac1c0, its roadmap
2026-0047)

**Started:** 2026-11-25, in 4800583cd9c41c99a4dc1d03ac0377d56e37fd7f

## Background

Every job of `test.yml` but `secrets` ran `cpanm --notest --installdeps`
from scratch, and all but Windows' with `--with-develop`, though the
test jobs use only yath of the develop modules. Installing was most of
each job. In the last three runs before the change (43909978119,
43757104644 and 43756769472), as GitHub timed each job and its
`dependencies` step:

| Job | Job | Installing |
|---|---|---|
| perl 5.36 to 5.44 (ubuntu-24.04) | 62 to 86 s | 53 to 79 s |
| perl 5.44 (macos-26) | 103 to 138 s | 92 to 123 s |
| perl 5.36, 5.44 (windows-2025) | 16 to 42 s | 3 to 15 s |
| style | 62 to 70 s | 49 to 54 s |
| coverage | 74 to 79 s | 65 to 69 s |

Ekorn-Pipeline made its jobs install through the pinned
actions-setup-perl itself, which installs into `local/` and caches it,
and its jobs went from minutes to seconds. On Windows 5.44, setup-perl's
`--local-lib-contained` built a Cpanel::JSON::XS that made Ekorn's
JSON::MaybeXS tests die, so its Windows jobs install as before.

setup-perl v1.44.5 keys its cache on the Perl's `perl -V` digest, the
installer, a hash of `install-modules-args` with the `cpanfile`, and
the modules named in `install-modules`
([src/cpan-installer.ts](https://github.com/shogo82148/actions-setup-perl/blob/eebc5c886de14ebbfcd2493d49a12007d2c30477/src/cpan-installer.ts));
Ekorn's task said the arguments weren't in it, but at this version they
are. A miss falls back to a cache for the same Perl and `cpanfile`, then
to any for the same Perl, and cpanm installs only what that lacks.

## Decisions

- [x] **D1.** Should the Windows jobs be cached too? No, on
  2026-11-25: they install only Test2::V0 and Test2::Plugin::NoWarnings,
  in 3 to 15 s, so there's little to save, and as they are they test
  against the runner's Perl and what it came with, as an installer
  would, avoiding what Ekorn found with `--local-lib-contained`.
- [x] **D2.** What should the test jobs install? The `cpanfile`'s
  runtime and test modules, and of the develop modules only
  Test2::Harness, for yath, and UUID, which the `cpanfile` lists beside
  it, named in `install-modules`, as Ekorn's do, on 2026-11-25. Naming
  them also keeps their cache apart from that of `coverage`, on the
  same Perl, which keeps `--with-develop`.

## The plan

**What:** in `test.yml`, the `perl`, `style` and `coverage` jobs
install through actions-setup-perl with `install-modules-with: cpanm`,
in place of the `dependencies` step: the `perl` jobs with
`install-modules` naming Test2::Harness and UUID, `style` and
`coverage` with `install-modules-args: --with-develop`. The Windows
jobs are unchanged (D1). The jobs' names don't change, so `main`'s
required checks needn't. MAINTAINING.md's When something goes wrong
says how to delete the caches to test against the newest modules.

**Why:** installing is most of every job, and the same modules are
installed afresh on every push.

**Steps:**

1. Change `test.yml`, with a comment saying how the caches work.
2. Add the note on deleting the caches to MAINTAINING.md.
3. Push, so a run fills the caches, then start a second run, which
   uses them, and time each job, as GitHub did above.

**Done when:** every job passes on both runs, and the second's
timings are here, beside those above.

## What happened
