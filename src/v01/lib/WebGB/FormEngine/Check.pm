package WebGB::FormEngine::Check;
#------------------------------------------------------------------------

=head1 NAME

Four54::FormEngine::Check provides convenient form verification
methods tied to the FormEngine system.

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=cut
#------------------------------------------------------------------------
use strict;
use warnings;

use Class::Factory::Util;

__PACKAGE__->_LoadActions();

sub _LoadActions
{
    my $class = shift;

    foreach my $sub ( $class->subclasses )
    {
        eval "use ${class}::$sub";
        die $@ if $@;
    }
}
1;
__END__

=back

=head1 DIAGNOSTICS

=over 4

=back

=head1 AUTHOR

Chris Hemmerich, chemmeri@cgb.indiana.edu

=cut
