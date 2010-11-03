package WebGB::FormEngine;
#------------------------------------------------------------------------
=pod

=head1 NAME

WebGB::FormEngine implements the API for processing forms

=head1 SYNOPSIS

=head1 DESCRIPTION

B<WebGB::FormEngine>

=head1 METHODS

=cut
#------------------------------------------------------------------------
use strict;
use warnings;

use base 'HTML::FormEngine';
use Clone qw(clone);
use Hash::Merge;

#use WebGB::FormEngine::Check;

#========================================================================

=head2 METHODS

=over 4

=cut
#========================================================================

#------------------------------------------------------------------------

=item public [data] get_inputs(string field)

Companion method to get_input, but forces the returned value into an
array reference.

=cut
#------------------------------------------------------------------------
sub get_inputs {
  
  my ($this, $field) = @_;
  my $res = $this->_get_input($field);
  defined $res or return [];

  if ( ref($res) eq 'ARRAY' ) {
    @$res == 1 and $res = $res->[0];
  }
  
  return ( ref($res) eq 'ARRAY' ? $res : [$res]);
}

#------------------------------------------------------------------------

=item public boolean canceled();

Returns true if the cancel button has been pressed.

=cut
#------------------------------------------------------------------------
sub canceled {
  
  my $this = shift;
  
  return defined( $this->{input}{$this->{conf}{CANCEL} || $this->{skin_obj}->get_default('main','CANCEL')} );
}

#------------------------------------------------------------------------

=item public boolean ok();

Override FormEngine to consider result of canceled when determning
whether a form is ok or not.

=cut
#------------------------------------------------------------------------
sub ok {

  my $this = shift;
  
  return $this->is_submitted && (! $this->get_error_count) && (! $this->confirmation_canceled) && (! $this->canceled );
}

#------------------------------------------------------------------------

=item public _call_me_before_make();

Define this subroutine to avoid CODEREF in form object.

=cut
#------------------------------------------------------------------------
sub _call_me_before_make {
  
  my $self = shift;
  $self->{values} = {};
  $self->{nconf} = { main => [ clone($self->{conf}) ] };
  $self->{varstack} = [];
  $self->{varstack_defaults} = [];
}

#------------------------------------------------------------------------

=item public make()

Override to remove CODEREF.

=cut
#------------------------------------------------------------------------
sub make {

  my $self = shift;

  $self->$_() for @{$self->{call_before_make}};


  my $pupo_defaults = $self->_push_varstack($self->{skin_obj}->get_default('default'), 'varstack_defaults');

  $self->{cont} = $self->_parse('<&main&>', 1);

  $self->_pop_varstack($pupo_defaults, 'varstack_defaults');

  return 1 if($self->{cont});
  return 0;
}

#------------------------------------------------------------------------

=item public _initialize(hashref input);

Override _initialize to fix a few things.

=cut
#------------------------------------------------------------------------
sub _initialize {

  my ($self,$input) = @_;
  Hash::Merge::set_behavior('LEFT_PRECEDENT');

  # the form input
  $self->{input} = {};
  $self->set_input($input);
  $self->{errcount} = 0;
  $self->{use_input} = 1;
  $self->{check_error} = 1;
  $self->{cont} = '';
  $self->{conf} = {};
  $self->{conf_main} = {};
  $self->{call_make} = 0;
  $self->{call_before_make} = ['_call_me_before_make'];

  $self->{depth} = 0;
  $self->{seperate} = 0;
  $self->{reset_on_seperate} = [];
  $self->{loop} = [];
  $self->{loop_var} = {};
  $self->{loop_deep} = [];
  $self->{loop_deep_var} = {};
  $self->{loop_deep2} = [];
  $self->{skin_obj} = 'WebGB::FormEngine::SkinUniform';
}

#------------------------------------------------------------------------

=item public set_skin_obj(string class);

Override _initialize to fix a few things.

=cut
#------------------------------------------------------------------------
sub set_skin_obj {
  my($self, $skin) = @_;
  $self->{skin_obj} = $skin;
}



1;
__END__
