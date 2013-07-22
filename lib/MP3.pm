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
use lib::PBAR;


#-------------------------------------------------------------------------------------------------------------
#	Generate a statistic about the mp3 files
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

sub mp3stat (\@$) {
	
#	function argument
	my $mp3s 	= shift;
	my $showBar = shift || 0;
	
#	local var
	my @mp3Tags;
	my @titles, my @tracks, my @artists, my @albums, my @comments, my @years, my @genreses;
	my @Tags = \( @titles, @tracks, @artists, @albums, @comments, @years, @genreses );
	
	my $cnt = 0;
	foreach my $mp3 (@$mp3s) {
		$mp3 =~ /([a-zA-Z0-9]*)$/;									#	getting file extension
		
		if ( -f $mp3 && lc $1 eq "mp3") {
			my $mp3obj = MP3::Tag->new($mp3);						#	create MP3::Tag object
			@mp3Tags = $mp3obj->autoinfo();							#	getting mp3's info
			
			for my $tagIndex (2, 3, 5, 6) {		
							
				if (defined $Tags[$tagIndex]->[0]) {				#	check data initialization
						
					foreach my $tagsKey (0..@{$Tags[$tagIndex]} - 1) {			
																	#	V skip on duplicated value
						last if ($mp3Tags[$tagIndex] eq "" || lc $mp3Tags[$tagIndex] eq lc $Tags[$tagIndex]->[$tagsKey]);
																	#	V save value, else next
						$tagsKey == (scalar @{$Tags[$tagIndex]} - 1) ? push @{$Tags[$tagIndex]}, $mp3Tags[$tagIndex] : next;
					}

				}
				else {
					push @{$Tags[$tagIndex]}, $mp3Tags[$tagIndex];	#	initialize first element data
				}
			}
		}
		if ($showBar) {
			$cnt++;
			showPBar(scalar @$mp3s, $cnt, 120);
		}
	}
# DEBUG LINES START -----------------------------------------------
	#foreach my $lll (@{$Tags[2]}) {
	#	print "$lll\n";
	#}
# DEBUG LINES END -----------------------------------------------

	\@Tags;															#	return data
}


1
