use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;
my $github = 'https://github.com/leont/crypt-rijndael';

my %WriteMakefileArgs = (
  ABSTRACT_FROM => 'Rijndael.pm',
  AUTHOR => [
    'Rafael R. Sevilla',
    'brian d foy <bdfoy@cpan.org>',
    'Leon Timmermans <leont@cpan.org>'
  ],
  CONFIGURE_REQUIRES => {
    'ExtUtils::MakeMaker' => 0,
  },
  DISTNAME => 'Crypt-Rijndael',
  EXE_FILES => [],
  LICENSE => 'lgpl',
  NAME => 'Crypt::Rijndael',
  PREREQ_PM => {
  },
  TEST_REQUIRES => {
    'Test::More' => 0,
  },
  test => {
    'TESTS' => 't/*.t t/*/*.t'
  },
  OBJECT => q[_rijndael$(OBJ_EXT) Rijndael$(OBJ_EXT)],
  'META_MERGE' => {
    dynamic_config => 0,
    'meta-spec' => { version => 2 },
    resources => {
      repository => {
        type => 'git',
        url  => "$github.git",
        web  => $github,
      },
      bugtracker => {
        web  => "$github/issues",
      },
      homepage => $github,
    },
  },
  MIN_PERL_VERSION => '5.006',
  VERSION_FROM => 'Rijndael.pm',
  clean => { FILES => 'Crypt-Rijndael-*' },
  dist => {
    PREOP    => 'pod2text Rijndael.pm | tee README >$(DISTVNAME)/README; chmod -R u=rwX,go=rX . ;',
    COMPRESS => 'gzip -9v',
    SUFFIX   => '.gz',
  },
);

my %FallbackPrereqs = (
    'ExtUtils::MakeMaker' => 0,
    'Test::More' => '0.94',
);

unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{AUTHOR} unless eval { ExtUtils::MakeMaker->VERSION(6.57_01) };
delete $WriteMakefileArgs{MIN_PERL_VERSION} unless eval { ExtUtils::MakeMaker->VERSION(6.47_01) };

delete $WriteMakefileArgs{CONFIGURE_REQUIRES} unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

