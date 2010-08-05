#============================================================================
#
# WebGB::GFFData.pm
#
# The GFF Schema loader for the WebGBrowse utility. Loads the GFF Schema, 
# validates the contents and presents the list of available features for 
# future track configuration.
#
# Written by Ram Podicheti <mnrusimh@indiana.edu>
#
# Copyright (C) 2008 Ram Podicheti. All Rights Reserved.
# Copyright (C) 2008 Indiana University.
#
# $ID: GFFData.pm,v 0.01 2008/11/18 11:07:58 cgb Exp $
#
#============================================================================

package WebGB::GFFData;

use WebGB::Exceptions;
use WebGB::GFFFeature;
use YAML;
use 5.008;
use strict;
use warnings;

our $VERSION = '0.01';
our @ISA = ();

#------------------------------------------------------------------------
# new($gffInputFile, $featureOutputFile)
#
# Module constructor. Both the parameters are mandatory. The first is an 
# existing GFF3 file with the data to be displayed on GBrowse. The GFF 
# data will be validated against our subset of GFF specifications to 
# ensure it is compatible with WebGBrowse. During the process of 
# validation, the schema of the GFF data will be loaded into a data 
# structure. This data structure will be serialized in YAML format. The 
# second parameter provides the name to store this serialized YAML 
# content. This data will be used in future for individual track 
# configuration.
#
# Returns a reference to a newly created WebGB::GFFData object.
#------------------------------------------------------------------------

sub new {
	my ($class, $gffInputFile, $featureOutputFile) = @_;

	my $self = {
		'GFF_INPUT_FILE' => $gffInputFile,
		'FEATURE_OUTPUT_FILE' => $featureOutputFile,
		'IS_VERSION_SET' => 0,
		'FEATURE_LIST' => \[],
		'MSG_BOARD' => [],
		'SEQ_ID' => '',
		'SEQUENCE_AVBL' => 0
	};

	bless $self, $class;

	if ($self->_paramsOK()) {
		if ($self->_validate()) {
			$self->_recordFeatureList();
		}
	}
	return $self;
}


#------------------------------------------------------------------------
# _paramsOK()
#
# Internal subroutine to verify whether the supplied parameter values are 
# valid. The checks performed are:
# 	1. GFF INPUT FILE exists
# 	2. FEATURE OUTPUT FILE can be created
#
# Returns 1 if the values are valid, else returns 0 after throwing a 
# 'GFFDataException::InvalidParameterException'.
#------------------------------------------------------------------------

sub _paramsOK {
	my $self = shift;
	my ($gffInputFile, $featureOutputFile) = 
		@{$self}{qw(GFF_INPUT_FILE FEATURE_OUTPUT_FILE)};
	my $returnValue = 1;

	unless (-f $gffInputFile) {
		$returnValue = 0;
		WebGB::Exceptions::WebGBException::GFFDataException::InvalidParameterException->throw(
			'error' => "Could not locate $gffInputFile for input: $!",
			'ParamMode' => 'Input',
			'ParamValue' => $gffInputFile
		);
	}
	open OUTPUT, '>', $featureOutputFile or $returnValue = 0;
	close OUTPUT;
	unless ($returnValue) {
		 WebGB::Exceptions::WebGBException::GFFDataException::InvalidParameterException->throw(
			'error' => "Could not create $featureOutputFile for output: $!",
			'ParamMode' => 'Output',
			'ParamValue' => $featureOutputFile
		);
	}
	return $returnValue;
}


#------------------------------------------------------------------------
# _validate()
#
# Internal subroutine to validate the GFF Data read from GFF INPUT FILE. 
# It handles this by calling several other internal subroutines. If the 
# GFF Data is valid, it constructs a unique feature tree based on which 
# it prepares a feature list. This list will later be saved in YAML 
# format into the $featureOutputFile by the internal subroutine 
# _recordFeatureList. Besides the feature list, it also records the 
# Seq_ID for the GFF Data which will be later used in configuring the 
# initial landmark.
#
# Returns 1 if the GFF Data is valid, else returns 0
#------------------------------------------------------------------------

