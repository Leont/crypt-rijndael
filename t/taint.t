#!perl -T
use strict;
use warnings;

$ENV{PATH} = '/usr/bin';

use Test::More;

use Scalar::Util qw(tainted);

my $class = 'Crypt::Rijndael';
use_ok( $class );

my $plaintext = chr(0) x 32;
my( $command ) = "perl -v" =~ m/(.*)/g;
ok( ! tainted($command), 'command is not tainted' );

my $tainted_string = `$command`;

$plaintext .= $tainted_string;
$plaintext = substr $plaintext, 0, 32;
ok( tainted($plaintext), 'plaintext is tainted' );

for ( my $i = 0; $i < 32; $i++ ) {
	substr( $plaintext, $i, 1 ) = chr( $i );
	}

my $key = chr(0) x 32;
$key .= $tainted_string;
$key = substr $plaintext, 0, 32;
ok( tainted($key), 'key is tainted' );
substr( $key, 0, 1 ) = chr(1);

subtest 'ECB' => sub {
	my $ecb = $class->new( $key );
	
	my $crypted = $ecb->encrypt($plaintext);
	ok(
		unpack("H*", $crypted) eq "f2258e225d794572393a6484cfced7cf925d1aa18366bcd93c33d104294c8a6f"
		);
	ok( $ecb->decrypt($crypted) eq $plaintext );
	};

subtest 'CBC' => sub {
	my $cbc = $class->new( $key, Crypt::Rijndael::MODE_CBC() );
	my $crypted = $cbc->encrypt($plaintext);
	ok( 
		unpack("H*", $crypted) eq "f2258e225d794572393a6484cfced7cfb487a41f6b6286c00c9c8d80cb3ee9f8"
		);
	
	ok( $cbc->decrypt($crypted) eq $plaintext );
	};

done_testing();
