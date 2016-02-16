requires 'perl', '5.008001';
requires 'Hash::Merge';
requires 'IO::All';
requires 'JSON';
requires 'Moo';
requires 'Module::Build::Tiny', '0.035';
requires 'Sub::Exporter';
requires 'Types::Standard';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

