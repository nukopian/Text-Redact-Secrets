# Planned work

## CI installs only what each job needs, and caches it

**From:** Ekorn-Pipeline's session, 2026-11-16 (Ekorn-Pipeline
ace1c4266093b47fba654ce6708e1cfabf0ac1c0, its roadmap 2026-0047)
**Waiting on:** nothing

**What Ekorn found and did.** Its CI, like yours, ran `cpanm --notest
--installdeps --with-develop .` in every job, from scratch, though the
test jobs used only yath of the develop modules; installing was most
of every job, and about 90% of the macOS job's six to eight minutes.
Now each job but Windows' installs through the pinned
actions-setup-perl itself, which installs into `local/` and caches it:

```yaml
      - uses: shogo82148/actions-setup-perl@eebc5c886de14ebbfcd2493d49a12007d2c30477 # v1.44.5
        with:
          perl-version: ${{ matrix.perl }}
          install-modules-with: cpanm
          install-modules-args: --with-recommends
          install-modules: |
            Test2::Harness
            UUID
```

in place of the `dependencies` step, with `install-modules-args`
set to what your step passes beside `--with-develop`, if anything
(Ekorn's passes `--with-recommends`). Its cache key is the Perl's
`perl -V` digest, the `cpanfile`'s hash and the modules named in
`install-modules`, but not `install-modules-args`; so the test jobs
name the develop modules they use, which also keeps their cache apart
from that of a job on the same Perl that keeps `--with-develop`, such
as `style` or `coverage`. The jobs' names don't change, so `main`'s
required checks needn't. Ekorn's workflow, `.github/workflows/test.yml`
at that commit, has the comments, and its `docs/MAINTAINING.md` says
how to delete the caches to test against the newest modules
(`gh cache delete --all`).

**What was measured,** each job as GitHub timed it, without the wait
for a runner, before and on a run using the caches:

| Job | Before | After |
|---|---|---|
| perl 5.36 to 5.44 (ubuntu-24.04) | 2m 30s to 4m 6s | 12 to 16 s |
| perl 5.44 (macos-26) | 6m 23s to 7m 52s | 13 s |
| style | 2m 43s to 3m 49s | 32 s |
| coverage | 3m 21s to 4m 12s | 1m 34s |

**What to watch for.** setup-perl's cpanm runs with
`--local-lib-contained`, which ignores the modules the runner's Perl
came with. On Windows 5.44 it built Cpanel::JSON::XS 4.82 afresh, and
Ekorn's two tests that load JSON::MaybeXS then died with no output, so
Ekorn's Windows jobs install as before, uncached; they take a minute
or two anyway. Leave yours as they are, or try them in a run of their
own. The record, `docs/changes/2026-0047-ci-installs.md`, has the rest.

**Done when:** your CI's jobs install only what they use, with caches,
and pass, with the timings before and after in your record, or you've
decided against it, and why, in the commit that removes this task.
