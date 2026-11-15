# Planned work

Setting up the repository, and starting roadmap 2026-0001, moved here
from Ekorn-Pipeline. The tasks are in the order they're best done.

## Confirm CLAUDE.md stands alone

**From:** Ekorn-Pipeline's session, 2026-11-15 (Ekorn-Pipeline
e4b9e8aa6b52627625906df1a5dac051aacfe2af)
**Waiting on:** nothing

CLAUDE.md was written from Ekorn-Pipeline's, which stands alone, by
Iain's choice, importing no shared practice. Iain's global rule is that
a project imports `@../claude-practice/PRACTICE.md`, the repository
being public. Ask Iain which this one does: stand alone, as written, or
import the practice, and trim CLAUDE.md of what it then repeats. Done
when CLAUDE.md's opening says which, and why.

## Make the perlbrew libraries

**From:** Ekorn-Pipeline's session, 2026-11-15 (Ekorn-Pipeline
e4b9e8aa6b52627625906df1a5dac051aacfe2af)
**Waiting on:** nothing

CLAUDE.md's Perl section names a library for each Perl CI covers,
`perl-5.36.3@text-redact-secrets` to `perl-5.44.0@text-redact-secrets`;
none exists yet. Making them installs modules, so ask Iain first.
Each takes the `cpanfile`'s runtime, test and develop modules, and the
5.36 one Minilla too, as MAINTAINING.md's "A fresh clone" says, and as
Ekorn-Pipeline's were made on 2026-11-07. Then write `.envrc`, as that
section says. Done when `perlbrew lib list` shows all five, and
`perlbrew exec --with perl-5.36.3@text-redact-secrets minil help` runs.

## Set up GitHub

**From:** Ekorn-Pipeline's session, 2026-11-15 (Ekorn-Pipeline
e4b9e8aa6b52627625906df1a5dac051aacfe2af)
**Waiting on:** nothing

These are GitHub settings, so Iain's to make, or to say Claude may:

- `develop` pushed first, and `main` made from it, `main` the default
  branch, as in Ekorn-Pipeline.
- `main` protected, as MAINTAINING.md's "Branches" says, with the
  required checks of "Changing the CI matrix", once each has passed
  once on `develop`.
- Secret scanning, push protection, Dependabot alerts (not its
  security updates) and private vulnerability reporting, as its
  "Security checks" says.
- Actions enabled, checked in the Actions tab, as Ekorn-Pipeline's
  needed.
- How a new gitleaks tag is noticed (D9 in roadmap 2026-0001's record):
  by watching gitleaks' releases on GitHub, or by a weekly CI job that
  fails when the module's tag isn't gitleaks' latest.

Done when `gh api repos/nukopian/Text-Redact-Secrets/branches/main/protection`
and MAINTAINING.md's security commands show the settings.

## Tell gitleaks the tests' secrets are made up

**From:** Ekorn-Pipeline's session, 2026-11-15 (Ekorn-Pipeline
e4b9e8aa6b52627625906df1a5dac051aacfe2af)
**Waiting on:** nothing; settle before the first test with a secret is
committed

The tests hold secrets on purpose: made up, but shaped to match
gitleaks' rules, which is the point. CI's `secrets` job runs gitleaks
over the whole history, and GitHub's push protection checks each push,
and both would find them, failing CI or refusing the push. Once
committed, a secret is in the history for good, so this is settled
first. Ways to weigh with Iain: a `.gitleaks.toml` that extends the
default rules and allows `t/` (simple, but then a real secret pasted
into a test is missed); `gitleaks:allow` on each line that holds one;
or secrets built at run time from pieces, so no line holds one whole
(also keeps push protection quiet). Done when the choice is in
CLAUDE.md's Tests section, and a test with a made-up AWS key passes
CI's `secrets` job.

## The script's dependencies

**From:** Ekorn-Pipeline's session, 2026-11-15 (Ekorn-Pipeline
e4b9e8aa6b52627625906df1a5dac051aacfe2af)
**Waiting on:** nothing

`scripts/update-rules` reads `config/gitleaks.toml`: TOML 1.0, with
literal strings in `'''` and arrays of tables (`[[rules]]`,
`[[rules.allowlists]]`), so it needs a TOML parser, such as
TOML::Tiny; and it fetches over HTTPS, with HTTP::Tiny, core, which
needs IO::Socket::SSL and Net::SSLeay, or with `curl`. Adding a
dependency is Iain's decision; these are for the script only, so
they'd go under `on develop` in `cpanfile`, and users never install
them. Done when `cpanfile` lists what Iain chose.

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
as they're copied from Ekorn-Pipeline's. Until there's a module and
tests, CI's perl, style and coverage jobs fail. Done when the item is
in Now and its record has its plan.
