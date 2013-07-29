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
		
		($self->{tags}->{title}, 	$self->{tags}->{track}, 
		 $self->{tags}->{artist}, 	$self->{tags}->{album},
		 $self->{tags}->{comment}, 	$self->{tags}->{year},
									$self->{tags}->{genres} ) = $mp3obj->autoinfo();				#	getting mp3's info
		
}

#---------------------------------------------------------------------------------------------------
#	Return a single tag information by tag selection
#---------------------------------------------------------------------------------------------------
sub getInfo {
		my $self 	= shift;
		my $key 	= shift;
		
		if (!defined $key) {	
			die "No argument defined on method: getInfo\n";
		}
		elsif(!defined $self->{tags}->{$key}) {
			die "fileInit method not called or \"$key\" argument is invalid\n";
		}
		else {
			return $self->{tags}->{$key};
		}
}

#---------------------------------------------------------------------------------------------------
#	Return an array of tag information
#---------------------------------------------------------------------------------------------------
sub getInofos {
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


1;
