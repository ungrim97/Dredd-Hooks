package Dredd::Hooks::Methods;

use Sub::Exporter::Progressive -setup => {
    exports => [qw/
        before
        before_all
        before_each
        before_each_validation
        before_each_validation
        after
        after_all
        after_each
        get_hooks
        merge_hooks
    /],
    groups => {
        default => [qw/
            before
            before_all
            before_each
            before_each_validation
            before_each_validation
            after
            after_all
            after_each
        /],
        handler => [qw/
            get_hooks
            merge_hooks
        /]
    }
};

{
    my $hooks = {};
    sub get_hooks {
        return $hooks;
    }

    my $merger = Hash::Merge->new('RETAINMENT_PRECEDENT');
    sub merge_hook {
        my ($hook) = @_;

        $hooks = $merger->merge($hooks, $hook);
    }
}

sub before {
    my ($name, $callback) = @_;

    merge_hook({before => { $name => $callback }});
}

sub after {
    my ($name, $callback) = @_;

    merge_hook({after => { $name => $callback }});
}

sub beforeValidation {
    my ($name, $callback) = @_;

    merge_hook({beforeValidation => { $name => $callback }});
}

sub beforeEachValidation {
    my ($name, $callback) = @_;

    merge_hook({beforeEachValidation => $callback });
}

sub beforeEach {
    my ($name, $callback) = @_;

    merge_hook({beforeEach => $callback });
}

sub afterEach {
    my ($name, $callback) = @_;

    merge_hook({afterEach => $callback });
}

sub beforeAll {
    my ($name, $callback) = @_;

    merge_hook({beforeAll => $callback });
}

sub afterAll {
    my ($name, $callback) = @_;

    merge_hook({afterAll => $callback });
}

1;
