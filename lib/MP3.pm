#!/usr/bin/perl
#MP3.pml
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

use warnings;
use strict;

#	Loading external library
use MP3::Tag;


#-------------------------------------------------------------------------------------------------------------
#	Generate a statistic about the mp3 file
#
#	funcName(string: path, int: recursive_mode, string: file_format)
#
#	ex:
#	my %pathlist = fileStat("/home/my/music", 0, ".mp3|.ogg");
#
#	NOTE: 
#	Return an hash cointain file tipe as argument and countig as value of the key
#
#-------------------------------------------------------------------------------------------------------------

sub mp3stat (\@) {
	my $mp3s = shift;
	
	foreach my $mp3 (@$mp3s) {
		$mp3 =~ /([a-zA-Z0-9]*)$/;
		my $ext = lc $1;
		if ( -f $mp3 && $ext eq "mp3") {
			print "$mp3\n";
		}
	}
}


1
