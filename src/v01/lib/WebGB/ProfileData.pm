#============================================================================
#
# WebGB::ProfileData.pm
#
# The input profile content loader for the WebGBrowse utility. Provides a 
# YAML based input profile template to record the elements of input such as 
# the uploaded GFFFileName, DBEntryStatus of the current dataset, 
# EMailAddress of the user and the SeqID of the current dataset. 
#
# Written by Ram Podicheti <mnrusimh@indiana.edu>
#
# $ID: ConfData.pm,v 0.01 2008/12/10 20:11:40 cgb Exp $
#
#============================================================================

package WebGB::ProfileData;

use YAML;
use 5.008;
use strict;
use warnings;

our $VERSION = '0.02';
our @ISA = ();

#------------------------------------------------------------------------
# new($inputProfileFile)
#
# Module constructor. It accepts the name of the input profile file as an
# argument and loads the associated data structure defining the current 
# input profile.
#
# Returns a reference to a newly created WebGB::ProfileData object.
#------------------------------------------------------------------------

sub new {
	my ($class, $inputProfileFile) = @_;
	my %inputProfile = YAML::LoadFile($inputProfileFile);
	
	my $self = {
		'PROFILE' => \%inputProfile
	};
	bless $self, $class;
	return $self;
}


#------------------------------------------------------------------------
# setEMailAddress($emailAddress)
#
# This method updates the email address element in the input profile data
# structure.
#
# Returns 1 if the update is successful.
#------------------------------------------------------------------------

sub setEMailAddress {
	my ($self, $emailAddress) = @_;
	${$self->{'PROFILE'}}{'EMailAddress'} = $emailAddress;
	return 1;
}


#------------------------------------------------------------------------
# getEMailAddress
#
# This method returns the value of the email address element from the 
# input profile data structure.
#------------------------------------------------------------------------

sub getEMailAddress {
	my $self = shift;
	return ${$self->{'PROFILE'}}{'EMailAddress'};
}


#------------------------------------------------------------------------
# setDBEntryStatus($dbEntryStatus)
#
# This method updates the DBEntryStatus element in the input profile data
# structure.
#
# Returns 1 if the update is successful.
#------------------------------------------------------------------------

sub setDBEntryStatus {
	my ($self, $dbEntryStatus) = @_;
	${$self->{'PROFILE'}}{'DBEntryStatus'} = $dbEntryStatus;
	return 1;
}


#------------------------------------------------------------------------
# getDBEntryStatus
#
# This method returns the value of the DBEntryStatus element from the 
# input profile data structure.
#------------------------------------------------------------------------

sub getDBEntryStatus {
	my $self = shift;
	return ${$self->{'PROFILE'}}{'DBEntryStatus'};
}


#------------------------------------------------------------------------
# setGB2Status($gb2Status)
#
# This method updates the GB2Status element in the input profile data
# structure.
#
# Returns 1 if the update is successful.
#------------------------------------------------------------------------

sub setGB2Status {
	my ($self, $gb2Status) = @_;
	${$self->{'PROFILE'}}{'GB2Status'} = $gb2Status;
	return 1;
}


#------------------------------------------------------------------------
# getGB2Status
#
# This method returns the value of the GB2Status element from the 
# input profile data structure.
#------------------------------------------------------------------------

sub getGB2Status {
	my $self = shift;
	return ${$self->{'PROFILE'}}{'GB2Status'};
}



#------------------------------------------------------------------------
# setGFFFileName($gffFileName)
#
# This method updates the GFF File Name element in the input profile data
# structure.
#
# Returns 1 if the update is successful.
#------------------------------------------------------------------------

sub setGFFFileName {
	my ($self, $gffFileName) = @_;
	${$self->{'PROFILE'}}{'GFFFileName'} = $gffFileName;
	return 1;
}


#------------------------------------------------------------------------
# getGFFFileName
#
# This method returns the value of the GFF File Name element from the 
# input profile data structure.
#------------------------------------------------------------------------

sub getGFFFileName {
	my $self = shift;
	return ${$self->{'PROFILE'}}{'GFFFileName'};
}


#------------------------------------------------------------------------
# setSeqID($seqID)
#
# This method updates the sequence ID element in the input profile data
# structure.
#
# Returns 1 if the update is successful.
#------------------------------------------------------------------------

sub setSeqID {
	my ($self, $seqID) = @_;
	${$self->{'PROFILE'}}{'SeqID'} = $seqID;
	return 1;
}


#------------------------------------------------------------------------
# getSeqID
#
# This method returns the value of the sequence ID element from the input 
# profile data structure.
#------------------------------------------------------------------------

sub getSeqID {
	my $self = shift;
	return ${$self->{'PROFILE'}}{'SeqID'};
}


#------------------------------------------------------------------------
# saveInputProfileToFile($inputProfileFile)
#
# This method serializes the input profile settings to a YAML file under 
# the name supplied as the parameter $inputProfileFile. 
#
# Returns 1 if the file is created.
#------------------------------------------------------------------------

sub saveInputProfileToFile {
	my ($self, $inputProfileFile) = @_;
	open OUTPUT, ">", $inputProfileFile;
        print OUTPUT YAML::Dump(%{$self->{'PROFILE'}});
	close OUTPUT;
	return 1;
}


1;
