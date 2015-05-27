#!/usr/bin/perl

use Test::More tests => 68;

use Crypt::Rijndael;

ok(defined &Crypt::Rijndael::blocksize);
is(Crypt::Rijndael->blocksize, 16);

foreach my $a ( 0 .. 10 ) {
	my $hash = crypt_decrypt(Crypt::Rijndael::MODE_CBC);
	is($hash->{plain}, $hash->{data}, "Decrypted text matches plain text for cbc-$a");
}

foreach my $a ( 0 .. 10 ) {
	my $hash = crypt_decrypt(Crypt::Rijndael::MODE_CFB);
	is($hash->{plain}, $hash->{data}, "Decrypted text matches plain text for cfb-$a");
}

foreach my $a ( 0 .. 10 ) {
	my $hash = crypt_decrypt(Crypt::Rijndael::MODE_CTR);
	is($hash->{plain}, $hash->{data}, "Decrypted text matches plain text for ctr-$a");
}

foreach my $a ( 0 .. 10 ) {
	my $hash = crypt_decrypt(Crypt::Rijndael::MODE_ECB);
	is($hash->{plain}, $hash->{data}, "Decrypted text matches plain text for ecb-$a");
}

foreach my $a ( 0 .. 10 ) {
	my $hash = crypt_decrypt(Crypt::Rijndael::MODE_OFB );
	is($hash->{plain}, $hash->{data}, "Decrypted text matches plain text for ofb-$a");
}

TODO: {
	todo_skip "PCBC is not a legal mode (yet)", 11;
	
	foreach my $a ( 0 .. 10 ) {
		my $hash = crypt_decrypt(Crypt::Rijndael::MODE_PCBC);
		is($hash->{plain}, $hash->{data}, "Decrypted text matches plain text");
	}

};

sub crypt_decrypt {
	my $mode   = shift;

	my $key    = make_string(32);
	my $c      = Crypt::Rijndael->new($key, $mode);
	my $data   = make_string(32 * int rand(16) + 1);

	my $cipher = $c->encrypt($data);
	my $plain  = $c->decrypt($cipher);

	return {
		data   => $data,
		cipher => $cipher,
		plain  => $plain,
	};
}

sub make_string {
	my $size = shift;
	return pack 'C*', map { rand 256 } 1 .. $size;
}
