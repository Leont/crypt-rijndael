require 5.006;

use ExtUtils::MakeMaker 6.46;

eval "use Test::Manifest 1.21";

WriteMakefile(
	'NAME'           => "Crypt::Rijndael",
	'VERSION_FROM'   => "Rijndael.pm",
	'LICENSE'        => 'lgpl',
	'AUTHOR'         => 'Rafael R. Sevilla (maintained by brian d foy <bdfoy@cpan.org>)',
	'ABSTRACT'       => 'Crypt::CBC compliant Rijndael encryption module',

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
