package Dredd::Hooks;

use Moo;

our $VERSION = "0.01";

use Hash::Merge;
use Types::Standard qw/HashRef/;

has hooks => (
    is => 'ro',
    isa => HashRef
);

sub BUILDARGS {
    my ($self, %args) = @_;

    $args{hooks} = $self->_parse_hooks(delete $args{hook_files});
    return \%args;
}

sub _parse_hooks {
    my ($self, $hook_files) = @_;

    return unless $hook_files
    my $hooks;
    for my $hook_file ($hook_files){
        $hooks = Hash::Merge::merge($hooks, do $hook_file);
    }

    return $hooks;
}

sub before {
    my ($self, $transaction) = @_;

    my $hook = $self->hooks->{before}{$transaction->name};

    return unless $hook;

    return $hook->($transaction);
}

sub beforeAll {
    my ($self, $transaction) = @_;

    my $hook = $self->hooks->{beforeAll};

    return unless $hook;

    return $hook->($transaction);
}

sub beforeEach {
    my ($self, $transaction) = @_;

    my $hook = $self->hooks->{beforeEach};

    return unless $hook;

    return $hook->($transaction);
}

sub beforeEachValidation {
    my ($self, $transaction) = @_;

    my $hook = $self->hooks->{beforeEachValidation};

    return unless $hook;

    return $hook->($transaction);
}

sub beforeValidation {
    my ($self, $transaction) = @_;

    my $hook = $self->hooks->{beforeValidation}{$transaction->name};

    return unless $hook;

    return $hook->($transaction);
}

sub after {
    my ($self, $transaction) = @_;

    my $hook = $self->hooks->{after}{$transaction->name};

    return unless $hook;

    return $hook->($transaction);
}

sub afterEach {
    my ($self, $transaction) = @_;

    my $hook = $self->hooks->{afterEach};

    return unless $hook;

    return $hook->($transaction);
}

sub afterAll {
    my ($self, $transaction) = @_;

    my $hook = $self->hooks->{afterAll};

    return unless $hook;

    return $hook->($transaction);
}

1;
__END__

=encoding utf-8

=head1 NAME

Dredd::Hooks - It's new $module

=head1 SYNOPSIS

    use Dredd::Hooks;

=head1 DESCRIPTION

Dredd::Hooks is ...

=head1 LICENSE

Copyright (C) Mike Eve.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Mike Eve E<lt>ungrim97@gmail.comE<gt>

=cut

