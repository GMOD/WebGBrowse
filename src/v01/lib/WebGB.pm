#============================================================================
#
# WebGB.pm
#
# The root class for WebGBrowse utility which provides the site specific 
# information which includes stylesheets, templates and globals. 
#
# Written by Ram Podicheti <mnrusimh@indiana.edu>
#
# $ID: WebGB.pm,v 0.01 2008/11/26 03:40:26 cgb Exp $
#
#============================================================================

package WebGB;
use 5.008;
use strict;
use warnings;
require Exporter;
our @ISA = qw(Exporter);
#our %EXPORT_TAGS = ('all' => [qw()]);
#our @EXPORT_OK = (@{$EXPORT_TAGS{'all'}});
our @EXPORT = qw(getStartHtml getContent logError isValidEMail);
our $VERSION = '0.02';


# Server Settings
our @GBR_VER = ("1.70", "2.0");
our $TMP = 'WebGBrowse/src/v01/tmp';
our $YAML_LIB = 'WebGBrowse/src/v01/files/yamlib';
our $SEND_MAIL = '/usr/sbin/sendmail';
our $CONF = 'WebGBrowse/src/v01/conf';
our $WWW = 'WebGBrowse/src/v01/www';
our $WWW2 = 'WebGBrowse/src/v02/www';
our $CONF2 = 'WebGBrowse/src/v02/gbrowse2';

#------------------------------------------------------------------------
# getStartHtml($q, $excludeHeader)
#
# Returns the standard output for $q->start_html() where $q is the CGI 
# object. Unless $excludeHeader is provided, the output also includes 
# $q->header('text/html');
#------------------------------------------------------------------------

sub getStartHtml {
	my ($q, $excludeHeader) = @_;
	my $returnValue = '';
	$returnValue .= $q->header('text/html') unless ($excludeHeader);
	$returnValue .= $q->start_html(
		'-title' => 'WebGBrowse',
		'-author' => 'mnrusimh',
		'-style' => [
			{
				'src' => '/include/css/site.css'
			},
			{
				'src' => '/include/css/webgb_form.css'
			}
		],
		'-script' => [
			{ 
				'-language' => 'Javascript', 
				'-src' => '/include/js/jquery.js', 
				'-type' => 'text/javascript' 
			},
			{
				'-language' => 'Javascript',
				'-src' => '/include/js/webgb_form.js',
				'-type' => 'text/javascript'
			}
		]
	);
	return $returnValue;
}


#------------------------------------------------------------------------
# getContent($core)
# 
# Returns the page content substituting the core of the page content with
# $core. The page content includes the banner, the top menu the central 
# core and the footer.
#------------------------------------------------------------------------

sub getContent {
	my ($core) = @_;
	my $content = qq(
		        <div id="container">
                <div id="header">
                        <img src="/include/img/webgbrowse.jpg" alt="The Center for Genomics and Bioinformatics - WebGBrowse" />
                </div>
                <div class="navbar">
                        <ul id="topnav">
                                <li><a href="/index.html">Home</a></li>
                                <li><a href="/about.html">About</a></li>
                                <li><a href="/tutorial.html">Tutorial</a></li>
                                <li><a href="/glyphdoc.html">Glyph Library</a></li>
                                <li><a href="/faq.html">FAQ</a></li>
                                <li><a href="/software.html">Software</a></li>
                                <li><a href="/support.html">Support</a></li>
                        </ul>
                </div>
                <div id="wrapper">
                        <div>
                                <!--WebGB:core-->
                                <div class="footer">
                                <p>
                                        <a href="http://www.indiana.edu">
                                                <img src= "/include/img/blockiu_white.gif" alt="IU" name= "iub_image" width="22" height="28" hspace="0" vspace="0" border="0" id="iub_image" longdesc= "http://www.indiana.edu" />
                                        </a>
                                        <a href= "http://www.indiana.edu/comments/copyright.shtml" title="Copyright">
                                                Copyright
                                        </a>
                                        &copy; The Trustees of
                                        <a href="http://www.indiana.edu/" title= "Indiana University">
                                                Indiana University
                                        </a>
                                        |
                                        <a href= "http://www.indiana.edu/comments/complaint.shtml" title="Copyright  Complaints">
                                                Copyright Complaints
                                        </a>
                                </p>
                        </div>
                </div>
        </div> 
	);
	$content =~ s/<!--WebGB:core-->/$core/g;
	return $content;
}


#------------------------------------------------------------------------
# isValidEMail($emailAddress)
#
# Validates a given email address for its format. Returns 1 if valid, if 
# not returns 0.
#------------------------------------------------------------------------

sub isValidEMail { 
	my $addr = shift;
	my $atext = qr/[A-Za-z0-9\!\#\$\%\&\'\*\+\-\/\=\?\^\_\`\{\|\+\~]/;
	my $dot_atom_text = qr/$atext+(\.$atext+)*/;

	my $no_ws_ctl_char = qr/[\x01-\x08\x0b\x0c\x0e-\x1f\x7f]/;
	my $qtext_char = qr/([\x21\x23-\x5b\x5d-\x7e]|$no_ws_ctl_char)/;
	my $text = qr/[\x01-\x09\x0b\x0c\x0e-\x7f]/;
	my $qtext = qr/($qtext_char|\\$text)*/;
	my $quoted_string = qr/"$qtext"/;

	my $quotedpair = qr/\\$text/;
	my $dtext = qr/[\x21-\x5a\x5e-\x7e\x01-\x08\x0b\x0c\x0e-\x1f\x7f]/;
	my $dcontent = qr/($dtext|$quotedpair)/;        
	my $domain_literal = qr/\[(${dcontent})*\]/;

	if ( $addr =~ /^($dot_atom_text|$quoted_string)\@($dot_atom_text|$domain_literal)$/ ) { 
		return 1;
	} else {
		return 0;
	}
}

sub logError {
	my ($q, $msg, $status) = @_;
	return $q->redirect("/cgi-bin/errorpage?status=$status&msg=$msg");
}


1;
