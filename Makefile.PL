require 5.008;

package Crypt::Rijndael;
use strict;
use warnings;

use File::Spec::Functions qw(catfile);

my $module    = __PACKAGE__;
( my $dist = $module ) =~ s/::/-/g;

my $github    = 'https://github.com/briandfoy/crypt-rijndael';
my $main_file = catfile( 'lib', split /::/, "$module.pm" );

my %WriteMakefile = (
	'NAME'           => $module,
	'VERSION_FROM'   => $main_file,
	'ABSTRACT_FROM'  => $main_file,
	'LICENSE'        => 'lgpl',
	'AUTHOR'         => 'Rafael R. Sevilla (maintained by brian d foy <bdfoy@cpan.org>)',

	'CONFIGURE_REQUIRES' => {
		'ExtUtils::MakeMaker'   => '6.64',
		'File::Spec::Functions' => '0',
		},

	'BUILD_REQUIRES' => {
		},

	'TEST_REQUIRES' => {
		'Test::More' => '0.94',
		},

	'PREREQ_PM' => { 
		},

	'MAN3PODS' => {
		'Rijndael.pm' => '$(INST_MAN3DIR)/Crypt::Rijndael.3',
		},

	'META_MERGE' => {
		'meta-spec' => { version => 2 },
		resources => {
			repository => {
				type => 'git',
				url  => "$github.git",
				web  => $github,
				},
			bugtracker => {
				web    => "$github/issues",
				},
			homepage => $github,
			},
		},

	clean => { FILES => "$dist-*" },

	dist => {
		PREOP     => 'pod2text Rijndael.pm | tee README >$(DISTVNAME)/README; chmod -R u=rwX,go=rX . ;',
		COMPRESS  => 'gzip -9v',
		SUFFIX    => '.gz',
		},

	OBJECT => q[_rijndael$(OBJ_EXT) Rijndael$(OBJ_EXT)],
	); 

sub arguments { \%WriteMakefile }

do_it() unless caller;
sub do_it {
	require File::Spec;
	my $MM ='ExtUtils::MakeMaker';
	my $MM_version =
		eval{ "$MM " . $WriteMakefile{'CONFIGURE_REQUIRES'}{'ExtUtils::MakeMaker'} }
			||
		"$MM 6.64";
	eval "use $MM_version; 1" or die "Could not load $MM_version: $@";
	eval "use Test::Manifest 1.21" 
		if -e File::Spec->catfile( qw(t test_manifest) );
	WriteMakefile( %WriteMakefile );
	}


no warnings;
__PACKAGE__;
