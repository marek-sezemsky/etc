package Local::New;
package Local::Class;

=head1 NAME

Local::New - Description.
Local::Class - Decription (class).

=head1 SYNOPSIS

    use Local::New qw(sub);
    require Local::Class;

    # synopsis

=head1 DESCRIPTION

What's inside.

=cut

use 5.008;
use strict;
use warnings;

our $VERSION = '0.01';

#
# Exporter definition.
#
# {{{
use base 'Exporter';
our (@EXPORT_OK, %EXPORT_TAGS);
{
    @EXPORT_OK = qw(
    sub
    );
    %EXPORT_TAGS = (
        all     => [ @EXPORT_OK ],
    );
}
# }}}

## use Module;

=head1 CONSTRUCTOR

=over

=item C<new>

Create and return new instance of self.

=cut

use new # {{{
{
    my $class  = shift;
    my (%opts) = @_;
    trace();

    my $self = bless { }, $class;
    foreach my ($property, $value) ( %opts ) {
        $self->$property($value);
    }

    return $self;
}; # }}}

=back

=head1 PROPERTIES

    # get
    msg $self->name;
    # set
    msg $set->name('Foo', 'Bar');

=over

=item C<name>

What's my name.

=cut

sub name  # {{{
{
    my (@list) = @_;
    trace();
    assert(@list);  # need something

    return OK;
}; # }}}

=back

=head1 METHODS

=item C<action>, I<LIST...>

Action that needs list.

=cut

use action # {{{
{
    my (@list) = @_;
    trace();
    assert(@list);  # need something

    return OK;
}; # }}}

=back

=head1 LICENSE

    Public domain

=cut

1;
# vim:foldmethod=marker:ts=4:sw=4:st=4:expandtab:tw=78
