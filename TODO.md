# Messages

## From Ekorn-Pipeline, 2026-11-15: how Iain and Claude work

**From:** Ekorn-Pipeline's session, 2026-11-15 (Ekorn-Pipeline
e4b9e8aa6b52627625906df1a5dac051aacfe2af)

This repository was set up from Ekorn-Pipeline's session, where
Text::Redact::Secrets was designed. That session's memory holds how
Iain likes to work, learnt over its sessions; this one's memory starts
empty. Save these in this project's memory, one fact to a file, as the
memory instructions say, and tell Iain which you saved. Each came from
Ekorn-Pipeline's memory, at
`~/.claude/projects/-Users-icampbell-Git-github-com-nukopian-Ekorn-Pipeline/memory/`,
which can be read for the detail, but never written to.

- **Suggest commit messages.** Whenever asking Iain to commit, write
  the message out in full, ready to paste: a conventional prefix, and
  why as well as what. Never "the same message". His own commits carry
  no Co-Authored-By trailer.
- **Short cues on workflow.** Iain is fluent in Perl, and wants to
  absorb workflow and good practice, conventional commits especially:
  add a one-line cue on why a prefix or a step (why fast-forward, why
  sign, why regenerate `META.json`). Asides, not lectures; drop one
  once it's familiar.
- **No explaining the trailer.** Apply CLAUDE.md's Co-Authored-By rule
  silently. "We're a team."
- **SSH keys:** if a push is refused or the agent seems empty, run
  `source ~/.zsh.d/init.d/030-ssh.zsh` first; it loads Iain's keys
  only if the agent has none. Never print the key names or paths, or
  open its passphrase helper. If it still fails, check
  githubstatus.com.
- **Batch pushes.** Bursts of SSH connections to GitHub trip Iain's
  UniFi IDS ("ET SCAN Potential SSH Scan OUTBOUND", 2003068): push
  several refs in one `git push origin a b`, and don't pull straight
  after a fetch.
- **Full hashes, looked up.** Before writing a full commit hash
  anywhere, run `git rev-parse` and paste what it prints; never extend
  a short hash from memory. A wrong full hash once had to be corrected
  in a second commit.
- **Decisions in the repository.** No Claude Docs or GitHub issues for
  decisions or planned work: decisions go in a record's Decisions,
  discussed in the chat; planned work in `TODO.md`.
- **Iain orchestrates the chain.** He switches between sessions
  himself, and carries hand-offs informally. Use `TODO.md`'s tasks and
  messages, but propose no more formal hand-off rules; when work for
  the other session is done, say so in the reply, so he can carry it
  on.
- **Message declined changes.** When Iain considers a change to
  something Ekorn-Pipeline uses (`redact`, `find`) and keeps it as it
  is, send Ekorn-Pipeline a message anyway, with what was considered
  and why it was kept.
- **Epic changes design-first.** For a change across several items or
  repositories: one design, proved by a prototype on a sandbox branch,
  reviewed cold by fresh agents, its findings settled as numbered
  decisions, and only then split into items.
- **Perl, as Iain writes it:** no `goto &sub` tail calls, which he
  says aren't cheap; call with `$code->(@args)`, or `&$code;` outside
  a signature.
- **Installing modules.** In Ekorn-Pipeline, a module already in
  `perl-5.36.3@dbix-squirrel-2` may go into its libraries without
  asking; anything else needs asking, naming it and why. Ask Iain
  whether the same holds for this project's libraries before relying
  on it.
- **The sibling session.** Ekorn-Pipeline's session runs alongside this
  one, with its own memory: read it if it helps, never write to it.
  The two talk only through each other's `TODO.md`, as CLAUDE.md's
  Planned work says, through a detached worktree, never by switching or
  committing in the other's working copy. If Iain corrects a habit
  here that the other session follows too, say its memory may need the
  same change, and let him take it there.

Remove this message once the memories are saved, in a commit saying
which.

# Planned work

Setting up the repository, and starting roadmap 2026-0001, moved here
from Ekorn-Pipeline. The tasks are in the order they're best done.

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
