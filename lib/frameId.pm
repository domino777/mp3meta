#!/usr/bin/perl
#frameId.pm
#
#  "Copyright 2013 Mauro Ghedin"
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  or any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.

#       @author         : Mauro Ghedin
#       @contact        : domyno88 at gmail dot com
#       @version        : 0.1

#---------------------------------------------------------------------------------------------------
#	ID3v2 v2.3 frame definition
#---------------------------------------------------------------------------------------------------

my %frID3v2 = (
				artist	=> "TPE1",		#	Lead performer(s)/Soloist(s)
				album	=> "TALB",		#	Album/Movie/Show title
				title	=> "TIT2",		#	Title/songname/content description
				year	=> "TYER",		#	Year (replaced by TDRC in v2.4)
				genres	=> "TCON",		#	Content type
				track	=> "TRCK"		#	Track number/Position in set
			);

	 #~ TALB Album/Movie/Show title
	 #~ TBPM BPM (beats per minute)
	 #~ TCOM Composer
	 #~ TCON Content type
	 #~ TCOP Copyright message
	 #~ TDAT Date (replaced by TDRC in v2.4)
	 #~ TDLY Playlist delay
	 #~ TENC Encoded by
	 #~ TEXT Lyricist/Text writer
	 #~ TFLT File type
	 #~ TIME Time (replaced by TDRC in v2.4)
	 #~ TIT1 Content group description
	 #~ TIT2 Title/songname/content description
	 #~ TIT3 Subtitle/Description refinement
	 #~ TKEY Initial key
	 #~ TLAN Language(s)
	 #~ TLEN Length
	 #~ TMED Media type
	 #~ TOAL Original album/movie/show title
	 #~ TOFN Original filename
	 #~ TOLY Original lyricist(s)/text writer(s)
	 #~ TOPE Original artist(s)/performer(s)
	 #~ TORY Original release year (replaced by TDOR in v2.4)
	 #~ TOWN File owner/licensee
	 #~ TPE1 Lead performer(s)/Soloist(s)
	 #~ TPE2 Band/orchestra/accompaniment
	 #~ TPE3 Conductor/performer refinement
	 #~ TPE4 Interpreted, remixed, or otherwise modified by
	 #~ TPOS Part of a set
	 #~ TPUB Publisher
	 #~ TRCK Track number/Position in set
	 #~ TRDA Recording dates (replaced by TDRC in v2.4)
	 #~ TRSN Internet radio station name
	 #~ TRSO Internet radio station owner
	 #~ TSIZ Size (deprecated in v2.4)
	 #~ TSRC ISRC (international standard recording code)
	 #~ TSSE Software/Hardware and settings used for encoding
	 #~ TYER Year (replaced by TDRC in v2.4)
	 #~ TXXX User defined text information frame
	
1;
