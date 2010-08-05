package WebGB::FormEngine::SkinUniform;
#------------------------------------------------------------------------

=head1 NAME

WebGB::FormEngine::SkinUniform - skin using Uni-Form CSS tool.

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut
#------------------------------------------------------------------------
use strict;
use warnings;

use base qw( WebGB::FormEngine::Skin );

{

#========================================================================

=head2 METHODS

=over 4

=cut
#========================================================================

#------------------------------------------------------------------------

=item PRIVATE HashRef _init_templ();

Returns template data for this skin. Do not call this method directly.

=cut
#------------------------------------------------------------------------
  sub _init_templ {

    my $confirm_handler = {};
    
    my %templ;
    
    # first tackle atomic elements
    $templ{_text} = '<input name="<&NAME&>" id="<&LABEL&>" value="<&#value&>" size="<&SIZE&>" maxlength="<&MAXLEN&>" type="text" class="textInput highlighter" />';
    
    $templ{_password} = '<input name="<&NAME&>" id="<&LABEL&>" value="<&#value&>" size="<&SIZE&>" maxlength="<&MAXLEN&>" type="password
" class="textInput highlighter" />';
    
    $templ{_textarea} = '<textarea name="<&NAME&>" id="<&LABEL&>" rows="<&ROWS&>" cols="<&COLS&>" <&#readonly&>><&#value&></textarea>';
    
    $templ{_check} = '<~
<label for="<&OPT_VAL&>" class="inlineLabel"><input name="<&NAME&>" id="<&OPT_VAL&>" value="<&OPT_VAL&>" type="checkbox"<&#checked&>/><&OPTION&></label>~OPT_VAL OPTION~>';
    
    $templ{_select} = '<select name="<&NAME&>" id="<&LABEL&>" size="<&SIZE&>" class="selectInput"><&option&></select>';

    $templ{option} = '<~
  <option value="<&OPT_VAL&>" <&#checked selected&>><&OPTION&></options>~OPTION OPT_VAL~>';
    
    # upload
    $templ{_upload} = '<input name="<&NAME&>" id=<&LABEL&>" size="30" type="file" class="fileUpload" />';
    
    # radio
    $templ{_radio} = '<label for="<&OPT_VAL&>" class="inlineLabel"><input name="<&NAME&>" value="<&OPT_VAL&>" id="<&OPT_VAL&>" type="radio" <&#checked&>><&OPTION&></label>';
    
    # print
    $templ{_print} = '<p><&VALUE&></p>';

    my %error_handler;
    $error_handler{'_check'} = '#error_check';

    $templ{fieldset} = '
<!
<script type="text/javascript">
$(document).ready( function() {

  $(\'#<&JSHIDE&>\').hide();

  $(\'img#<&JSHIDE&>-click\').click(function() {
    $(\'#<&JSHIDE&>\').toggle(\'fast\');

    var currimg = $(\'img#<&JSHIDE&>-click\').attr("src");
    if ( currimg == "/include/img/icon/plus.gif" ) {
     $(\'img#<&JSHIDE&>-click\').attr("src", "/include/img/icon/minus.gif");
    } else {
     $(\'img#<&JSHIDE&>-click\').attr("src", "/include/img/icon/plus.gif");
    }
    return false;
  });
});
</script> 
! JSHIDE !>

<fieldset class="inlineLabels">
<legend><! <img src="/include/img/icon/plus.gif" id="<&JSHIDE&>-click">
! JSHIDE !><&TITLE&></legend>
<! <div id="<&JSHIDE&>"> ! JSHIDE !>
<~
<&TEMPL&>~TEMPL~>
<! </div> ! JSHIDE !>
</fieldset>
';
    
    # build aliases
    foreach ( keys %templ ) {
      my $templ = $_;
      
      if ( s{^_}{} ) {
	$templ .= ',' . ($error_handler{$templ} || '#error_in') . ',' . 
	  ($confirm_handler->{$templ} || '');
	$templ{$_} = '<&_row '.$templ.'&>'
	  unless( defined($templ{$_}) );
      }
    }
    

    # hidden
    $templ{_hidden} = '<input type="hidden" name="<&NAME&>" value="<&#value&>" />';
    $templ{hidden}  = '<&_hidden&>';
    
    $templ{main} = '

<form class="uniForm inlineLabels" action="<&ACTION&>" method="<&METHOD&>" name="<&FORMNAME&>" enctype="<&ENCTYPE&>">
<div align="center" class="buttonHolder">
<~<&HIDDEN&>~HIDDEN~>
<!<input type="submit" class="resetButton" name="<&CANCEL&>" value="<&CANCEL&>" />!CANCEL!>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" class="submitButton" name="<&FORMNAME&>" value="<&SUBMIT&>" />
</div>
<~
<&TEMPL&>~TEMPL~>

 <fieldset>
<div align="center" class="buttonHolder">
<~<&HIDDEN&>~HIDDEN~>
<!<input type="submit" class="resetButton" name="<&CANCEL&>" value="<&CANCEL&>" />!CANCEL!>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="submit" class="submitButton" name="<&FORMNAME&>" value="<&SUBMIT&>" />
</div>


 </fieldset>

</form>
';


    $templ{_row} = '<&#testset <&#error&>,MYERROR&>
<div class="ctrlHolder <! error !MYERROR!>">
 <label for="<&LABEL&>"><! <em>*</em> ! REQUIRED !> <&TITLE&> <!
<p class="intro"><&TIP&></p> 
! TIP !>
</label>
<!<p id="error1" class="errorField"><strong><&MYERROR&></strong></p>!MYERROR!>
<&<&#arg 0&>&>
<! <p class="formHint"><&HINT&></p> ! HINT!>
</div>
';


    return \%templ;
  }

#------------------------------------------------------------------------

=item PRIVATE HashRef _init_default();

Returns default values for this skin. Do not call this method directly.

=cut
#------------------------------------------------------------------------
  sub _init_default {
    my %default = %{WebGB::FormEngine::Skin::_init_default()};
    $default{_column} = {};
    return \%default;
  }

#------------------------------------------------------------------------

=item PRIVATE HashRef _init_handler();

Returns handlers for this skin. Do not call this method directly.

=cut
#------------------------------------------------------------------------
  sub _init_handler {
    my %handler = %{WebGB::FormEngine::Skin::_init_handler()};
    $handler{'#testset'} = \&WebGB::FormEngine::SkinUniform::_handle_testset;
    return \%handler;
  }


  sub _handle_testset {
    
    my ($self, $caller, $expr, $tovar) = @_;
    
    my $val = $self->_parse($expr);
    
    if ( $val ) {
      $self->{varstack}->[0]->{$tovar} = $val;
    } else {
      exists $self->{varstack}->[0]->{$tovar}
	and delete $self->{varstack}->[0]->{$tovar};
    }
    return '';
  }
 
  WebGB::FormEngine::SkinUniform->_init();
 
}
1;
__END__
