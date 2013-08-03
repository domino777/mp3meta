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

use lib::frameId;

use MP3::Tag;
use MP3::Tag::ID3v2;


use warnings;
use strict;

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
				
		my $val = $mp3obj->{ID3v2}->get_frame_ids('truename');
		foreach my $lll (keys %$val) {
			print $lll." = ".$mp3obj->{ID3v2}->get_frame($lll)." - ";
		}
		
		($self->{tags}->{title}, 	$self->{tags}->{track}, 
		 $self->{tags}->{artist}, 	$self->{tags}->{album},
		 $self->{tags}->{comment}, 	$self->{tags}->{year},
									$self->{tags}->{genres} ) = $mp3obj->autoinfo();				#	getting mp3's info
									
		print "   ".$self->{tags}->{artist}."\n";
		
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
			$self->{tags}->{$key} = $val if defined;
			return $self->{tags}->{$key};
		}
}

#---------------------------------------------------------------------------------------------------
#	Return an array of tag information
#---------------------------------------------------------------------------------------------------
sub tagValues {
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
		
		foreach my $tagKey ( keys $self->{tags} ) {
			last if exists $self->{MP3TagObj}->{ID3v2};
			( defined $self->{MP3TagObj}->{ID3v2}->change_frame($frID3v2->{$tagKey}, $self->{tags}->{$tagKey}) ) ? 
				next : $self->{MP3TagObj}->add_frame($frID3v2->{$tagKey}, $self->{tags}->{$tagKey});
		} #:	$self->{MP3TagObj}->new_tag("ID3v2");
				
				
			#~ ( defined $self->{MP3TagObj}->{ID3v2}->change_frame(TITLE, $self->{tags}->{title}) ) ? 
				#~ last : $self->{MP3TagObj}->add_frame(TITLE, $self->{tags}->{title});
			#~ $self->{MP3TagObj}->change_frame(ARTIST, $self->{tags}->{artist});
			#~ $self->{MP3TagObj}->change_frame(TRKNO, $self->{tags}->{track});
			#~ $self->{MP3TagObj}->change_frame(ALBUM, $self->{tags}->{album});
			#~ $self->{MP3TagObj}->change_frame(YEAR, $self->{tags}->{year});
			#~ $self->{MP3TagObj}->change_frame(GENRES, $self->{tags}->{genres});
		#~ } : $self->{MP3TagObj}->new_tag("ID3v2");

}



1;
