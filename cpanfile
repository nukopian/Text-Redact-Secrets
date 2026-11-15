requires 'perl', '5.036';
requires 'Carp';
requires 'Exporter';
requires 'experimental';

on test => sub {
    requires 'Test2::V0';
    requires 'Test2::Plugin::NoWarnings';
};

# The maintainers' tools, as Ekorn-Pipeline's, less what only it needs.
# scripts/update-rules will need a TOML parser too; which is Iain's to
# decide (TODO.md).
on develop => sub {
    requires 'CPAN::Uploader';
    requires 'Data::Dump';
    requires 'Devel::Cover';
    requires 'JSON::PP', '4.18';
    requires 'Minilla';
    requires 'Perl::Critic';
    requires 'Perl::Tidy';
    requires 'Pod::Coverage';
    requires 'Pod::Markdown::Github';
    requires 'Software::License';
    requires 'Test2::Harness';
    requires 'Test2::Plugin::Cover';
    requires 'Test::Spellunker';
    requires 'UUID';
    requires 'Version::Next';
};
