#!/usr/bin/perl

use Crypt::Rijndael;
use Devel::Peek;

my $key = "a" x 32;
my $cipher = new Crypt::Rijndael $key, Crypt::Rijndael::MODE_CBC;
mySub();

sub mySub
{
  my $encryptedData = "eeb1fabf451aa59252003bdd6d568357";
  my $encryptedData = pack("H*", $encryptedData);
  my $plaintext = $cipher->decrypt($encryptedData);

#  my $plaintext = "text\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00";

  print $plaintext,"\n";
  Dump( $plaintext );
  print join(',', unpack 'C*', $plaintext),"\n";

  $plaintext =~ s/\x00+$//;
  
  Dump( $plaintext );
  print $plaintext,"\n";
  print join(',', unpack 'C*', $plaintext),"\n";
}
