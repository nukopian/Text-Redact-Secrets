# Working on Text-Redact-Secrets

These are the working rules for this repository. Text-Redact-Secrets
is Iain Campbell's: a Perl module that finds secrets in text by
gitleaks' rules, and redacts them. Iain and Claude write it together,
and Claude reviews what he writes by hand. The rules below say who does
what. Each rule comes with the reason for it.

These rules were set up on 2026-11-15, from Ekorn-Pipeline's, where the
module was designed. The project stands alone, as Iain decided on
2026-11-15, as Ekorn-Pipeline does: this file is the whole of its
rules, and it imports no shared practice; CONTRIBUTING.md, SECURITY.md
and LICENSE stand alone too, leaning on no other project. How the
repository is kept, from every commit to a release
on CPAN, is in [docs/MAINTAINING.md](docs/MAINTAINING.md), with
commands to paste.

## What Text-Redact-Secrets is for

Text that might hold a secret, such as a dump written to a log, should
be safe to write. Text::Redact::Secrets puts `*REDACTED*` in place of
each secret it finds in a string, with `redact`, or reports each, with
`find`, by gitleaks' rules: a maintained set of regexes, keywords,
entropies and allowlists, carried over from gitleaks by a script, so
that this module is as good at finding secrets as gitleaks is. Beside
them are rules of its own, written by hand in
`lib/Text/Redact/Secrets/Rules/Dist.pm`, for secrets gitleaks has no
rule for, such as a password in a URL. Each source of rules has a
module of its own under `Rules/`: `Gitleaks.pm`, generated, and
`Dist.pm`, the distribution's own.

