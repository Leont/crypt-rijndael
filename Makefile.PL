# $Id$

use ExtUtils::MakeMaker;

eval "use Test::Manifest 1.14";

WriteMakefile(
	NAME           => "Crypt::Rijndael",
#    VERSION_FROM   => "Rijndael.pm",
	VERSION        => '0.06_01',
	
	'PREREQ_PM'    => { 
			'Test::More'         => '0',
			},


	'MAN3PODS'     => {
			'Rijndael.pm' => '$(INST_MAN3DIR)/Crypt::Rijndael.3',
			},

	clean          => { FILES    => q|*.bak Crypt-*| },

	dist	       => {
	            PREOP	=> 'pod2text Rijndael.pm | tee README >$(DISTVNAME)/README; chmod -R u=rwX,go=rX . ;',
	            COMPRESS	=> 'gzip -9v',
	            SUFFIX	=> '.gz',
	           },

    OBJECT       => q[_rijndael$(OBJ_EXT) Rijndael$(OBJ_EXT)],
); 