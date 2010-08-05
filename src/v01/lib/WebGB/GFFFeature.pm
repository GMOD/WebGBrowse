#============================================================================
#
# WebGB::GFFFeature.pm
#
# The individual GFF Feature Parser for the WebGBrowse utility. Loads the GFF 
# Feature object from an individual GFF line, validates each column and 
# presents the properties of the GFF Feature.
#
# Written by Ram Podicheti <mnrusimh@indiana.edu>
#
# $ID: GFFFeature.pm,v 0.01 2008/11/19 07:19:28 cgb Exp $
#
#============================================================================

package WebGB::GFFFeature;

use WebGB::Exceptions;
use 5.008;
use strict;
use warnings;

our $VERSION = '0.01';
our @ISA = ();

#------------------------------------------------------------------------
# new($gffLine, $lineNum, $gffInputFile)
#
# Module constructor. All the three parameters are mandatory. The GFF 
# line will be parsed and each of the individual fields will be 
# validated. The feature object also presents the properties associated 
# with the feature, such as the Id, Parent etc. The Line Number and the 
# GFF Input File provide additional information for the GFF line.
#
# Returns a reference to a newly created WebGB::GFFFeature object.
#------------------------------------------------------------------------

sub new {
	my ($class, $gffLine, $lineNum, $gffInputFile) = @_;
	my @columns = split /\s*\t\s*/, $gffLine;
	WebGB::Exceptions::WebGBException::GFFDataException::InvalidGFFLineException->throw(
		'error' => "Invalid GFF line encountered at line $lineNum in the input GFF3 file",
		'LineNum' => $lineNum,
		'DataFile' => $gffInputFile
	) unless @columns >= 8;         # GFF format
	my ($refName, $source, $method, $start, $end, $score, $strand, $phase, $attributes) = @columns;
	my $self = {
		'LINE_NUM' => $lineNum,
		'GFF_INPUT_FILE' => $gffInputFile,
		'REF_NAME' => $refName,
		'SOURCE' => $source,
		'METHOD' => $method,
		'START' => $start,
		'END' => $end,
		'SCORE' => $score,
		'STRAND' => $strand,
		'PHASE' => $phase,
		'ATTRIBUTES' => $attributes,
		'VALID_REF_NAME' => 0,
		'VALID_SOURCE' => 0,
		'VALID_METHOD' => 0,
		'VALID_COORDS' => 0,
		'VALID_SCORE' => 0,
		'VALID_STRAND' => 0,
		'VALID_PHASE' => 0,
		'VALID_ATTRIBUTES' => 0,
		'ID' => '',
		'HAS_PARENT' => 0,
		'PARENT' => '',
		'MSG_BOARD' => []
	};
	bless $self, $class;
	$self->{'VALID_REF_NAME'} = $self->_isValidRefName();
	$self->{'VALID_SOURCE'} = $self->_isValidSource();
	$self->{'VALID_METHOD'} = $self->_isValidMethod();
	$self->{'VALID_COORDS'} = $self->_isValidCoords();
	$self->{'VALID_SCORE'} = $self->_isValidScore();
	$self->{'VALID_STRAND'} = $self->_isValidStrand();
	$self->{'VALID_PHASE'} = $self->_isValidPhase();
	$self->{'VALID_ATTRIBUTES'} = $self->_isValidAttributes();
	return $self;
}


#------------------------------------------------------------------------
# _isValidRefName()
#
# Internal subroutine to verify whether the Reference Name (Column1) in 
# the GFF line is valid. The checks performed are:
# 	1. Reference Name should not be empty
# 	2. It can not be a .
# 	3. Characters outside the set [a-zA-Z0-9.:^*$@!+_?-|] should be 
# 		escaped (URL Encoding Method)
#
# Returns 1 if the reference name is valid, else returns 0 after 
# populating the "Message Board".
#------------------------------------------------------------------------

sub _isValidRefName {
	my $self = shift;
	my $refName = $self->{'REF_NAME'};
	my $returnValue = 0;
	if (defined $refName) {
		$returnValue = 1 unless (($refName eq '') || ($refName eq '.') || ($refName =~ /[^a-zA-Z0-9.:^*$@!+_?-|]/));
		$returnValue = 1 unless ($refName =~ /%.?[^\da-f]{1}/i);
	}
	return $returnValue;
}


#------------------------------------------------------------------------
# _isValidSource()
#
# Internal subroutine to verify whether the Source (Column2) in the GFF 
# line is valid. The checks performed are:
# 	1. Source should not be empty
#
# Returns 1 if the source is valid, else returns 0 after populating the 
# "Message Board".
#------------------------------------------------------------------------

sub _isValidSource {
	my $self = shift;
	my $source = $self->{'SOURCE'};
	my $returnValue = 0;
	if (defined $source) {
		$returnValue = 1 unless ($source eq '');
	}
	return $returnValue;
}


#------------------------------------------------------------------------
# _isValidMethod()
#
# Internal subroutine to verify whether the Method (Column3) in the GFF 
# line is valid. The checks performed are:
# 	1. Method should not be empty
# 	2. It can not be a .
#
# Returns 1 if the method is valid, else returns 0 after populating the 
# "Message Board".
#------------------------------------------------------------------------

sub _isValidMethod {
	my $self = shift;
	my $method =  $self->{'METHOD'};
        my $returnValue = 0;
        if (defined $method) {
		$returnValue = 1 unless (($method eq '') || ($method eq '.'));
	}
	return 1;
}


