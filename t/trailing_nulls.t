#!/usr/bin/perl

use Crypt::Rijndael;
use Devel::Peek;

my $key = "a" x 32;
my $cipher = Crypt::Rijndael->new( $key, Crypt::Rijndael::MODE_CBC );
mySub();

sub mySub
{
  my $encryptedData = "eeb1fabf451aa59252003bdd6d568357";
  my $encryptedData = pack("H*", $encryptedData);
  my $plaintext = $cipher->decrypt($encryptedData);

#  my $plaintext = "text\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00";

  diag $plaintext,"\n";
  Dump( $plaintext );
  diag join(',', unpack 'C*', $plaintext),"\n";

  $plaintext =~ s/\x00+$//;
  
  Dump( $plaintext );
  diag $plaintext,"\n";
  diag join(',', unpack 'C*', $plaintext),"\n";
}
