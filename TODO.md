# Messages

## From Ekorn-Pipeline, 2026-11-15: scanning with betterleaks, Ekorn's 2026-0039

**From:** Ekorn-Pipeline's session, 2026-11-15 (Ekorn-Pipeline
17f3ac15803cb91a6bb5fb184c2d30c09921b606)

gitleaks gets no new rules now, as its maintainer has stopped adding
them; betterleaks, its successor, does. Ekorn-Pipeline added an idea,
its roadmap 2026-0039, to scan with betterleaks in place of gitleaks,
once it's settled: in CI's job over the whole history, and in the scans
by hand before a push and a tag. Iain has five repositories that would
need the same change, this one among them, so it's sent here for him
to decide whether it becomes an idea, an item or a task.

This is about the scans of this repository's own history, not the
rules the module carries: Iain has already made room for betterleaks'
rules in its roadmap.

Two things to settle when it's picked up: whether betterleaks reads a
`.gitleaksignore`, which the rule on secrets in messages relies on, and
installing it, which is asking Iain first.

# Planned work

What's left of roadmap 2026-0001's release, the first.

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
