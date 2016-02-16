requires 'perl', '5.008001';
requires 'Hash::Merge', '0.200';
requires 'IO::All', '0.86';
requires 'JSON' '2.90';
requires 'Moo', '2.000002';
requires 'Module::Build::Tiny', '0.039';
requires 'Sub::Exporter', '0.987';
requires 'Types::Standard', '1.000005';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

