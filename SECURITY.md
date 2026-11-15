# Security

This is the security policy for Text-Redact-Secrets, the Perl
distribution of Text::Redact::Secrets.

## Reporting a vulnerability

Please report a vulnerability privately, never in a public issue,
either way:

- on GitHub, with **Report a vulnerability** on the Security tab of the
  repository MetaCPAN links to (Security → Advisories → Report a
  vulnerability);
- by email, to the maintainer, Iain Campbell, at <cpanic@cpan.org>.

If you can't reach the maintainer, or have had no reply after a
reasonable time, contact the CPAN Security Group, at
<cpan-security@security.metacpan.org>.

A useful report has the version of Text::Redact::Secrets, and of Perl;
a reproduction, as small as you can make it; and what an attacker could
do with it. You'll get a reply when it has been read, and credit in the
advisory and in `Changes` if you'd like it.

## Scope

This policy covers the modules in this distribution: a secret that
`redact` lets through, where its rule says it shouldn't, is in scope;
so is a regex that takes too long on text an attacker can choose. A
rule that misses a kind of secret, or matches what isn't one, comes
from gitleaks, whose rules these are, and is best reported there; a
report here is welcome too, as it may be how the rules were carried
over. A vulnerability in a module that uses this one, such as
Ekorn::Pipeline, belongs to that project.

## Supported versions

Only the latest release is supported, on Perl 5.36 or later.

## Fixes

Fixes go into a new release, and `Changes` says what it fixes. A
release on CPAN is never changed: a version with a vulnerability may be
deleted from CPAN, though BackPAN keeps it, and the fixed one replaces
it.

This project doesn't pay for reports.