The test of any change: does it keep gitleaks' rules as gitleaks has
them, and keep the module safe to call on any text? gitleaks adds no
more rules: its maintainer said so in 2026, closing its issue 2089. So
a secret it has no rule for gets a rule of the module's own, as Iain
decided on 2026-11-15 (2026-0001's D12): written as gitleaks writes
its rules, run as they are, after them, with an id that isn't one of
gitleaks', tested by hand, and named in `Rules/Dist.pm`'s POD.
gitleaks' own rules are never changed here.

## Text-Redact-Secrets and Ekorn-Pipeline

The module was designed in Ekorn-Pipeline's session, as its roadmap
item 2026-0037, and moved here on 2026-11-15, as this repository's
2026-0001, when it had a repository of its own. Its record,
[docs/changes/2026-0001-gitleaks-rules.md](docs/changes/2026-0001-gitleaks-rules.md),
has every decision, settled there.

- **Ekorn-Pipeline uses it as any package would.** Its `dump_to`
  redacts what it writes whenever Text::Redact::Secrets is installed
  and passes a self-test (Ekorn-Pipeline 2026-0038), calling `redact`.
  Ekorn doesn't require it, so it's this module's users who choose to
  have it.
- **Its contract with Ekorn is `redact` and `find`,** what they take and
  return. A change to either would break Ekorn's `dump_to`, so it's
  sent to Ekorn-Pipeline as a message before it's made.
- **The version says what Ekorn can take,** as Iain decided on
  2026-11-15. Releases start at v1.0.0. A change to what `redact` or
  `find` take or return moves the first number, to v2.0.0; new rules,
  or anything added that breaks nothing, move the middle (D9); a fix
  moves the last. Ekorn takes `>= v1.0.0, < v2.0.0`, treating a version
  outside it as it would a failed self-test, so a v2.0.0 comes with a
  task for Ekorn-Pipeline, which tests it and moves the range. Ekorn's
  v0.x rule, where the middle number is the breaking one, doesn't fit
  here, as D9 gives the middle number to new rules.
- **New rules reach Ekorn's users with no release of Ekorn's,** which is
  why the module has a repository of its own (D1). So a release that
  only brings new rules from gitleaks needs no message.

## Who does what

- **The code is a two-way process.** Iain writes some by hand, and
  Claude reviews it, suggests, and explains. Where Iain asks, Claude
  writes code too, and Iain reviews that. Claude doesn't change code it
  wasn't asked to.
- **Claude helps with the Git Ops and the repository's setup:**
  branches, CI, releases, and the files around the code. Ask before
  changing anything on GitHub.
- **Tests and documentation,** where Iain asks: keeping the POD, the
  README and `Changes` up to date with the code.
- **The PDFs are made when Iain asks, not after every docs change,** as
  in Ekorn-Pipeline. Check a docs change as text: run its examples and
  read the diff. When he asks, build them with `scripts/readme-pdf.sh`,
  as MAINTAINING.md says, and read the pages he names, as text with
  `pdftotext` unless layout matters.
- **Commit messages:** Claude drafts them when asked, for Iain's commits
  as well as its own.

Why: Ekorn-Pipeline, and through it DBIx-Squirrel, will rely on it to
keep secrets out of logs, so it matters most that it's right.

## Credit

- **Every commit Claude makes carries a `Co-Authored-By` trailer** for
  the Claude model that made it, currently
  `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`: code, CI,
  setup files, tests or docs written at Iain's request, and a commit
  holding Iain's own change with Claude's work to finish it. It's left
  off only when Iain says so before the commit. Commits Iain makes
  himself are his to sign off.
- **gitleaks is credited as its MIT licence asks** (D6): its licence and
  copyright notice ship as `LICENSE-gitleaks`, which
  `scripts/update-rules` fetches from the same tag as the rules; the
  generated module of rules says in its header where its rules came
  from; the POD names gitleaks, the tag and the commit; and `LICENSE`
  says the rules are under MIT, and the rest under Perl's terms. The
  first `LICENSE-gitleaks` came from gitleaks' v8.30.1
  (83d9cd684c87d95d656c1458ef04895a7f1cbd8e), by hand, before the
  script was written.
- The README's Acknowledgements say what Claude did, and what gitleaks
  did. Keep them accurate.
- **On CPAN, Iain is `Iain Campbell <cpanic@cpan.org>`,** and no other
  address goes in the distribution: the main module's AUTHOR and so
  `META.json`. Commits use his GitHub noreply address, which GitHub
  needs to verify their signatures, so `.mailmap` maps it to the CPAN
  one. Minilla reads authors through it, and would otherwise list Iain
  as a contributor to his own distribution.

Why: credit goes where the work was done, so a reader can see exactly
what was Iain's, and what was gitleaks'.

## Perl

- **Perl 5.36 or later.** Modules start `use v5.36`, which gives strict,
  warnings, `say` and signatures. `try`/`catch` is still experimental
  in 5.36: a module that needs it adds `use experimental qw(try);`,
  which also allows `finally`, but only after a `catch`: `try {...}
  finally {...}` is a syntax error on every Perl from 5.36 to 5.44.
  `builtin::` functions are used in place of Scalar::Util: a module
  adds `use experimental qw(builtin);` and imports what it needs. Only
  functions stable in 5.40 are used, so that once the floor reaches
  5.40, `use v5.40` imports them. CI tests from the floor to the newest
  Perl.
- **Minilla** builds and releases the distribution, as in
  Ekorn-Pipeline: the repository is the distribution, with the
  `Build.PL` and `META.json` it generates committed and a `cpanfile`
  listing the dependencies. Three settings in `minil.toml` part from
  its defaults:
  - **The README is written by hand in `README.pod`.** Minilla always
    writes `README.md` from POD, so it's generated from that file, not
    from the main module. Edit `README.pod`, never `README.md`.
  - **`Changes` keeps its "Unreleased" heading** (`manage_changes =
    false`), edited by hand at a release, rather than `{{$NEXT}}`.
  - **The git steps of a release are ours.** `minil release` makes its
    own commit and an unsigned tag, and pushes both, so releases don't
    use it: `minil prepare VERSION` sets the version, we commit, move
    `main` and sign the tag, `minil dist --skip-prepare` builds the
    tarball, and `cpan-upload` uploads it.
- **The module of gitleaks' rules, `Rules/Gitleaks.pm`, is generated,
  never edited by hand.** `scripts/update-rules` writes it from a
  gitleaks release tag, as D9 says, with the tag and commit in it; a
  change to how a rule is carried over is a change to the script, and
  the module is made again. The script and what it fetches stay out of
  the tarball.
- **Regexes from gitleaks are translated as D3 says:** compiled with
  `/a`, each anchor `$` written `\z`, and any that won't compile, or set
  the `m` flag, stop the script; and, as D13 says, the doubled repeat
  gitleaks' generator begins some with merged into one, which matches
  the same text and runs far faster in Perl. The rules are kept as
  gitleaks has them otherwise, never improved here.
- **No runtime dependency beyond core Perl** without Iain's say: the
  module is meant to be cheap for Ekorn's users to install. The entropy
  check is written here (D5). The dependencies are in `cpanfile`;
  adding one, at runtime or for the script, is a decision for Iain.
- Locally, Iain uses perlbrew, with a library of the project's own,
  `perl-5.36.3@text-redact-secrets`, so its modules don't mix with
  other projects'. Run commands with the library named, and never
  `perlbrew switch` or `use`, which would change his shell:

  ```
  perlbrew exec --with perl-5.36.3@text-redact-secrets yath test
  ```

  Each Perl CI covers needs a library of the same name:
  `perl-5.38.5@text-redact-secrets`, `perl-5.40.5@text-redact-secrets`,
  `perl-5.42.3@text-redact-secrets` and
  `perl-5.44.0@text-redact-secrets`, all made on 2026-11-15.

## Tests

- **Test2::V0, not Test::More,** in every test, with `is`, `like` and
  Test2's checks for structures. Compare values, never Data::Dumper
  output.
- **Test2::Plugin::NoWarnings** in each test file, so a warning fails
  the test that caused it.
- **yath, not prove,** runs them, with `-L` keeping a log of the run,
  linked from `./lastlog.jsonl` (git-ignored):

  ```
  perlbrew exec --with perl-5.36.3@text-redact-secrets yath test -L
  perlbrew exec --with perl-5.36.3@text-redact-secrets yath failed lastlog.jsonl
  ```

- **What the tests are is settled in D3:** tests written by hand for
  the rules that matter most in a dump (`generic-api-key`, passwords in
  URLs and DSNs, AWS's, GitHub's and private keys), and gitleaks' false
  positives, read from its Go sources at the same tag, in a test the
  script writes. `find` shows which rule found what, so a test checks
  that, not only that something was hidden.
- **Every secret in a test is made up,** and looks made up to a reader.
  The repository runs gitleaks on every push, and GitHub's push
  protection, both of which will find a test's secrets as they would a
  real one's. So **no line holds a whole secret:** each is built at run
  time from pieces, none of which matches a rule alone, as
  `join '', 'AKIA', 'QZJTMADEUPKEYQZJ'`. Nothing is allowlisted,
  neither `t/` nor a line with `gitleaks:allow`, so a real secret
  pasted into a test is still found. Iain decided this on 2026-11-15.
  The one exception is `.gitleaksignore`, which passes over a single
  finding in history that isn't a secret, by its fingerprint, each a
  decision of Iain's with its reason (2026-0001's D14). Claude changes
  `.gitleaksignore`, and a `.betterleaks.toml` once there is one, only
  with its Edit tool, never from the shell: a rule in Iain's settings
  makes each such edit ask him, as he set up on 2026-11-25, where auto
  mode refuses a change to a scanner's allowlist made from the shell.
