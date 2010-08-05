#============================================================================
#
# WebGB::Exceptions.pm
#
# The Exception library for WebGBrowse Application
#
# Written by Ram Podicheti <mnrusimh@indiana.edu>
#
# Copyright (C) 2008 Ram Podicheti. All Rights Reserved.
# Copyright (C) 2008 Indiana University.
#
# $ID: Exceptions.pm,v 0.01 2008/11/18 03:17:55 cgb Exp $
#
#============================================================================

package WebGB::Exceptions;
use 5.008;
use strict;
use warnings;
use Exception::Class (
	'WebGB::Exceptions::WebGBException' => {
		'description' => 'Generic WebGBrowse Exception'
	},
	'WebGB::Exceptions::WebGBException::GFFDataException' => {
		'isa' => 'WebGB::Exceptions::WebGBException',
		'description' => 'WebGBrowse Exception from WebGB::GFFData'
	},
	'WebGB::Exceptions::WebGBException::GFFDataException::InvalidParameterException' => {
		'isa' => 'WebGB::Exceptions::WebGBException::GFFDataException',
		'description' => 'GFFData Exception thrown when a WebGB::GFFData object is attempted with invalid input or output parameters',
		'fields' => ['ParamMode', 'ParamValue']
	},
	'WebGB::Exceptions::WebGBException::GFFDataException::InvalidGFFLineException' => {
		'isa' => 'WebGB::Exceptions::WebGBException::GFFDataException',
		'description' => 'GFFData Exception thrown when the GFF data is not in GFF3 format',
		'fields' => ['LineNum', 'DataFile']
	},
	'WebGB::Exceptions::WebGBException::ConfigException' => {
		'isa' => 'WebGB::Exceptions::WebGBException',
		'description' => 'WebGBrowse Exception from WebGB::Config2TrackData'
	},
	'WebGB::Exceptions::WebGBException::ConfigException::InvalidParameterException' => {
		'isa' => 'WebGB::Exceptions::WebGBException::ConfigException',
		'description' => 'Config Exception thrown when a WebGB::Config2TrackData object is attempted with invalid configFile input parameter',
		'fields' => ['ParamValue']
	},
	'WebGB::Exceptions::WebGBException::ConfigException::InvalidTrackLineException' => {
		'isa' => 'WebGB::Exceptions::WebGBException::ConfigException',
		'description' => 'Config Exception thrown when a WebGB::Config2TrackData object is attempted with a config file containing ill formed track information'
	}
);

1;
