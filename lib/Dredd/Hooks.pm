package Dredd::Hooks;

use Moo;
use Log::Any;

our $VERSION = "0.01";

use Hash::Merge;
use Types::Standard qw/HashRef ArrayRef/;

has _hooks => (
    is => 'lazy',
    isa => HashRef
);

has hook_files => (
    is => 'ro',
    isa => ArrayRef
);

has log => (
    is => 'ro',
    default => sub { Log::Any->get_logger },
);

# We need routines called 'before' and 'after' which clash with Moo
no Moo;

sub _build__hooks {
    my ($self) = @_;

    my $hooks = {};
    my $hook_files = $self->hook_files;
    return $hooks unless $hook_files;
    return $hooks unless scalar @$hook_files;

    my $merger = Hash::Merge->new('RETAINMENT_PRECEDENT');
    for my $hook_file (@$hook_files){
        next unless -e $hook_file;

        my $hook = do $hook_file;

        die "Couldn't compile hook $hook_file: $@" if $@;
        die "Couldn't read hook $hook_file: $!" if $!;

        next unless $hook && ref $hook eq 'HASH';
        $hooks = $merger->merge($hooks, $hook);
    }

    return $hooks;
}

sub _run_hooks {
    my ($self, $hooks, $transaction) = @_;

    use Data::Dumper;
    $self->log->info(Dumper($transaction));
    $hooks = [$hooks] unless ref $hooks eq 'ARRAY';

    for my $hook (@$hooks){
        next unless $hook && ref $hook eq 'CODE';

        $hook->($transaction);
    }

    return $transaction;
}

sub before {
    my ($self, $transaction) = @_;

    return $self->_run_hooks(
        $self->_hooks->{before}{$transaction->{name}},
        $transaction
    );
}

sub after {
    my ($self, $transaction) = @_;

    use Data::Dumper;
    $self->log->info(Dumper($transaction));
    return $self->_run_hooks(
        $self->_hooks->{after}{$transaction->{name}},
        $transaction
    );
}

sub beforeAll {
    my ($self, $transaction) = @_;

    return $self->_run_hooks(
        $self->_hooks->{beforeAll},
        $transaction
    );
}

sub beforeEach {
    my ($self, $transaction) = @_;

    return $self->_run_hooks(
        $self->_hooks->{beforeEach},
        $transaction
    );
}

sub beforeEachValidation {
    my ($self, $transaction) = @_;

    return $self->_run_hooks(
        $self->_hooks->{beforeEachValidation},
        $transaction
    );
}

sub beforeValidation {
    my ($self, $transaction) = @_;

    return $self->_run_hooks(
        $self->_hooks->{beforeValidation}{$transaction->{name}},
        $transaction
    );
}

sub afterEach {
    my ($self, $transaction) = @_;

    return $self->_run_hooks(
        $self->_hooks->{afterEach},
        $transaction
    );
}

sub afterAll {
    my ($self, $transaction) = @_;

    return $self->_run_hooks(
        $self->_hooks->{afterAll},
        $transaction
    );
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

