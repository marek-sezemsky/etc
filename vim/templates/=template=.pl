#!/usr/bin/perl

=head1 NAME

%FFILE% - short one-line description of script.

=head1 SYNOPSIS

%FFILE% [--argument=value]

=head1 DESCRIPTION

Long description of script.

=head1 OPTIONS

=over

=item B<-a>=I<value>, B<--argument>=I<value>

Script's arguments.

=item B<-h>, B<--help>

Short or long version of help.

=item B<--verbose>

=item B<--debug>

=item B<--trace>

Enable verbose, debug or trace outputs.

=back

=head1 EXIT STATUS

Return 0 when everything is OK, non-zero value on error.

=head1 EXAMPLES

Examples how to use the script.

=head1 LICENSE

    Copyright 2014 Deutsche Boerse Services s.r.o.

=cut

use 5.008;
use strict;
use warnings;

use Data::Dumper;
use Getopt::Long;
use Pod::Usage;

use Local::Tools 0.12 qw( :all );

#
# parse_arguments
#
# Parse script's command line arguments into hash, exit on errors.
#
sub parse_arguments # {{{
{
    trace();

    my %args;
    my @options = (
        'argument|a=s',
        # default arguments:
        'h+',
        'help+',
        'verbose+',
        'debug+',
        'trace+',
    );
    if ( not GetOptions(\%args, @options) ) {
        pod2usage(2);
    }
    pod2usage(1) if $args{h};
    pod2usage(-verbose => 2) if $args{help};
    pod2usage(2) if @ARGV;

    want_verbose(1) if $args{verbose};
    want_debug(1)   if $args{debug};
    want_trace(1)   if $args{trace};

    trace("Parsed arguments: ", Dumper \%args);
    return %args;
} # }}}

#
# main()
#

my %args = parse_arguments();

if ( defined $args{argument} ) {
    msg("Argument is: ", $args{argument});
}
else {
    msg_warning("No argument specified. Perhaps try --help?");
    exit 1;
}

# vim:foldmethod=marker:ts=4:sw=4:st=4:expandtab:tw=78
