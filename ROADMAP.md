# Roadmap

What Text-Redact-Secrets means to do, and why. [Changes](Changes)
says what each release did, and the [README](README.md) what it is
now.

Last id: 2026-0007.

Items come in four groups:

- **Now:** being worked on, each with a paragraph and a link to its
  [change record](docs/changes/README.md); never more than three, so
  that it stays a queue;
- **Next:** decided, but not started: what, why, and when it's done;
- **Later:** meant to be done, but not yet planned, in a line or two;
- **Ideas:** might be done, or never; kept so they aren't lost, in a
  line or two, newest last.

Now, Next and Later put the most useful first.

Each item has an id, its year and a serial, such as 2026-0001. The year
is when the item was added, and the serial counts from 0001, starting
again each year. An id is given when the item is added, whichever group
it goes in, and is kept as the item moves, so that 2026-0001 means the
same item in a commit message years later. It names the item's change
record, its line in Changes ("(roadmap 2026-0001)") and any branch for
it. The line above gives the last id allocated.

Each item has a size too, a guess at how much work it is, as a T-shirt
size and its story points: XS 1, S 2, M 3 and L 5. Sizes compare items
with each other; they aren't a measure of time. An item bigger than L
is split into items that aren't, each saying what it was split from.
An item that can't be done before another says so ("Depends on:"), and
is never in a group ahead of it.

An item whose questions aren't all settled says so, and its record
lists them. Work on it starts only once each is settled, or moved to
another item or task.

When an item ships, it leaves here for Changes. An item that's
dropped is deleted, and the commit that drops it names its id.

## Now

### 2026-0001. A module of gitleaks' rules

**Size:** L (5). **Moved from:** Ekorn-Pipeline 2026-0037.

Text::Redact::Secrets, released to CPAN, with `redact` and `find`, by
gitleaks' rules, which `scripts/update-rules` makes into a module from
a gitleaks release tag. Started on 2026-11-15; [its
record](docs/changes/2026-0001-gitleaks-rules.md) has the plan.

## Next

### 2026-0004. New rules made ready by CI, for a release

**Size:** M (3). **Depends on:** 2026-0001.

When `gitleaks-tag.yml` finds a newer gitleaks release, it runs
`scripts/update-rules` itself, pushes what it writes to a branch named
for the tag, where the tests and gitleaks run on it, and opens a pull
request showing the rules added, changed and removed. New rules then
wait on the maintainer only to read a tested diff, merge it, and
release, minutes rather than an evening, so that someone needing them
urgently isn't held up for long. Releasing stays a person's step, as
D1 and D9 of 2026-0001's record have it: each set of rules installed
is one a person read and released. The workflow needs permission to
push a branch and open a pull request, a change to GitHub, so Iain's
to make.

**Done when:** a run by hand, given an older tag than the module's,
makes a branch and a pull request whose diff is the rules' change and
whose checks pass, and `docs/MAINTAINING.md`'s "Updating the rules"
says how to release from it.

## Later

### 2026-0006. Every rule in time in step with the text

**Size:** M (3). **Depends on:** 2026-0001.

gitleaks runs its rules in Go's RE2, which takes time in step with
the text, whatever it is. Perl's engine backtracks, and a few of
gitleaks' rules take longer on long text made to be awkward:
`privateai-api-token` four times as long each time it doubles, even
after D13 of 2026-0001's record. Ways to weigh: running a rule only
near its keywords, where its regex must find one within so many
characters of where a match starts; or RE2 itself, by
re::engine::RE2, when it's installed, which would also run each regex
exactly as gitleaks does, but is a compiled module, not core Perl.

## Ideas

An idea is a numbered heading, the date it was added, its size, and a
line or two on what and why. Each is kept, promoted to Later or Next
with its id, or dropped, as Iain decides.

### 2026-0002. Decode what gitleaks decodes

**Added:** 2026-11-15. **Size:** M (3).

gitleaks' command line decodes base64, hex and percent-encoded text,
five levels deep by default, and scans what it decodes too, so it finds
a secret that's been encoded; Text::Redact::Secrets scans only the text
as it is (2026-0001's record, step 3). Doing as gitleaks' `codec`
package does would make the module as good at finding them.

### 2026-0003. Rules from betterleaks

**Added:** 2026-11-15. **Size:** M (3).

gitleaks adds no more rules: its maintainer said so in April 2026,
closing its issue 2089, and pointed to betterleaks as the next
gitleaks. Whether betterleaks' rules should join or replace gitleaks'
as where the module's come from, once its licence, its rules' format
and how it releases them are checked (2026-0001's D12).

### 2026-0005. Rules supplied by a user

**Added:** 2026-11-15. **Size:** M (3).

A user who can't wait for a release could give `redact` and `find`
rules of their own, such as a newer `gitleaks.toml`, so that nobody
waits on the maintainer at all. Against it: reading TOML at run time
needs a dependency beyond core Perl, and the rules used would no
longer be a set tested together, which Ekorn-Pipeline's `dump_to`
relies on. Kept in case someone asks for it.

### 2026-0007. Scan this repository with betterleaks

**Added:** 2026-11-15. **Size:** S (2).

CI's scan of the whole history, and the scans by hand before a push and
a tag, use gitleaks, which adds no more rules; betterleaks, its
successor, does. Scanning with it instead, as Ekorn-Pipeline's idea
2026-0039 has it for all of Iain's repositories, once it's settled
there. Two things to settle: whether betterleaks reads
`.gitleaksignore`, which D14 of 2026-0001's record relies on, and
installing it, which is Iain's to say. It may be settled with
2026-0003, rules from betterleaks.
