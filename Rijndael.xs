/* rijndael - An implementation of the Rijndael cipher.
 * Copyright (C) 2000, 2001 Rafael R. Sevilla <sevillar@team.ph.inter.net>
 *
 * Currently maintained by brian d foy, <bdfoy@cpan.org>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the Free
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#define PERL_NO_GET_CONTEXT
#define NEED_newCONSTSUB
#define NEED_sv_2pv_flags
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "rijndael.h"

typedef struct cryptstate {
  RIJNDAEL_context ctx;
  UINT8 iv[RIJNDAEL_BLOCKSIZE];
  int mode;
} *Crypt__Rijndael;

MODULE = Crypt::Rijndael		PACKAGE = Crypt::Rijndael

PROTOTYPES: DISABLE

BOOT:
{
  HV *stash = gv_stashpvs("Crypt::Rijndael", GV_ADD);

  newCONSTSUB(stash, "keysize",   newSVuv(32)        );
  newCONSTSUB(stash, "blocksize", newSVuv(16)        );
  newCONSTSUB(stash, "MODE_ECB",  newSVuv(MODE_ECB)  );
  newCONSTSUB(stash, "MODE_CBC",  newSVuv(MODE_CBC)  );
  newCONSTSUB(stash, "MODE_CFB",  newSVuv(MODE_CFB)  );
  newCONSTSUB(stash, "MODE_PCBC", newSVuv(MODE_PCBC) );
  newCONSTSUB(stash, "MODE_OFB",  newSVuv(MODE_OFB)  );
  newCONSTSUB(stash, "MODE_CTR",  newSVuv(MODE_CTR)  );
}

Crypt::Rijndael
new(class, key, mode=MODE_ECB)
	SV * class
	SV * key
	int mode
	CODE:
		{
		STRLEN keysize;

		if (!SvPOK (key))
			Perl_croak(aTHX_ "key must be an untainted string scalar");

		keysize = SvCUR(key);

		if (keysize != 16 && keysize != 24 && keysize != 32)
			Perl_croak(aTHX_ "wrong key length: key must be 128, 192 or 256 bits long");
		if (mode != MODE_ECB && mode != MODE_CBC && mode != MODE_CFB && mode != MODE_OFB && mode != MODE_CTR)
			Perl_croak(aTHX_ "illegal mode, see documentation for valid modes");

		Newz(0, RETVAL, 1, struct cryptstate);
		RETVAL->ctx.mode = RETVAL->mode = mode;
		/* set the IV to zero on initialization */
		Zero(RETVAL->iv, RIJNDAEL_BLOCKSIZE, char);
		rijndael_setup(&RETVAL->ctx, keysize, (UINT8 *) SvPV_nolen(key));
		}
	OUTPUT:
		RETVAL

SV *
set_iv(self, data)
	Crypt::Rijndael self
	SV * data

	CODE:
		{
		SV *res;
		STRLEN size;
		void *rawbytes = SvPV(data,size);

		if( size !=  RIJNDAEL_BLOCKSIZE )
			Perl_croak(aTHX_ "set_iv: initial value must be the blocksize (%d bytes), but was %d bytes", RIJNDAEL_BLOCKSIZE, size);
		Copy(rawbytes, self->iv, RIJNDAEL_BLOCKSIZE, char);
		}

SV *
encrypt(self, data)
	Crypt::Rijndael self
	SV * data
	ALIAS:
		decrypt = 1

	CODE:
		{
		SV *res;
		STRLEN size;
		void *rawbytes = SvPV(data,size);

		if (size) {
			UINT8* buffer;

			if (size % RIJNDAEL_BLOCKSIZE)
				Perl_croak(aTHX_ "encrypt: datasize not multiple of blocksize (%d bytes)", RIJNDAEL_BLOCKSIZE);

			RETVAL = newSV(size);
			SvPOK_only(RETVAL);
			SvCUR_set(RETVAL, size);
			buffer = (UINT8 *)SvPV_nolen(RETVAL);
			(ix ? block_decrypt : block_encrypt)
				(&self->ctx, rawbytes, size, buffer, self->iv);
			buffer[size] = '\0';
		}
		else
			RETVAL = newSVpv ("", 0);
		}
	OUTPUT:
		RETVAL


void
DESTROY(self)
	Crypt::Rijndael self
	CODE:
	Safefree(self);