sub _validate {
	my $self = shift;
	my $gffInputFile = $self->{'GFF_INPUT_FILE'};
	my %featureTree = ();
	my @featureList = ();
	open DATA, "<", $gffInputFile or 
		WebGB::Exceptions::WebGBException::GFFDataException::InvalidParameterException->throw(
			'error' => "Could not locate $gffInputFile for input: $!",
			'ParamMode' => 'Input',
			'ParamValue' => $gffInputFile
		);
	my $mode = 'header';
	my $lineNum = 0;
	while (<DATA>) {
		$lineNum++;
		chomp;
		next if (/^\s*$/);      	# ignore the blank lines
		if ($mode eq 'header') {	# the lines are top headers
			if (/^\#\#gff-version\s+(\d+)/) {
				$self->{'IS_VERSION_SET'} = 1;
				unless ($1 == 3) { 
					push @{$self->{'MSG_BOARD'}}, 
					     "The version number specified for GFF data is $1. WebGBrowse is meant for GFF3 files.";
				}
			} else {
				$mode = 'gff' unless (/^\#/); 
						# if the line is neither a header 
						# nor a comment and is not blank, 
						# then gff data is coming
			}
			next if ($mode ne 'gff');
		}
		if (/^>\s*(\S+)/) { 		# sequence data is coming which is not our concern
			$self->_setSequenceAvbl(1);
			last;
		}
		next if (/^\#/); 		# the subsequent lines get executed only 
						# if the mode is gff and $_ is not a comment
		my $feature = WebGB::GFFFeature->new($_, $lineNum, $gffInputFile);
		if ($feature->isValid()) {
		#unless ($feature->{'HAS_PARENT'}) {
			$self->{'SEQ_ID'} = $feature->{'REF_NAME'} if ($self->{'SEQ_ID'} eq '');
			my $source = $feature->{'SOURCE'};
			my $method = $feature->{'METHOD'};
			$featureTree{$method} = [] unless (exists($featureTree{$method}));
			push @{$featureTree{$method}}, $source unless ((scalar grep(/^$source$/, @{$featureTree{$method}})) > 0); 
		#}
		}
	}
	foreach (sort(keys(%featureTree))) {
		my $methodInTree = $_;
		push @featureList, $methodInTree;
		if (scalar @{$featureTree{$methodInTree}} > 1) {
			foreach my $sourceInTree (@{$featureTree{$methodInTree}}) {
				push @featureList, $methodInTree . ':' . $sourceInTree;
			}
		}
	}
	$self->{'FEATURE_LIST'} = \@featureList;
	return 1;
}


#------------------------------------------------------------------------
# _recordFeatureList()
#
# Internal subroutine to save the featureList into the $featureOutputFile
# in YAML format.
#------------------------------------------------------------------------

sub _recordFeatureList {
	my $self = shift;
	my $featureOutputFile = $self->{'FEATURE_OUTPUT_FILE'};
	my @featureList = @{$self->{'FEATURE_LIST'}};
	my $featureListYAMLContent = YAML::Dump(@featureList);
	open OUTPUT, ">", $featureOutputFile;
	print OUTPUT $featureListYAMLContent;
	close OUTPUT;
	return 1;
}

#------------------------------------------------------------------------
# _setSequenceAvbl($flag)
#
# Internal subroutine to mark if the GFF file contains a fasta sequence
#------------------------------------------------------------------------

sub _setSequenceAvbl {
	my ($self, $flag) = @_;
	$self->{'SEQUENCE_AVBL'} = $flag;
	return 1;
}

#------------------------------------------------------------------------
# getSequenceAvbl()
#
# Returns a value indicating whether the GFF file contains a fasta sequence
#------------------------------------------------------------------------

sub getSequenceAvbl {
	my $self = shift; 
	return $self->{'SEQUENCE_AVBL'};
}

1;
