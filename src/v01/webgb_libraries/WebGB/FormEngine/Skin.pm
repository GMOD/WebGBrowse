package WebGB::FormEngine::Skin;
#------------------------------------------------------------------------

=head1 NAME

WebGB::FormEngine::Skin

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=over 4

=cut
#------------------------------------------------------------------------
use strict;
use warnings;

use Digest::MD5 qw(md5_hex);

{ 

  # hash to hold all definitions
  my %skins;

#========================================================================

=back

=head2 ACCESSORS

=over 4

=cut
#========================================================================

#------------------------------------------------------------------------

=item public get_templ();

Returns a hash reference containing all templates.

=item public get_templ(string name);

Returns the definition of the template with the given name.

=cut
#------------------------------------------------------------------------
  sub get_templ {

    my ($self, $name) = @_;
    return ( $name ? $skins{$self}{templ}{$name} : $skins{$self}{templ} );
  }
   
#------------------------------------------------------------------------

=item public get_default();

Returns all default settings as a hash reference.

=item public get_default(string template);

Returns all the default settings for the given template.

=item public get_default(string variable);

Returns the default setting for the given variable in the given template.

=cut
#------------------------------------------------------------------------
  sub get_default {

    my ($self, $templ, $var) = @_;

    my $s = $skins{$self}{default};

    if ( defined $templ ) {

      if ( defined $var ) {
	return $s->{$templ}{$var}
	  if exists $s->{$templ}{$var};
	return $s->{main}{$var} 
	  if exists $s->{main}{$var};
	return $s->{$var};
      }
      
      return $s->{$templ};
    }
    
    return $s;
  }

#------------------------------------------------------------------------

=item public get_handler();

Returns a hash reference containing all handlers.

=item public get_handler(string name);

Returns the definition of the handlers with the given name.

=cut
#------------------------------------------------------------------------
  sub get_handler {

    my ($self, $name) = @_;
    return ( $name ? $skins{$self}{handler}{$name} : $skins{$self}{handler} );
  }

#------------------------------------------------------------------------

=item public data get_check();

Returns a hash reference containing all checks.

=item public data get_check(string name);

Returns the definition of the checks with the given name.

=cut
#------------------------------------------------------------------------
  sub get_check {

    my ($self, $name) = @_;
    return ( $name ? $skins{$self}{check}{$name} : $skins{$self}{check} );
  }

#------------------------------------------------------------------------

=item public  get_confirm_skin();

Returns the registered confirmation skin for this skin, or false if no
confirmation skin exists.

=cut
#------------------------------------------------------------------------
  sub get_confirm_skin { return $skins{$_[0]}{confirm_skin}; }

#------------------------------------------------------------------------

=item public  get_not_null_string();

Returns the registered not_null_string for this skin.

=cut
#------------------------------------------------------------------------
  sub get_not_null_string { return $skins{$_[0]}{not_null_string}; }

#========================================================================

=back

=head2 METHODS

=over 4

=cut
#========================================================================

#------------------------------------------------------------------------

=item public boolean is_hidden(string template);

Returns true if the template with the given name is registered as I<hidden>.

=cut
#------------------------------------------------------------------------
  sub is_hidden {

    my ($self, $templ) = @_;
    return ( exists $skins{$self}{hidden}{$templ} ? $skins{$self}{hidden}{$templ} : 0 );
  }
    
#------------------------------------------------------------------------

=item PRIVATE void _init();

Initialize the skin template.

=cut
#------------------------------------------------------------------------
  sub _init {
    
    my $class = shift;
    my $self = bless {}, $class;

    $self->{templ} = $self->_init_templ();
    $self->{handler} = $self->_init_handler();
    $self->{default} = $self->_init_default();
    $self->{hidden} = $self->_init_hidden();
    $self->{check} = $self->_init_check();
    $self->{confirm_skin} = $self->_init_confirm_skin();
    $self->{not_null_string} = $self->_init_not_null_string();

    $skins{$class} = $self;
  }

#------------------------------------------------------------------------

=item PRIVATE void _register_check(string name);

Initialize the skin template.

=cut
#------------------------------------------------------------------------
  sub _register_check {

    my ($class, $check) = @_;

    my $method = 'WebGB::FormEngine::Check::' . $check;
    $skins{$class}{check}{$check} = \&{$method};
  }

#------------------------------------------------------------------------

=item PRIVATE void _init_templ();

Initialize the skin template.

=cut
#------------------------------------------------------------------------  
  sub _init_templ {

   my %templ;
   $templ{_text} = '<input type="<&TYPE&>" value="<&#value&>" name="<&NAME&>" id="<&ID&>" maxlength="<&MAXLEN&>" size="<&SIZE&>" <&#readonly&> <&TEXT_XP&>/>';
   $templ{_button} = '<button type="<&TYPE&>" value="<&VALUE&>" name="<&NAME&>" id="<&ID&>" <&BUTTON_XP&>/>';
   $templ{_radio} = '<input type="radio" value="<&OPT_VAL&>" name="<&NAME&>" id="<&ID&>" <&#checked&> <&RADIO_XP&>/><&OPTION&>';
   $templ{_select} = '
     <select size="<&SIZE&>" name="<&NAME&>" id="<&ID&>" <&#multiple&> <&SELECT_XP&>><&_option&>
     </select>';
   $templ{_select_optgroup} = '
      <select size="<&SIZE&>" name="<&NAME&>" id="<&ID&>" <&#multiple&> <&SELECT_XP&>><&_optgroup&>
      </select>';
   $templ{_select_flexible} = '
      <select size="<&SIZE&>" name="<&NAME&>" id="<&ID&>" <&#multiple&> <&SELECT_XP&>><~ <&TEMPL&> ~TEMPL~>
      </select>';
   $templ{_optgroup} = '<~
        <optgroup label="<&OPTGROUP&>" <&OPTGROUP_XP&>><&_option&>
        </optgroup>~OPTGROUP OPTION OPT_VAL~>';
   $templ{optgroup} = '<&_optgroup&>';
   $templ{optgroup_flexible} = '
        <optgroup label="<&OPTGROUP&>" <&OPTGROUP_XP&>><~ <&TEMPL&> ~TEMPL~>
        </optgroup>';
   $templ{_option} = '<~
        <option value="<&OPT_VAL&>" label="<&OPTION&>" <&#checked selected&> <&OPTION_XP&>><&OPTION&></option> ~OPTION OPT_VAL~>';
	  $templ{option} = '<&_option&>';
   $templ{_check} = '<input type="checkbox" value="<&OPT_VAL&>" name="<&NAME&>" id="<&ID&>" <&#checked&> <&CHECKBOX_XP&>/><&OPTION&>';
   $templ{_textarea} = '<textarea name="<&NAME&>" id="<&ID&>" cols="<&COLS&>" rows="<&ROWS&>" <&#readonly&> <&TEXTAREA_XP&>><&#value&></textarea>';
   $templ{_hidden} = '<input type="hidden" name="<&NAME&>" id="<&ID&>" value="<&#value&>" <&HIDDEN_XP&>/>';
   $templ{hidden} = '<&_hidden&>';
   $templ{_fieldset} = '
   <fieldset>
   <legend><&LEGEND&></legend>
   <table border=0><~
     <tr><&TEMPL&></tr>~TEMPL~>
   </table>
   </fieldset>';
   $templ{_templ} = '<~<&TEMPL&>~TEMPL~>';
   $templ{_print} = '<&#value -,1&><input type="hidden" name="<&NAME&>" value="<&#value&>" />';
   $templ{_print_option} = '<~
        <&OPTION&><!<input type="hidden" value="<&OPT_VAL&>" name="<&NAME&>" />!OPT_VAL NAME!> ~OPTION OPT_VAL~>';
   return \%templ;
 }   
  

  
  sub _init_default {
    my %default;
    $default{_text} = {TYPE => 'text', SIZE => 20};
    $default{_radio} = {};
    $default{_select} = {};
    $default{_check} = {};
    $default{optgroup} = {};
    $default{option} = {};
    $default{_select_optgroup} = {};
    $default{_textarea} = {COLS => 27, ROWS => 10};
    $default{_button} = {TYPE => 'button'};
    $default{main} = {
		      ACTION => $ENV{REQUEST_URI},
		      METHOD => 'post',
		      ACCEPT => '*',
		      ENCTYPE => 'application/x-www-form-urlencoded',
		      TARGET => '_self',
		      CONFIRMSG => 'Are you really sure, that you want to submit the following data?',
		      CONFMSG_ALIGN => 'center',
		      CANCEL => 'Cancel Changes',
		      CONFIRMED => 'confirmed',
		      CONFIRM_CANCEL => 'confirm_cancel',
		      SEPVAL => md5_hex('F02r23m234E345n42g6i46ne%$'),
		      FORM_ALIGN => 'center',
		      SUBMIT_ALIGN => 'right',
		      CANCEL_ALIGN => 'left',
		      FORM_TABLE_BORDER => 0,
		      FORM_TABLE_CELLSP => 1,
		      FORM_TABLE_CELLPAD => 1,
		     };
    $default{default} = {
			 templ => 'text',
			 TITLE => '<&NAME&>',
			 ID => '<&NAME&>',
			 NAME => '<&ID&>',
			 OPT_VAL => '<&OPTION&>',
			 OPTION => '<&OPT_VAL&>',
			 SUBMIT => 'Save and Continue',
			 FORMNAME => 'FormEngine',
			 TITLE_ALIGN => 'left',
			 TITLE_VALIGN => 'top',
			 TABLE_BORDER => 0,
			 TABLE_CELLSP => 0,
			 TABLE_CELLPAD => 0,
			 TD_VALIGN => 'top',
			 TABLE_BORDER_IN => 0,
			 TABLE_CELLSP_IN => 0,
			 TABLE_CELLPAD_IN => 0,
			 TD_EXTRA_ERROR => 'style="color:#FF0000"',
			 TD_EXTRA_ERROR_IN => 'style="color:#FF0000"',
			 SPAN_EXTRA_ERROR => 'style="color:#FF0000"',
			 ERROR_VALIGN => 'bottom',
			 ERROR_ALIGN => 'left',
			 TABLE_WIDTH => '100%',
			 SP_NOTNULL => '',
			 SP_NOTNULL_IN => '',
			};
    return \%default;
  }
  
  sub _init_handler {
    require HTML::FormEngine::Handler;
    my %handler;
    $handler{default} = \&HTML::FormEngine::Handler::_handle_default;
    $handler{'#checked'} = \&HTML::FormEngine::Handler::_handle_checked;
    $handler{'#value'} = \&HTML::FormEngine::Handler::_handle_value;
    $handler{'#error'} = \&HTML::FormEngine::Handler::_handle_error;
    $handler{'#error_check'} = \&HTML::FormEngine::Handler::_handle_error;
    $handler{'#error_in'} = \&HTML::FormEngine::Handler::_handle_error;
    $handler{'#gettext'} = \&HTML::FormEngine::Handler::_handle_gettext;
    $handler{'#gettext_var'} = \&HTML::FormEngine::Handler::_handle_gettext_var;
    $handler{'#label'} = \&HTML::FormEngine::Handler::_handle_label;
    $handler{'#decide'} = \&HTML::FormEngine::Handler::_handle_decide;
    $handler{'#readonly'} = \&HTML::FormEngine::Handler::_handle_readonly;
    $handler{'#multiple'} = \&HTML::FormEngine::Handler::_handle_multiple;
    $handler{'#confirm_check_prepare'} = \&HTML::FormEngine::Handler::_handle_confirm_check_prepare;
    $handler{'#seperate'} = \&HTML::FormEngine::Handler::_handle_seperate;
    $handler{'#seperate_conly'} = \&HTML::FormEngine::Handler::_handle_seperate;
    $handler{'#encentities'} = \&HTML::FormEngine::Handler::_handle_encentities;
    $handler{'#save_to_global'} = \&HTML::FormEngine::Handler::_handle_save_to_global;
    $handler{'#not_null'} = \&HTML::FormEngine::Handler::_handle_not_null;
    $handler{'#htmltotext'} = \&HTML::FormEngine::Handler::_handle_html2text;
    $handler{'#arg'} = \&HTML::FormEngine::Handler::_handle_arg;
    return \%handler;
  }

  sub _init_check {
    require HTML::FormEngine::Checks;
    my %check;
    $check{not_null} = \&HTML::FormEngine::Checks::_check_not_null;
    $check{email} = \&HTML::FormEngine::Checks::_check_email;
    $check{rfc822} = \&HTML::FormEngine::Checks::_check_rfc822;
    $check{date} = \&HTML::FormEngine::Checks::_check_date;
    $check{digitonly} = \&HTML::FormEngine::Checks::_check_digitonly;
    $check{fmatch} = \&HTML::FormEngine::Checks::_check_match;
    $check{match} = \&HTML::FormEngine::Checks::_check_match;
    $check{regex} = \&HTML::FormEngine::Checks::_check_regex;
    $check{unique} = \&HTML::FormEngine::Checks::_check_unique;
    return \%check;
  }
  
  sub _init_hidden {
    my %hidden=('hidden' => 1);
    return \%hidden;
  }
  
  sub _init_confirm_skin {
#    require HTML::FormEngine::SkinConfirm;
#    return new HTML::FormEngine::SkinConfirm;
    #return undef;
  }
  
  sub _init_not_null_string {
    return ''; #*
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
