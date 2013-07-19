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

sub mp3stat (\@) {
	my $mp3s = shift;
	
	#	var: file info
	#my $title, my $track, my $artist, my $album, my $comment, my $year, my $genres;
	my @mp3Tags;
	my @titles, my @tracks, my @artists, my @albums, my @comments, my @years, my @genreses;
	my @Tags = ( \@titles, \@tracks, \@artists, \@albums, \@comments, \@years, \@genreses );
	
	my $total = scalar @$mp3s;
	my $count;
	foreach my $mp3 (@$mp3s) {
		$mp3 =~ /([a-zA-Z0-9]*)$/;
		my $ext = lc $1;
		if ( -f $mp3 && $ext eq "mp3") {
			my $mp3obj = MP3::Tag->new($mp3);
			#($title, $track, $artist, $album, $comment, $year, $genres) = $mp3obj->autoinfo();
			@mp3Tags = $mp3obj->autoinfo();
			for my $key (2, 3, 5, 6) {
				if (defined $Tags[$key]->[0]) {
					#push @Tags[$key], $mp3Tags[$key];	
					#print "Defined: $Tags[$key]->[0]\n";
					#print "I'am in\n";
					my $rrr = scalar @{$Tags[1]};
					#print "$rrr\n";
					my $toPush = 0;
					foreach my $tagsKey (0..(scalar @{$Tags[$key]} - 1)) {
						#print "$mp3Tags[$key]    $Tags[$key]->[$tagsKey] ----- $tagsKey\n";
						$toPush = 0;
						last if ($mp3Tags[$key] eq "" || lc $mp3Tags[$key] eq lc $Tags[$key]->[$tagsKey]);
						$toPush = 1;
					}
					if ($toPush) {
						push @{$Tags[$key]}, $mp3Tags[$key];
					}
					#print "I'am out\n";
				}
				else {
					push @{$Tags[$key]}, $mp3Tags[$key];	
					print "Undefined: $Tags[$key]->[0]\n";
				}
#				print "$Tags[0]";
			}
		}
		
		#last if ($count == 2000);
		$count++;
		my $proc = $count * 100 / $total;
		$|=1;
		printf "\r %d", $proc;
		print " %";
	}
	sleep 2;
	foreach my $printMe (@{$Tags[6]}) {
		print "$printMe\n";
	}
}


1