- **Coverage has floors, which it mustn't fall below.**
  `scripts/coverage` runs the tests under Devel::Cover, from an empty
  `cover_db`, and fails if the coverage of `lib/` falls below the floors
  at its top; CI runs it on every push. New code comes with the tests
  that keep coverage above them. Raise a floor when coverage rises, and
  lower one only with the reason in the commit message.
- Users installing from CPAN run the tests with whatever harness their
  installer uses, so they must pass under `prove` too.
- **`xt/`, when there is one, holds the maintainers' tests,** which
  yath runs with those in `t/`, as `.yath.rc` says, and `prove` doesn't.

## Style and tools

- **Perl::Tidy** formats the code, with `.perltidyrc`, the same as
  Ekorn-Pipeline's, on the newest Perl, as CI's style check runs:

  ```
  perlbrew exec --quiet --with perl-5.44.0@text-redact-secrets perltidy lib/Text/Redact/Secrets.pm | diff lib/Text/Redact/Secrets.pm -
  ```

- **Perl::Critic** reviews it, with `.perlcriticrc`, on the newest Perl:

  ```
  perlbrew exec --with perl-5.44.0@text-redact-secrets perlcritic lib
  ```

- **Data::Dump**'s `pp` is for looking at data while debugging, not for
  the shipped modules or for test expectations.
- **Errors are raised with `croak`,** from the caller's line, each
  message one plain string, matching its DIAGNOSTICS entry.
- **Exports:** `@EXPORT_OK` (D10). Nothing is exported unasked.
- **Two blank lines between subs, or one above a sub's comment.**
- **Every regex written here takes the `x` flag** and is written with
  its operator and parentheses: `m( \A \d+ \z )x`, `qr( ... )x`; never
  `/.../`. Under `x`, a literal space is `\ ` and a literal `#` is `\#`.
  gitleaks' regexes are the exception: they're compiled as gitleaks
  wrote them, translated only as D3 says.

## Planned work

- **At the start of a session, check for `TODO.md`** at the top of the
  repository, on `develop`. If it's there, read it, ask Iain whether
  each task should still be done, and do the ones he confirms. Remove
  each task in the commit that completes it, and delete the file with
  the last one. A task he drops is removed too, saying why in the
  commit message.
- **Work planned for a later session goes into `TODO.md`,** committed on
  `develop`, with enough to do it cold: what, why, the files involved,
  and how to check it's done.
- **Before each commit, `git pull --ff-only` and re-read `TODO.md`.**
  Ekorn-Pipeline's session may add tasks or messages here.
- **Each task opens with where it came from and what it waits on,** as
  in Ekorn-Pipeline: a **From:** line naming the repository whose
  session added it, the date, and the commit, by its full hash; and a
  **Waiting on:** line, "nothing" when it can be done now.
