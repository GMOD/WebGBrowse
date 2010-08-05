#!/usr/bin/perl -w
use strict;
use warnings;
use YAML;

my @general = (
	{
		'templ' => 'fieldset',
		'TITLE' => 'General Section',
		'sub' => [
			{
                'NAME' => 'txtDescription',
				'TITLE' => 'Description',
				'SIZE' => '60',
				'MAXLEN' => '60',
				'REQUIRED' => '1',
				'LABEL' => 'txtDescription',
                'VALUE' => '',
				'ERROR' => [
					'not_null'
				],
				'HINT' => 'Description of the database',
				'TIP' => 'Description appears in the popup menu that allows users to select the data source and in the header of the page.'
        },
		{
			    'templ' => 'check',
				'NAME' => 'chkShowSources',
				'TITLE' => 'Show Sources',
				'LABEL' => 'chkShowSources',
				'OPTION' => 'Show Sources',
				'OPT_VAL' => '1',
                'VALUE' => '1',
				'ERROR' => [
					'not_null'
				],
				'HINT' => 'Show/Hide the data sources',
				'TIP' => 'Determines whether or not to show the popup menu displaying the available data sources.'
        },
		{
         	'class' => 'basic',
                'hasChildren' => 1,
                'hint' => 'Plugins are a way for third-party developers to add functionality to gbrowse without changing its core source code.',
                'id' => 'fldPlugins',
                'label' => 'Plugins'
                'name' => 'plugins',
                'required' => 0,
                'section' => 'General',
                'template' => 'fieldset',
                'toolTip' => 'List of plugins available',
                'value' => {
                        'AlignTwoSequences' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkAlignTwoSequences',
                                'label' => 'Align Two Sequences',
                                'name' => 'AlignTwoSequences',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'Aligner' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkAligner',
                                'label' => 'Aligner',
                                'name' => 'Aligner',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'AttributeHiliter' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkAttributeHiliter',
                                'label' => 'Attribute Hiliter',
                                'name' => 'AttributeHiliter',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'BatchDumper' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkBatchDumper',
                                'label' => 'Batch Dumper',
                                'name' => 'BatchDumper',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
			'Blat' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkBlat',
                                'label' => 'Blat',
                                'name' => 'Blat',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'CMapDumper' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkCMapDumper',
                                'label' => 'CMap Dumper',
                                'name' => 'CMapDumper',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'CreateBlastDB' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkCreateBlastDB',
                                'label' => 'Create Blast DB',
                                'name' => 'CreateBlastDB',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'FastaDumper' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkFastaDumper',
                                'label' => 'Fasta Dumper',
                                'name' => 'FastaDumper',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'FilterTest' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkFilterTest',
                                'label' => 'Filter Test',
                                'name' => 'FilterTest',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'GFFDumper' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkGFFDumper',
                                'label' => 'GFF Dumper',
                                'name' => 'GFFDumper',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
			'GFFToGalaxyDumper' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkGFFToGalaxyDumper',
                                'label' => 'GFF To Galaxy Dumper',
                                'name' => 'GFFToGalaxyDumper',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'GeneFinder' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkGeneFinder',
                                'label' => 'Gene Finder',
                                'name' => 'GeneFinder',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'OligoFinder' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkOligoFinder',
                                'label' => 'Oligo Finder',
                                'name' => 'OligoFinder',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'PrimerDesigner' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkPrimerDesigner',
                                'label' => 'Primer Designer',
                                'name' => 'PrimerDesigner',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'ProteinDumper' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkProteinDumper',
                                'label' => 'Protein Dumper',
                                'name' => 'ProteinDumper',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'RandomGene' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkRandomGene',
                                'label' => 'Random Gene',
                                'name' => 'RandomGene',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'RestrictionAnnotator' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkRestrictionAnnotator',
                                'label' => 'Restriction Annotator',
                                'name' => 'RestrictionAnnotator',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
			'Spectrogram' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkSpectrogram',
                                'label' => 'Spectrogram',
                                'name' => 'Spectrogram',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'Submitter' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkSubmitter',
                                'label' => 'Submitter',
                                'name' => 'Submitter',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        },
                        'test' => {
		                'dataType' => 'boolean',
                        	'id' => 'chkTest,
                                'label' => 'Test',
                                'name' => 'test',
		                'parent' => 'plugins',
                                'template' => 'checkbox',
                                'value' => 0
                        }
                },
                'visible' => 1
        },
        'hilite fill' => {
                'class' => 'advanced',
                'dataType' => 'color',
                'errorCodes' =>
                        {
                                '1' => 'Enter Hilite Fill Color. Colors can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                        },
                'hasChildren' => 0,
                'hint' => 'Hilite Fill Color controls the color of the interior of the selection rectangles that appear in the overview and regionview when zoomed into a region. Colors can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                'id' => 'txtHiliteFill',
                'label' => 'Hilite Fill Color',
                'name' => 'hilite fill',
                'readOnly' => 0,
                'required' => 1,
                'section' => 'General',
                'template' => 'text',
                'toolTip' => 'Interior color of the overview and regionview selection rectangles',
                'validation' => 'isEmpty()',
                'value' => 'yellow',
                'visible' => 1
        },
        'hilite outline' => {
                'class' => 'advanced',
                'dataType' => 'color',
                'errorCodes' =>
                        {
                                '1' => 'Enter Hilite Outline Color. Colors can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                        },
                'hasChildren' => 0,
                'hint' => 'Hilite Outline Color controls the color of the outline of the selection rectangles that appear in the overview and regionview when zoomed into a region. Colors can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                'id' => 'txtHiliteOutline',
                'label' => 'Hilite Outline Color',
                'name' => 'hilite outline',
                'readOnly' => 0,
                'required' => 1,
                'section' => 'General',
                'template' => 'text',
                'toolTip' => 'Outline color of the overview and regionview selection rectangles',
                'validation' => 'isEmpty()',
                'value' => 'orange',
                'visible' => 1
        },
        'overview bgcolor' => {
                'class' => 'advanced',
                'dataType' => 'color',
                'errorCodes' =>
                        {
                                '1' => 'Enter Overview Background Color. Colors can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                        },
                'hasChildren' => 0,
                'hint' => 'Overview Background Color controls the color of the background of the birds-eye view. Colors can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                'id' => 'txtOverviewBGColor',
                'label' => 'Overview Background Color',
                'name' => 'overview bgcolor',
                'readOnly' => 0,
                'required' => 1,
                'section' => 'General',
                'template' => 'text',
                'toolTip' => 'Birds-eye view background color',
                'validation' => 'isEmpty()',
                'value' => 'white',
                'visible' => 1
        },
        'detailed bgcolor' => {
                'class' => 'advanced',
                'dataType' => 'color',
                'errorCodes' =>
                        {
                                '1' => 'Enter Detailed Background Color. Colors can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                        },
                'hasChildren' => 0,
                'hint' => 'Detailed Background Color controls the color of the background of the detailed view. Colors can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                'id' => 'txtDetailedBGColor',
                'label' => 'Detailed Background Color',
                'name' => 'detailed bgcolor',
                'readOnly' => 0,
                'required' => 1,
                'section' => 'General',
                'template' => 'text',
                'toolTip' => 'Detailed view background color',
                'validation' => 'isEmpty()',
                'value' => 'white',
                'visible' => 1
        },
        'request timeout' => {
                'class' => 'advanced',
                'dataType' => 'number',
                'errorCodes' =>
                        {
                                '1' => 'Enter the timeout value for requests (in seconds).',
                                '2' => 'Request Timeout has to be a numeric value (seconds).'
                        },
                'hasChildren' => 0,
                'hint' => 'The requests from the user which take more than the Request Timeout seconds will be automatically timed out and the user will be advised to choose a smaller region. The default value is 60 seconds.'
                'id' => 'txtRequestTimeout',
                'label' => 'Request Timeout (seconds)',
                'name' => 'request timeout',
                'readOnly' => 0,
                'required' => 1,
                'section' => 'General',
                'template' => 'text',
                'toolTip' => 'Timeout value for requests',
                'validation' => 'isEmpty(), isNonNumeric()',
                'value' => '60',
                'visible' => 1
        },
        'disable wildcards' => {
                'class' => 'advanced',
                'dataType' => 'boolean',
                'hasChildren' => 0,
                'hint' => 'This option if checked, disables wildcard searching by using asterisk (*).'
                'id' => 'chkDisableWildcards',
                'label' => 'Disable Wildcards',
                'name' => 'disable wildcards',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'General',
                'template' => 'checkbox',
                'toolTip' => 'Enable/Disable wildcard searching',
                'value' => '0',
                'visible' => 1
        },
        'image widths' => {
                'class' => 'advanced',
                'dataType' => 'space_delimited_number',
                'errorCodes' =>
                        {
                                '1' => 'Enter the Image Widths.',
                                '3' => 'Image Widths should be a series of space delimited numbers.'
                        },
                'hasChildren' => 0,
                'hint' => 'Image Widths provides the set of image sizes to offer the user. Its value is a space-delimited list of pixel widths.'
                'id' => 'txtImageWidths',
                'label' => 'Image Widths',
                'name' => 'image widths',
                'readOnly' => 0,
                'required' => 1,
                'section' => 'General',
                'template' => 'text',
                'toolTip' => 'Image sizes to be offered to the user',
                'validation' => 'isEmpty(), isNonSpaceDelimitedNumerics()',
                'value' => '640 800 1024',
                'visible' => 1
        },
        'default width' => {
                'class' => 'advanced',
                'dataType' => 'number',
                'errorCodes' =>
                        {
                                '1' => 'Enter the Default Image Width.',
                                '2' => 'Default Image Width has to be a numeric value.'
                        },
                'hasChildren' => 0,
                'hint' => 'It is the image width to start off with when the user invokes the browser for the first time.'
                'id' => 'txtDefaultWidth',
                'label' => 'Default Image Width',
                'name' => 'default width',
                'readOnly' => 0,
                'required' => 1,
                'section' => 'General',
                'template' => 'text',
                'toolTip' => 'Default Image Width',
                'validation' => 'isEmpty(), isNonNumeric()',
                'value' => '800',
                'visible' => 1
        }
);



my %constants = (
	'db_adaptor' => {
                'hasChildren' => 0,
		'name' => 'db_adaptor',
                'section' => 'General',
		'value' => 'BIO::DB::SEQFEATURE::STORE'
        },
	'db_args' => {
                'hasChildren' => 1,
		'name' => 'db_args',
                'section' => 'General',
                'value' => {
                        '-adaptor' => {
				'hasChildren' => 0,
                                'name' => '-adaptor',
                                'parent' => 'db_args',
                                'value' => 'memory'
                        },
                        '-dir' => {
				'hasChildren' => 0,
                                'name' => '-dir',
                                'parent' => 'db_args',
                                'value' => '>>>PATH<<<'
                        }
                }
        },
	'gbrowse root' => {
                'hasChildren' => 0,
		'name' => 'gbrowse root',
                'section' => 'General',
		'value' => 'gbrowse'
        },
	'stylesheet' => {
                'hasChildren' => 0,
		'name' => 'stylesheet',
                'section' => 'General',
		'value' => 'gbrowse.css'
        },
	'buttons' => {
                'hasChildren' => 0,
		'name' => 'buttons',
                'section' => 'General',
		'value' => 'images/buttons'
        },
	'js' => {
                'hasChildren' => 0,
		'name' => 'js',
                'section' => 'General',
		'value' => 'js'
        },
	'tmpimages' => {
                'hasChildren' => 0,
		'name' => 'tmpimages',
                'section' => 'General',
		'value' => 'tmp'
        },
	'link' => {
                'hasChildren' => 0,
		'name' => 'link',
                'section' => 'Track Defaults',
		'value' => 'AUTO'
        }
);



my %stage2 = (
	'glyph' => {
                'class' => 'basic',
                'dataType' => 'string',
                'hasChildren' => 0,
                'hint' => 'Glyph is the graphical icon that is used to represent the individual feature on a track.',
                'id' => 'txtGlyph',
                'label' => 'Glyph',
                'name' => 'glyph',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => 'text',
                'toolTip' => 'The default glyph to be used',
                'value' => 'generic',
                'visible' => 1
        },
	'height' => {
                'class' => 'basic',
                'dataType' => 'number',
                'errorCodes' =>
                        {
                                '2' => 'Glyph Height has to be a numeric value (pixels).'
                        },
                'hasChildren' => 0,
                'hint' => 'It is the height of the glyph, expressed in pixels.',
                'id' => 'txtHeight',
                'label' => 'Glyph Height',
                'name' => 'height',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => 'text',
                'toolTip' => 'Height of the glyph',
                'validation' => 'isNonNumeric()',
                'value' => '8',
                'visible' => 1
        },
        'bgcolor' => {
                'class' => 'basic',
                'dataType' => 'color',
                'hasChildren' => 0,
                'hint' => 'Glyph Background Color can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                'id' => 'txtBGColor',
                'label' => 'Glyph Background Color',
                'name' => 'bgcolor',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => 'text',
                'toolTip' => 'default background color of the glyph',
                'value' => 'orange',
                'visible' => 1
        },
        'fgcolor' => {
                'class' => 'basic',
                'dataType' => 'color',
                'hasChildren' => 0,
                'hint' => 'Glyph Outline Color can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                'id' => 'txtFGColor',
                'label' => 'Glyph Outline Color',
                'name' => 'fgcolor',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => 'text',
                'toolTip' => 'default outline color of the glyph',
                'value' => 'red',
                'visible' => 1
        },
        'fontcolor' => {
                'class' => 'basic',
                'dataType' => 'color',
                'hasChildren' => 0,
                'hint' => 'Label Font Color is the color of the primary font of text drawn in the glyph. This is the font used for the feature labels drawn at the top of the glyph. It can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                'id' => 'txtFontColor',
                'label' => 'Label Font Color',
                'name' => 'fontcolor',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => 'text',
                'toolTip' => 'default primary font color of the glyph',
                'value' => 'black',
                'visible' => 1
        },
        'font2color' => {
                'class' => 'basic',
                'dataType' => 'color',
                'hasChildren' => 0,
                'hint' => 'Description Font Color is the color of the secondary font of text drawn in the glyph. This is the font used for the longish feature descriptions drawn at the bottom of the glyph. It can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                'id' => 'txtFont2Color',
                'label' => 'Description Font Color',
                'name' => 'font2color',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => 'text',
                'toolTip' => 'default secondary font color of the glyph',
                'value' => 'black',
                'visible' => 1
        },
        'key bgcolor' => {
                'class' => 'basic',
                'dataType' => 'color',
                'hasChildren' => 0,
                'hint' => 'Key Background Color can be specified by name (e.g. yellow), or in HTML #RRGGBB format.'
                'id' => 'txtKeyBGColor',
                'label' => 'Key Background Color',
                'name' => 'key bgcolor',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => 'text',
                'toolTip' => 'default background color of the key',
                'value' => 'red',
                'visible' => 1
        },
        'strand_arrow' => {
                'class' => 'advanced',
                'dataType' => 'boolean',
                'hasChildren' => 0,
                'hint' => 'This option if checked, the glyph will indicate the strandedness of the feature, usually by drawing an arrow of some sort. Some glyphs are inherently stranded, or inherently non-stranded and simply ignore this option.'
                'id' => 'chkStrandArrow',
                'label' => 'Show Strandedness',
                'name' => 'strand_arrow',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => 'checkbox',
                'toolTip' => 'Show/Ignore strandedness',
                'value' => '1',
                'visible' => 1
        },
	'label density' => {
                'class' => 'advanced',
                'dataType' => 'number',
                'errorCodes' =>
                        {
                                '2' => 'Label Density has to be a numeric value.'
                        },
                'hasChildren' => 0,
                'hint' => 'When there are too many annotations on the screen GBrowse automatically disables printing of the identifying labels next to the feature. Label Density controls where the cutoff occurs by turning off the labels when there are more than the specified number of annotations of a particular type on display at once.',
                'id' => 'txtLabelDensity',
                'label' => 'Label Density',
                'name' => 'label density',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => 'text',
                'toolTip' => 'Cutoff value for the number of annotations of a particular type before turning off the labels',
                'validation' => 'isNonNumeric()',
                'value' => '25',
                'visible' => 1
        },
	'bump density' => {
                'class' => 'advanced',
                'dataType' => 'number',
                'errorCodes' =>
                        {
                                '2' => 'Bump Density has to be a numeric value.'
                        },
                'hasChildren' => 0,
                'hint' => 'When there are too many annotations on the screen GBrowse automatically disables collision control. Usually, the browser shifts the annotations vertically preventing them from colliding. Bump Density controls where the cutoff occurs by letting the browser allow them to overlap instead when there are more than the specified number of annotations of a particular type on display at once.',
                'id' => 'txtBumpDensity',
                'label' => 'Bump Density',
                'name' => 'bump density',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => 'text',
                'toolTip' => 'Cutoff value for the number of annotations of a particular type before disabling the collision control',
                'validation' => 'isNonNumeric()',
                'value' => '100',
                'visible' => 1
        },
	'link_target' => {
                'class' => 'advanced',
                'dataType' => 'string',
                'hasChildren' => 0,
                'hint' => 'Defines where the contents of a feature link to be displayed. You can specify whether clicking a link would replace the contents of the current window or opens a new pop up window.',
                'id' => 'lstLinkTarget',
                'label' => 'Link Target',
                'name' => 'link_target',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => {
                	'list' => 'Current Window, Separate New Window for each click, Single new window for all clicks',
                        'options' => '_self, _blank, xWindow',
                        'size' => 1
                },
                'toolTip' => 'The default target for a link',
                'value' => '_self',
                'visible' => 1
        },
        'title' => {
                'class' => 'advanced',
                'dataType' => 'string',
                'hasChildren' => 0,
                'hint' => 'Title is the tooltip text that pops up when the mouse hovers over a glyph in certain browsers.'
                'id' => 'txtTitle',
                'label' => 'Title',
                'name' => 'title',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => 'text',
                'toolTip' => 'The default tooltip text for the glyphs',
                'value' => '',
                'visible' => 1
        },
        'landmark_padding' => {
                'class' => 'advanced',
                'dataType' => 'number',
                'errorCodes' =>
                        {
                                '2' => 'Landmark Padding has to be a numeric value.'
                        },
                'hasChildren' => 0,
                'hint' => 'Landmark Padding adds the specified number of base pairs on either ends of all landmarks that are searched for by name.'
                'id' => 'txtLandmarkPadding',
                'label' => 'Landmark Padding',
                'name' => 'landmark_padding',
                'readOnly' => 0,
                'required' => 0,
                'section' => 'Track Defaults',
                'template' => 'text',
                'toolTip' => 'The default padding for the searched landmarks',
                'validation' => 'isNonNumeric()',
                'value' => '1000',
                'visible' => 1
        }
);








#my $yml = YAML::Dump(@generalParamSettings);
#open (FILE, ">genConf.yml");
#print FILE $yml;
#close FILE;
#print "Done\n";


#my @arr = YAML::LoadFile('genConf.yml');


#foreach (@arr) {
#	print "Name:", $_->{name}, "\nID: ", $_->{id}, "\n\n";
#}
#$yml = "---\n-Abc\n-PQR\n...\n";
#$arr = YAML::LoadFile('test.yml');
#print @$arr[0], "\n", @$arr[1], "\n";

#my $arr = ['ABC', 'XYZ'];
__END__