#!/usr/bin/perl
#mp3info.pm
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
#
#       @author         : Mauro Ghedin
#       @contact        : domyno88 at gmail dot com
#       @version        : 0.1

package mp3info;

use MP3::Tag;
use MP3::Tag::ID3v2;
MP3::Tag->config(write_v24 => 1, prohibit_v24 => 1);


use warnings;
use strict;
	 
our %frID3v2 = (
				artist	=> "TPE1",		#	Lead performer(s)/Soloist(s)
				album	=> "TALB",		#	Album/Movie/Show title
				title	=> "TIT2",		#	Title/songname/content description
				year	=> "TDRC", 		#"TYER",		#	Year (replaced by TDRC in v2.4)
				genres	=> "TCON",		#	Content type
				track	=> "TRCK",		#	Track number/Position in set
				comment	=> "COMM"		#	Track number/Position in set
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
	 
	 
#---------------------------------------------------------------------------------------------------
#
#	mp3info Class - initialized with file name + file path like /var/media/disck/doc/song.mp3 
#																./doc/song.mp3		
#
#---------------------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------------------
#	Object init with path + file.mp3
#---------------------------------------------------------------------------------------------------
sub new {
		my $class = shift;
		my $self = {
			path => shift,
			tags => undef
			};
			
		if (!-f $self->{path} || ( -f $self->{path} && $self->{path} !~ /\.mp3$/ )) {
			die "$self->{path} don't have mp3 extension or is't a file\n";
		}
		
		bless ($self, $class);
		return $self;
}

#---------------------------------------------------------------------------------------------------
#	Object data initialization by reading mp3 tag
#---------------------------------------------------------------------------------------------------
sub fileInit {
		my $self = shift;
		my $title, my $track, my $artist, my $album, my $comment, my $year, my $genres;
		
		my $mp3obj = MP3::Tag->new($self->{path});													#	object init
		
		$mp3obj->get_tags();																		#	get tag type
		$self->{MP3TagObj} = $mp3obj;																#	save obj if exists ID3v2 tags
				
		my $val = $self->{MP3TagObj}->{ID3v2}->get_frame_ids('truename');
		foreach my $lll (keys %$val) {
			print $lll." = ".$mp3obj->{ID3v2}->get_frame($lll)." - ";
		}
		
		($self->{tags}->{title}, 	$self->{tags}->{track}, 
		 $self->{tags}->{artist}, 	$self->{tags}->{album},
		 $self->{tags}->{comment}, 	$self->{tags}->{year},
									$self->{tags}->{genres} ) = $mp3obj->autoinfo();				#	getting mp3's info
									
									
		#~ print "   ".$self->{tags}->{year}."\n";
		print "\n";
}

#---------------------------------------------------------------------------------------------------
#	Return/write a single tag information by tag selection
#---------------------------------------------------------------------------------------------------
sub tagValue {
		my $self 	= shift;
		my $key 	= shift;
		my $val		= shift;
		
		if (!defined $key) {	
			die "No argument defined on method: getInfo\n";
		}
		elsif(!defined $self->{tags}->{$key}) {
			die "fileInit method not called or \"$key\" argument is invalid\n";
		}
		else {
			$self->{tags}->{$key} = $val if defined $val;
			return $self->{tags}->{$key};
		}
}

#---------------------------------------------------------------------------------------------------
#	Return an array of tag information
#---------------------------------------------------------------------------------------------------
sub getValues {
		my $self 	= shift;
		
		return ( $self->{tags}->{title},	$self->{tags}->{track}, 
				 $self->{tags}->{artist},	$self->{tags}->{album},
				 $self->{tags}->{comment},	$self->{tags}->{year},
											$self->{tags}->{genres} );
		
	}

#---------------------------------------------------------------------------------------------------
#	Return the path of the file
#---------------------------------------------------------------------------------------------------
sub getPath {
		my $self = shift;
		return $self->{path};
}

#---------------------------------------------------------------------------------------------------
#	Return the number of tag key
#---------------------------------------------------------------------------------------------------
sub tagCount {
		my $self = shift;
		return scalar (keys $self->{tags});
}

#---------------------------------------------------------------------------------------------------
#	Return the name of tag keys
#---------------------------------------------------------------------------------------------------
sub tagsName {
		my $self = shift;
		return keys $self->{tags};
}

#---------------------------------------------------------------------------------------------------
#	Write new tag on mp3
#---------------------------------------------------------------------------------------------------			
sub tagWrite {
		my $self = shift;

		$self->{MP3TagObj}->new_tag('ID3v2') if !exists $self->{MP3TagObj}->{ID3v2};				#	ID3v2 tag creation if not exists
		
		foreach my $tagKey ( keys $self->{tags} ) {													#	frame value creation or renameing
			if ($tagKey ne "comment" && defined $self->{tags}->{$tagKey} ) {
				( defined $self->{MP3TagObj}->{ID3v2}->change_frame($frID3v2{$tagKey}, $self->{tags}->{$tagKey}) ) ? 
						next : print $self->{MP3TagObj}->{ID3v2}->add_frame($frID3v2{$tagKey}, $self->{tags}->{$tagKey});
			}
		} 
		return $self->{MP3TagObj}->{ID3v2}->write_tag(0);											#	write tag on mp3file - return 1 if write operation is terminated sucesfulyl
}



1;
