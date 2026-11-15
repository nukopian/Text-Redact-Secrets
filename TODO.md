# Planned work

Setting up the repository, and starting roadmap 2026-0001, moved here
from Ekorn-Pipeline. The tasks are in the order they're best done.

## How a version shows a change to the interface

**From:** Ekorn-Pipeline's session, 2026-11-15 (Ekorn-Pipeline
e4b9e8aa6b52627625906df1a5dac051aacfe2af)
**Waiting on:** nothing; settle before the first release

New rules move the middle number, and a fix the last (D9). A change to
what `redact` or `find` take or return would break Ekorn-Pipeline's
`dump_to`, which calls `redact`. Ask Iain how a version says so, as
Ekorn-Pipeline's v0.x rule does for DBIx-Squirrel, and whether
Ekorn-Pipeline should require a range. Done when CLAUDE.md and
MAINTAINING.md's "Making a release" say it.

## Start roadmap 2026-0001

**From:** Ekorn-Pipeline's session, 2026-11-15 (Ekorn-Pipeline
e4b9e8aa6b52627625906df1a5dac051aacfe2af)
**Waiting on:** the tasks above

Every decision in its record is settled. Move it to Now, and write The
plan in its record, as CLAUDE.md's Change records say: What, Why,
Steps, Done when, from the roadmap's entry. Its first steps include
`lib/Text/Redact/Secrets.pm`, `README.pod`, and a first `minil build`
to make `Build.PL`, `META.json` and `README.md`; and setting the
coverage floors in `scripts/coverage` once there's code to measure,
as they're copied from Ekorn-Pipeline's. Its steps include the
weekly CI job that fails when the module's gitleaks tag isn't
gitleaks' latest, as Iain chose for D9 on 2026-11-15. Until there's a
module and tests, CI's perl, style and coverage jobs fail. The first
test with a made-up AWS key, built from pieces as CLAUDE.md's Tests
say, shows the rule works by passing CI's `secrets` job.
`scripts/update-rules` reads the rules with TOML::Parser and fetches
them with HTTP::Tiny, as Iain chose on 2026-11-15, passing
`verify_SSL => 1`, as 5.36's HTTP::Tiny doesn't verify certificates
by default. Done when the item is in Now and its record has its plan.

## Make and protect `main`, at the first release

**From:** Text-Redact-Secrets' session, 2026-11-15 (Text-Redact-Secrets
354f3f0d6e34ea596e44ead64425b7212c75ab90)
**Waiting on:** the first release; CI passing on every job

Left over from setting up GitHub, whose other settings are made:
secret scanning, push protection, Dependabot alerts (its security
updates off) and private vulnerability reporting are on, and Actions
is enabled. `main` isn't made yet, as every commit on `develop`
carries `TODO.md`, which never reaches `main`; Iain decided on
2026-11-15 that it waits for the first release, and `develop` stays
the default branch until then. At the first release, once `TODO.md`
is gone:

- `main` made by pushing `develop` to it, and made the default branch,
  as in Ekorn-Pipeline.
- `main` protected, as MAINTAINING.md's "Branches" says, with the
  required checks of "Changing the CI matrix", once each has passed
  once on `develop`.

As `TODO.md` must be gone first, this task is removed, with the file,
in the commit just before `main` is made.

Done when `gh api repos/nukopian/Text-Redact-Secrets/branches/main/protection`
shows the settings, and `gh repo view --json defaultBranchRef` names
`main`.
