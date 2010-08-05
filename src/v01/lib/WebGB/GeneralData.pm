#============================================================================
#
# WebGB::GeneralData.pm
#
# The configuration content loader for the WebGBrowse utility. Provides a 
# gbrowse general configuration template with the values either from the 
# available value set or derived from a web form stored into YAML files which 
# can be used later to generate web forms or final configuration file. 
#
# Written by Ram Podicheti <mnrusimh@indiana.edu>
#
# $ID: GeneralData.pm,v 0.01 2008/11/25 00:14:53 cgb Exp $
#
#============================================================================

package WebGB::GeneralData;

use WebGB::Exceptions;
use YAML;
use 5.008;
use strict;
use warnings;

our $VERSION = '0.01';
our @ISA = ();

#------------------------------------------------------------------------
# new($generalSettingsFile)
#
# Module constructor. It creates a data structure - @generalSettings from 
# the input argument $generalSettingsFile. This array represents the 
# general configuration template.
#
# Returns a reference to a newly created WebGB::ConfData object.
#------------------------------------------------------------------------

sub new {
	my ($class, $generalSettingsFile) = @_;
	my @generalSettings = YAML::LoadFile($generalSettingsFile);
	
	my $self = {
		'GENERAL' => \@generalSettings
	};
	bless $self, $class;
	return $self;
}


#------------------------------------------------------------------------
# saveGeneralSettingsToFile($generalSettingsFile)
#
# This method serializes the general configuration settings to a YAML 
# file under the name supplied as the parameter $generalSettingsFile. 
#
# Returns 1 if the file is created.
#------------------------------------------------------------------------

sub saveGeneralSettingsToFile {
	my ($self, $generalSettingsFile) = @_;
	open OUTPUT, ">", $generalSettingsFile;
        print OUTPUT YAML::Dump(@{$self->{'GENERAL'}});
	close OUTPUT;
	return 1;
}


#------------------------------------------------------------------------
# setDescription($description)
#
# This method updates the value of the description element in the 
# general configuration.
#
# Returns 1 if the update is successful.
#------------------------------------------------------------------------

sub setDescription {
	my ($self, $description) = @_; 
	${${${${$self->{'GENERAL'}}[0]}{'sub'}}[0]}{'VALUE'} = $description;
	return 1; 
}


#------------------------------------------------------------------------ 
# getDescription 
# 
# This method returns the value of the description element from the 
# general configuration. 
#------------------------------------------------------------------------

sub getDescription { 
	my $self = shift; 
	return ${${${${$self->{'GENERAL'}}[0]}{'sub'}}[0]}{'VALUE'};
}


#------------------------------------------------------------------------
# addFastaDumper
#
# This method adds the FastaDumper plugin to the general settings
#------------------------------------------------------------------------

sub addFastaDumper {
	my $self = shift;
	${${${${$self->{'GENERAL'}}[0]}{'sub'}}[2]}{'VALUE'} = "GFFDumper\n\tFastaDumper";
}


1;