- **Messages go in a `# Messages` section, above `# Planned work`,** in
  the same `TODO.md`: news the other session should know, needing no
  work of its own. Each is a `##` heading saying who it's from, the
  date and what it's about, with a **From:** line. The session it's for
  removes each once read, in a commit saying what came of it.
  A message never holds a secret whole, made-up or not: it's built
  from pieces, as a test's is, or left out, as history can't be
  taken back (D14).
- **Tasks and messages for Ekorn-Pipeline go in its `TODO.md`,** on its
  `develop`, sent as `docs: a task from Text-Redact-Secrets: ...` or
  `docs: a message from Text-Redact-Secrets: ...`, committing only that
  file, and pushed at once. Never switch Ekorn-Pipeline's working copy,
  or commit in it, as a session may be working there: use a worktree of
  its `develop` as GitHub has it, edit `/tmp/ekorn-pipeline-todo/TODO.md`,
  commit only it, and push from there:

  ```
  git -C ~/Git/github.com/nukopian/Ekorn-Pipeline fetch -q origin
  git -C ~/Git/github.com/nukopian/Ekorn-Pipeline worktree add --detach /tmp/ekorn-pipeline-todo origin/develop
  git -C /tmp/ekorn-pipeline-todo push origin HEAD:develop
  git -C ~/Git/github.com/nukopian/Ekorn-Pipeline worktree remove /tmp/ekorn-pipeline-todo
  ```

  A push refused as not a fast-forward means the branch moved: remove
  the worktree and start again from the fetch. Ekorn-Pipeline is the
  only other repository this one touches.
- **A release ends by telling Ekorn-Pipeline,** with a message in its
  `TODO.md` saying which version is on CPAN, unless it brings only new
  rules from gitleaks; the first release is a task, as Ekorn-Pipeline
  2026-0038 waits on it.
- **`TODO.md`'s tasks and messages are the only way the two sessions
  talk.** A feature is designed in the session of the repository it
  belongs to; the other sends what it finds as messages, and Iain
  decides what comes of them.
- **`TODO.md` never reaches `main`.** `main` moves only by a
  fast-forward to `develop`, so a release waits until the file is gone.
  No GitHub issues or Claude Docs for planned work or decisions: they
  sit outside the repository, apart from the history and the chat.

Why: planned work survives between sessions in the open, where Iain
reviews it like any other change, and a release never carries an
unfinished list.

## The roadmap

- **`ROADMAP.md` holds what Text-Redact-Secrets means to do,** kept as
  Ekorn-Pipeline's is: its opening says how. **Now** is at most three
  items; **Next** is decided but not started (what, why, done when);
  **Later** is meant but not planned; **Ideas** might be done, or
  never.
- **Every item has an id, its year and a serial: `2026-0001`,** from
  0001 each year, given when the item is added, never changed or used
  again. The roadmap's opening gives the last id allocated. Another
  repository's id goes with its name, as "Ekorn-Pipeline 2026-0038".
- **The id names the item everywhere:** its heading, its record in
  `docs/changes/`, its line in `Changes`, commit messages and a branch.
- **Every item has a size,** XS 1, S 2, M 3 or L 5, in a **Size:** line;
  an item bigger than L is split. **Depends on:** names what it waits
  for.
- **An item's questions are settled before work on it starts,** in its
  record's Decisions, numbered, with a **Decisions:** line summing them
  up.
- **When Iain mentions an idea in passing,** offer in one line to add
  it, and add it in a `docs:` commit.
- **It's kept current,** and it's public, on GitHub and `main`, but not
  in the CPAN tarball, so nothing personal goes in it.

## Change records

- **A planned change keeps a record** in `docs/changes/`, named for its
  id and the change. `docs/changes/README.md` has the template, and
  lists the records.
- **The plan is written in it when work starts, and isn't edited
  after.** What happened is added as the work goes: the outcome against
  Done when, changes from the plan and why, measurements, and what was
  tried and reverted.
- **It's finished in the commit that ships or drops the change.**

## Commits

- Conventional commits, such as `feat: ...`, `fix: ...`, `docs: ...`,
  `test: ...` or `ci: ...`. Say why as well as what.
- Commits are signed. Work is committed and pushed to `develop`. `main`
  is the latest release, and moves only at a release, by a fast-forward
  to `develop`, with a signed tag on it.
- Add what changed for users to `Changes`, under Unreleased, in the same
  commit, opening with a precis naming the roadmap items it ships. A
  release that brings new rules names the gitleaks tag they came from.
- gitleaks scans the whole history for secrets in CI on every push, and
  by hand before a tag. A leak stops the work like a failing test: once
  history is published, it can't be taken back.
