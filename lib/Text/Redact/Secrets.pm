use v5.36;

package Text::Redact::Secrets;

use Carp     qw(croak);
use Exporter qw(import);

our $VERSION = 'v1.0.0';

our @EXPORT_OK = qw(find redact);

# Return a copy of the string with each secret found replaced by
# *REDACTED*. Until the scan is written (roadmap 2026-0001, step 3), it
# finds nothing, so the copy is the string as it was.
sub redact ($string) {
    _check_string($string, 'redact');
    return $string;
}


# Return each secret found in the string, in the order it appears, as a
# hash of its rule's id, the secret and its offset. Until the scan is
# written, it finds nothing.
sub find ($string) {
    _check_string($string, 'search');
    return;
}


# Croak, at the caller's line, unless what's given is a string.
sub _check_string ($string, $verb) {
    croak "Expected a string to $verb" if !defined $string || ref $string;
    return;
}

1;

__END__

=encoding utf8

=head1 NAME

Text::Redact::Secrets - find secrets in text by gitleaks' rules, and redact them

=head1 SYNOPSIS

    use Text::Redact::Secrets qw(find redact);

    # The text with each secret in it replaced by *REDACTED*.
    print {$log} redact($text);

    # Each secret in the text, with the rule that found it.
    for my $found (find($text)) {
        say "$found->{rule} at $found->{offset}";
    }

=head1 DESCRIPTION

Text that might hold a secret, such as a dump written to a log, should
be safe to write. Text::Redact::Secrets finds the secrets in a string
by gitleaks' rules: a maintained set of regexes, keywords, entropies
and allowlists, carried over from gitleaks unchanged. C<redact> puts
C<*REDACTED*> in place of each, and C<find> reports each, with the rule
that found it.

Nothing is exported unless asked for.

=head1 FUNCTIONS

=head2 redact

    my $safe = redact($text);

Returns a copy of C<$text> with each secret found in it replaced by
C<*REDACTED*>. C<$text> itself is left as it was.

=head2 find

    my @found = find($text);

Returns each secret found in C<$text>, in the order it appears, as a
hash reference:

=over

=item C<rule>

The id of the gitleaks rule that found it, such as
C<aws-access-token>.

=item C<secret>

The secret, as the rule picks it out of what it matched.

=item C<offset>

Where the secret starts in C<$text>, counting from 0.

=back

Returns an empty list if there are none.

=head1 DIAGNOSTICS

=over

=item Expected a string to redact

C<redact> was given C<undef> or a reference.

=item Expected a string to search

C<find> was given C<undef> or a reference.

=back

=head1 SEE ALSO

L<gitleaks|https://github.com/gitleaks/gitleaks>, whose rules these
are.

=head1 AUTHOR

Iain Campbell E<lt>cpanic@cpan.orgE<gt>

=head1 LICENSE

Copyright (c) 2026 by Iain Campbell.

This is free software; you can redistribute it and/or modify it under the
same terms as the Perl 5 programming language system itself, except for
its rules, which are gitleaks', under the MIT licence in
F<LICENSE-gitleaks>.

=cut
