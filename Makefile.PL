use strict;
use warnings;

my $github    = 'https://github.com/briandfoy/';
my $main_file = 'lib/Rijndael.pm';

my %WriteMakefile = (
	'NAME'           => "Crypt::Rijndael",
	'VERSION_FROM'   => $main_file,
	'LICENSE'        => 'lgpl',
	'AUTHOR'         => 'Rafael R. Sevilla (maintained by brian d foy <bdfoy@cpan.org>)',
	'ABSTRACT_FROM'  => $main_file;

	'PREREQ_PM' => { 
		'Test::More'         => '0',
		'Test::Manifest'     => '1.14',
		},

	'MAN3PODS' => {
		'Rijndael.pm' => '$(INST_MAN3DIR)/Crypt::Rijndael.3',
		},

	'META_MERGE' => {
		'meta-spec' => { version => '2' },
		'resources' => {
			'repository' => {
				type => 'git',
				web  => 'https://github.com/briandfoy/crypt-rijndael',
				url  => 'git@github.com:briandfoy/crypt-rijndael.git'
				},
			},
		},

	clean => { FILES    => q|*.bak *.old Crypt-*| },

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
			//
		"$MM 6.64";
	eval "use $MM_version";
	eval "use Test::Manifest 1.21" 
		if -e File::Spec->catfile( qw(t test_manifest) );
	WriteMakefile( %WriteMakefile );
	}


no warnings;
__PACKAGE__;
