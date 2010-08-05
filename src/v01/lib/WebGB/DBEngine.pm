#============================================================================
#
# WebGB::DBEngine.pm
#
# The Database Engine for the WebGBrowse utility. It allows connectivity to 
# WebGB database and provides functionality to insert data into 
# WebGB_DataSets. It also provides access to the data in the WebGB_DataSet 
# based on the EMail.
#
# Schema Definition:
#
# CREATE TABLE WebGB_DataSets ( 
# 	ID INT NOT NULL AUTO_INCREMENT, 
# 	EMail CHAR(32) NOT NULL, 
# 	Created TIMESTAMP DEFAULT NOW(), 
# 	TSD CHAR(32) NOT NULL, 
# 	Description TEXT NOT NULL, 
# 	PRIMARY KEY (ID) 
# );
#
# Written by Ram Podicheti <mnrusimh@indiana.edu>
#
# Copyright (C) 2008 Ram Podicheti. All Rights Reserved.
# Copyright (C) 2008 Indiana University.
#
# $ID: DBEngine.pm,v 0.01 2008/12/26 01:37:52 cgb Exp $
#
#============================================================================

package WebGB::DBEngine;
use DBI;
use 5.008;
use strict;
use warnings;
require Exporter;
our @ISA = qw(Exporter);
#our %EXPORT_TAGS = ('all' => [qw()]);
#our @EXPORT_OK = (@{$EXPORT_TAGS{'all'}});
our @EXPORT = qw(webGBConnect addDataSet getHistory);
our $VERSION = '0.01';

#------------------------------------------------------------------------
# webGBConnect()
#
# Connects to tbe WebGB Database and returns a reference to the 
# established connection object.
#------------------------------------------------------------------------

sub webGBConnect {
	my $dbh = DBI->connect('DBI:mysql:WebGB', 'user', 'password');
	return $dbh;
}


#------------------------------------------------------------------------
# _escapeValues($value)
# 
# Internal function to process the string values before handing them to 
# the MySQL database in order to escape certain characters so that they 
# will not violate the integrity of the data with respect to the SQL 
# syntax.
#------------------------------------------------------------------------

sub _escapeValues {
	my $value = shift;
	my $escapedValue = $value;
	$escapedValue =~ s/\\/\\\\/g;
	$escapedValue =~ s/\'/\\\'/g;	
	$escapedValue =~ s/\"/\\\"/g;	
	$escapedValue =~ s/%/\\\%/g;	
	$escapedValue =~ s/_/\\\_/g;
	return $escapedValue;
}


#------------------------------------------------------------------------
# addDataSet($email, $tsd, $description)
#
# This method inserts a new dataset entry into the database.
#
# Returns ID if the update is successful, else 0.
#------------------------------------------------------------------------

sub addDataSet{
	my ($email, $tsd, $description, $dbh) = @_;
	$email = _escapeValues($email);
	$tsd = _escapeValues($tsd);
	$description = _escapeValues($description);
	my $sqlInsertDataSet = "INSERT INTO WebGB_DataSets (EMail, TSD, Description) VALUES ('$email', '$tsd', '$description')";
	$dbh->do($sqlInsertDataSet);
	my $sqlSelectMaxID = "SELECT MAX(ID) FROM WebGB_DataSets";
	my $stmtMaxID = $dbh->prepare($sqlSelectMaxID);
	$stmtMaxID->execute;
	my @resultsMaxID = $stmtMaxID->fetchrow_array;
	return $resultsMaxID[0];
}


#------------------------------------------------------------------------
# getHistory($email)
#
# This method returns an array of the previously updated datasets for a 
# given email address
#------------------------------------------------------------------------

sub getHistory {
	my ($email, $dbh) = @_;
	$email = _escapeValues($email);
	my $sqlSelectDataSets = "SELECT TSD, Description, DATE_FORMAT(Created, '%m-%d-%Y %h:%i:%s %p') FROM WebGB_DataSets WHERE EMail = '$email' ORDER BY Created";
	my $stmtDataSets = $dbh->prepare($sqlSelectDataSets);
	$stmtDataSets->execute;
	my @resultsDataSets = ();
	while (my @row = $stmtDataSets->fetchrow_array) {
		push(@resultsDataSets, \@row);
	}
	return @resultsDataSets;
}


1;
