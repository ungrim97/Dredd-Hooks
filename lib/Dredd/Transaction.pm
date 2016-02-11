package Dredd::Transaction;

use Moo;
use Types::Standard;

has name => (is => 'ro');
has host => (is => 'ro');
has port => (is => 'ro');
has protocol => (is => 'ro');
has fullPath => (is => 'ro');
has request => (is => 'ro');
has expected => (is => 'ro');
has real => (is => 'ro');
has origin => (is => 'ro');
has skip => (is => 'ro');
has fail => (is => 'ro');
has test => (is => 'ro');
has results => (is => 'ro');

sub TO_JSON {
    my ($self) = @_;

    return {
        name => $self->name,
        host => $self->host,
        port => $self->port,
        protocol => $self->protocol,
        fullPath => $self->fullPath,
        request => $self->request,
        expected => $self->expected,
        real    => $self->real,
        origin => $self->origin,
        skip    => $self->skip,
        fail    => $self->fail,
        test => $self->test,
        results => $self->results
    };
}

1;
