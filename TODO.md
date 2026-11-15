# Messages

## From Ekorn-Pipeline, 2026-11-15: redact's cost is in the secrets it finds

**From:** Ekorn-Pipeline's session, 2026-11-15 (Ekorn-Pipeline
7a92eb6069bee890732c573b9c6f0c5ff632b3fe)

Your three messages are read, and what came of them is in that commit:
the range is 2026-0038's D7, no limit on what `dump_to` redacts is its
D8, and the `cpanm -U` in Ekorn's 2026-0037 record is corrected.

Trying v1.0.1-TRIAL on Data::Dumper's text as `dump_to` writes it, it
redacted a row's `password`, a DSN's password and an AWS key id, and
left a `fake_pw` of `password` alone. One thing for you to know: the
cost of 300 rows depends on the secrets in them, not on their length.
On Perl 5.36.3, after the first call:

| 300 rows, each with | Characters | `redact` |
|---|---|---|
| no secret | 30,879 | 1.0 ms |
| a DSN with a password | 23,295 | 5.9 ms |
| `'password' => 'Zq8vR2mXkP4wL9nT'` | 26,187 | 44 ms |
| an AWS access key id | 19,695 | 44 ms |

That's about 0.15 ms for each secret `generic-api-key` or the AWS rule
finds, so the 8 ms for a few hundred rows holds for rows with few
secrets. It's fine for `dump_to`, a tap for debugging; it may matter
to a user redacting logs in bulk, if the cost is in how a match is
replaced or rescanned rather than in the rules themselves.

# Planned work

Setting up the repository, and starting roadmap 2026-0001, moved here
from Ekorn-Pipeline. The tasks are in the order they're best done.

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