#------------------------------------------------------------------------
# _isValidCoords()
#
# Internal subroutine to verify whether the Start (Column4) and End 
# (Column5) in the GFF line is valid. The checks performed are:
# 	1. Start and End should not be empty
# 	2. They should be positive integers
# 	3. Start <= End
#
# Returns 1 if the start and end are valid, else returns 0 after 
# populating the "Message Board".
#------------------------------------------------------------------------

sub _isValidCoords {
	my $self = shift;
	my $start = $self->{'START'};
	my $end = $self->{'END'};
	my $returnValue = 0;
	if ((defined $start) && (defined $end)) {
		$returnValue = 1 if ((($start =~ /^\d+$/) && ($end =~ /^\d+$/)) and ($start <= $end));
	}
	return $returnValue;
}


#------------------------------------------------------------------------
# _isValidScore()
#
# Internal subroutine to verify whether the Score (Column6) in the GFF 
# line is valid. The checks performed are:
# 	1. Score should not be empty
# 	2. It should be a numeric value (positive or negative float) 
# 	3. It can be a .
#
# Returns 1 if the score is valid, else returns 0 after populating the 
# "Message Board".
#------------------------------------------------------------------------

sub _isValidScore {
	my $self = shift;
	my $score = $self->{'SCORE'};
	my $returnValue = 0;
	if (defined $score) {
		$returnValue = 1 if ($score =~ /^(\d+\.?\d*|\.\d+|\.)$/);
	}
	return $returnValue;
}


#------------------------------------------------------------------------
# _isValidStrand()
#
# Internal subroutine to verify whether the Strand (Column7) in the GFF 
# line is valid. The checks performed are:
# 	1. Strand should not be empty
# 	2. It should be one character in length
# 	3. It can have any of the following values [+-?.]
#
# Returns 1 if the strand is valid, else returns 0 after populating the 
# "Message Board".
#------------------------------------------------------------------------

sub _isValidStrand {
	my $self = shift;
	my $strand = $self->{'STRAND'};
	my $returnValue = 0;
	if (defined $strand) {
		$returnValue = 1 if ($strand =~ /^[+-?.]$/);
	}
	return $returnValue;
}


#------------------------------------------------------------------------
# _isValidPhase()
#
# Internal subroutine to verify whether the Phase (Column8) in the GFF 
# line is valid. The checks performed are:
# 	1. Phase should not be empty
# 	2. It should be a number
# 	3. It can have the values 0, 1 or 2
# 	4. If not a number, it should be a .
#
# Returns 1 if the phase is valid, else returns 0 after populating the 
# "Message Board".
#------------------------------------------------------------------------

sub _isValidPhase {
	my $self = shift;
	my $phase = $self->{'PHASE'};
	my $returnValue = 0;
	if (defined $phase) {
		$returnValue = 1 if ($phase =~ /^[012.]$/);
	}
	return $returnValue;
}


#------------------------------------------------------------------------
# _isValidAttributes()
#
# Internal subroutine to verify whether the Attributes (Column9) in 
# the GFF line is valid. The checks performed are:
# 	1. Attributes should not be empty
# 	2. They should be <key>=<value> pairs separated by ;
# 	3. Key should be unique for a row
# 	4. Keys with multiple values should be separated with a ,
# 	5. Values can be a single word (without a space) or multiple 
# 		words (with spaces) or <item>:<term> pairs.
#
# Sets the ID and verifies if the feature has a Parent and returns 1 if 
# the reference name is valid, else returns 0 after populating the 
# "Message Board".
#------------------------------------------------------------------------

sub _isValidAttributes {
	my $self = shift;
	my $attributes = $self->{'ATTRIBUTES'};
	my $returnValue = 0;
	my $tagNameUndefined = 0;
	my $tagValueUndefined = 0;
	if (defined $attributes) {
		my @attributePairs = map { 
			my ($name,$value) = split '=';
			[$self->_unescape($name) => $value];
		} split ';', $attributes;
		foreach (@attributePairs) {
			my $tagName = $_->[0];
			my $tagValue = $_->[1];
			if ($tagName eq '') {
				$tagNameUndefined = 1;
				last;
			}
			unless (defined $tagValue) {
				$tagValueUndefined = 1;
				last;
			}
			if ($tagName eq 'ID') {
				$self->{'ID'} = $tagValue;
			}
			if ($tagName eq 'Parent') {
				$self->{'HAS_PARENT'} = 1;
				$self->{'PARENT'} = $tagValue;
			}
		}
		($tagNameUndefined == 0 and $tagValueUndefined == 0) and $returnValue = 1;
	}
	return $returnValue;
}


#------------------------------------------------------------------------
# sub _unescape($todecode)
#
# Internal subroutine to decode any escaped characters in the attribute 
# names or values. The GFF specifications indicate that any cahracter 
# from a given set of special characters should be escaped using a '%' 
# symbol followed by the hexadecimal notation of the ASCII value of that 
# character. The procedure has been directly obtained from the 'unescape'
# subroutine of Bio::DB::SeqFeature::Store::Loader module (lstein).
#------------------------------------------------------------------------

sub _unescape {
	my $self = shift; 
	my $todecode = shift; 
	$todecode =~ s/%([0-9a-fA-F]{2})/chr hex($1)/ge;
	return $todecode;
}

sub isValid {
	my $self = shift;
	my $returnValue = 0;
	$returnValue = ($self->{'VALID_REF_NAME'} and $self->{'VALID_SOURCE'} and $self->{'VALID_METHOD'} and $self->{'VALID_COORDS'} and $self->{'VALID_SCORE'} and $self->{'VALID_STRAND'} and $self->{'VALID_PHASE'} and $self->{'VALID_ATTRIBUTES'});
	return $returnValue;
}
1;
