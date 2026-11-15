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
