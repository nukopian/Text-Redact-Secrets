use v5.36;
use Test2::V0;
use Test2::Plugin::NoWarnings;

# The module of rules, as scripts/update-rules writes it: where its rules
# came from, and that each is whole and compiles as the module compiles
# it. What each finds is tested with the scan.

use Text::Redact::Secrets::Rules;

my $rules   = Text::Redact::Secrets::Rules::rules();
my $globals = Text::Redact::Secrets::Rules::global_allowlists();

# Each regex, compiled as the module compiles it: with /a, and quiet
# about a literal {, which Go's RE2 reads as Perl does, but which Perl
# warns of.
sub compiles ($regex) {
    no warnings qw(regexp);
    return eval { qr($regex)a; 1 };
}

subtest 'Where the rules came from' => sub {
    like Text::Redact::Secrets::Rules::gitleaks_tag(),
        qr( \A v \d+ \. \d+ \. \d+ \z )x, 'a gitleaks tag';
    like Text::Redact::Secrets::Rules::gitleaks_commit(),
        qr( \A [0-9a-f]{40} \z )x, 'a full commit hash';
};

subtest 'The rules' => sub {
    ok @$rules > 0, 'there are some';
    my %ids;
    for my $rule (@$rules) {
        my $id = $rule->{id} // '(no id)';
        $ids{$id}++;
        ok defined $rule->{regex},   "$id has a regex";
        ok compiles($rule->{regex}), "${id}'s regex compiles";
        for my $allowlist (@{ $rule->{allowlists} // [] }) {
            ok compiles($_), "${id}'s allowlist's regex compiles: $_"
                for @{ $allowlist->{regexes} // [] };
        }
    }
    is [grep { $ids{$_} > 1 } sort keys %ids], [], 'each id is used once';
};

subtest 'The global allowlists' => sub {
    ok @$globals > 0, 'there are some';
    for my $allowlist (@$globals) {
        ok $allowlist->{regexes} || $allowlist->{stopwords},
            'each has regexes or stopwords';
        ok compiles($_), "its regex compiles: $_"
            for @{ $allowlist->{regexes} // [] };
    }
};

done_testing;
