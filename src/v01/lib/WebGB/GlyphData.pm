#============================================================================
#
# WebGB::GlyphData.pm
#
# The glyph schema loader for the WebGBrowse utility loads the schema 
# specific to all the available glyphs. It presents a hashref of 
# HTML::FormEngine compatible hashrefs for each of the individual glyphs. It 
# also offers a list of glyphs available.
#
# Written by Ram Podicheti <mnrusimh@indiana.edu>
#
# Copyright (C) 2008 Ram Podicheti. All Rights Reserved.
# Copyright (C) 2008 Indiana University.
#
# $ID: GlyphData.pm,v 0.01 2008/11/30 03:55:40 cgb Exp $
#
#============================================================================

package WebGB::GlyphData;

use YAML;
use 5.008;
use strict;
use warnings;

our $VERSION = '0.01';
our @ISA = ();

#------------------------------------------------------------------------
# new($glyphLibraryFile)
#
# Module constructor. It creates a data structure %glyphLibrary based on 
# the $glyphLibraryFile which is accepted as an argument. It also 
# populates an array @glyphs with the list of names of all available 
# glyphs.
#
# Returns a reference to a newly created WebGB::GlyphData object.
#------------------------------------------------------------------------

sub new {
	my ($class, $glyphLibraryFile) = @_;
	my %glyphLibrary = YAML::LoadFile($glyphLibraryFile);
	my @glyphs = sort keys %glyphLibrary;
	my $self = {
		'GLYPH_LIBRARY' => \%glyphLibrary,
		'GLYPH_LIST' => \@glyphs
	};
	bless $self, $class;
	return $self;
}


#------------------------------------------------------------------------
# getGlyphList
#
# This method returns an array of the glyph names obtained from glyph 
# library.
#------------------------------------------------------------------------

sub getGlyphList {
	my $self = shift;
	return @{$self->{'GLYPH_LIST'}};
}


#------------------------------------------------------------------------
# getGlyphLibrary
#
# This method returns a hash loaded with the glyph library.
#------------------------------------------------------------------------

sub getGlyphLibrary {
	my $self = shift;
	return %{$self->{'GLYPH_LIBRARY'}};
}


1;
