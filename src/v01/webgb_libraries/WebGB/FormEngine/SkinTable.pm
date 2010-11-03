package WebGB::FormEngine::SkinTable;
#------------------------------------------------------------------------

=head1 NAME

WebGB::FormEngine::SkinTable - lite skin for tabular html forms.

=head1 SYNOPSIS

=head1 DESCRIPTION

This skin is for tabular forms with entities selectable by row.

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


  # first do atomic elemenents
  $templ{_text} = '<input type="text" value="<&#value&>" name="<&NAME&>" maxlength="<&MAXLEN&>" size="<&SIZE&>" <&#readonly&> />';
  $templ{_button} = '<button type="<&TYPE&>" value="<&VALUE&>" name="<&NAME&>"/>';

  $templ{main} = '
<form action="<&ACTION&>" method="<&METHOD&>" name="<&FORMNAME&>">
<div id="list">
<table>
 <tr class="<&TITLECLASS&>" >
  <~<td align="<&TITLEALIGN&>"><&TITLE&></td>~TITLE TITLEALIGN~>
 </tr>
 <~<&TEMPL&>~TEMPL~>
 <tr>
   <td align="<&CANCEL_ALIGN&>">
     <!<input class="<&BUTTONCLASS&>" type="submit" name="<&CANCEL&>" value="<&CANCEL&>"/>!CANCEL!>
   </td>
   <td align="<&SUBMIT_ALIGN&>" colspan=1>
      <!<input class="<&BUTTONCLASS&>" type="submit" value="<&SUBMIT&>" name="<&FORMNAME&>" <&SUBMIT_EXTRA&>/>!SUBMIT!>
   </td>
</tr>
</table>
</div>
<~<&HIDDEN&>~HIDDEN~>
</form>';

  $templ{subheading_row} = '
 <tr><~
<&TEMPL&>~TEMPL~>
</tr>';

  $templ{data_row} = '
 <tr class="<&DATACLASS&>" ><~
<&TEMPL&>~TEMPL~>
</tr>';

  $templ{text} = '<td align="<&ALIGN&>" <!colspan="<&COLSPAN&>"!COLSPAN!>><input type="text" value="<&#value&>" name="<&NAME&>" maxlength="<&MAXLEN&>" size="<&SIZE&>" <&#readonly&> />';


  $templ{print} = '<td align="<&ALIGN&>" <!colspan="<&COLSPAN&>"!COLSPAN!>><&VALUE&></td>';

  $templ{select} = '<td align="<&ALIGN&>" <!colspan="<&COLSPAN&>"!COLSPAN!>><select size="<&SIZE&>" name="<&NAME&>"><&_option&></select></td>';
  
  $templ{_option} = '<~
<option value="<&OPT_VAL&>" <&#checked selected&>><&OPTION&></option> ~OPTION OPT_VAL~>';

  $templ{check} = '<td align="<&ALIGN&>" <!colspan="<&COLSPAN&>"!COLSPAN!>><&OPTION&><input type="checkbox" value="<&OPT_VAL&>" name="<&NAME&>" <&#checked&> /></td>';

  $templ{radio} = '<td align="<&ALIGN&>" <!colspan="<&COLSPAN&>"!COLSPAN!>><&OPTION&><input type="radio" value="<&OPT_VAL&>" name="<&NAME&>" <&checked&> /></td>';

  $templ{comment} = '
<tr class="<&TITLECLASS&>" >
  <th colspan="<&COLUMNS&>" valign="top"><&TITLE&></th>
</tr>
<tr>
  <td colspan="<&COLUMNS&>"><textarea name="<&NAME&>" cols="<&COLS&>" rows="<&ROWS&>"><&value&></textarea></td>
</tr>
'; 

  $templ{errormsg} = '
<tr>
 <td colspan="<&COLUMNS&>" class="<&ERRORCLASS&>" valign="middle"><&error&></td>
</tr>
';

  $templ{_hidden} = '
<input type="hidden" name="<&NAME&>" value="<&#value&>" />';
  $templ{hidden} = '<&_hidden&>';
  $templ{_templ} = '<~<&TEMPL&>~TEMPL~>';
  

  my %error_handler;
  $error_handler{'_check'} = '#error_check';

  return \%templ;

}

#------------------------------------------------------------------------

=item PRIVATE HashRef _init_default();

Returns default values for this skin. Do not call this method directly.

=cut
#------------------------------------------------------------------------
sub _init_default {
  my %default = %{WebGB::FormEngine::Skin::_init_default()};
  $default{main}{TITLECLASS} = 'list_label';
  $default{main}{DATACLASS} = 'odd';
  $default{main}{ERRORCLASS} = 'lite_error';
  $default{main}{BUTTONCLASS} = 'button';
  $default{main}{SUBTITLECLASS} = 'lite_subtitle';
  $default{subheading_row}{TITLECLASS} = 'lite subheading';
  $default{subheading_row}{DATACLASS} = 'lite subheading';
  $default{data_row}{ALIGN} = 'left';
  $default{_column} = {};
  return \%default;
}

#------------------------------------------------------------------------

=item PRIVATE HashRef _init_confirm_skin();

Returns default values for this skin. Do not call this method directly.

=cut
#------------------------------------------------------------------------
  sub _init_confirm_skin {
    return;
  }

  WebGB::FormEngine::SkinTable->_init();

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
