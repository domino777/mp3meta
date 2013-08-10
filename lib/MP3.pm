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
#       @version        : 0.2

use warnings;
use strict;

#	Loading external library
use lib::PBAR;		#	progress bar library
use lib::base::strExd;


#-------------------------------------------------------------------------------------------------------------
#	Generate a statistic about the mp3 files
#
#	mp3stat(mp3info_object, string: tag, int: show_progress_bar)
#
#	ex:
#	my @uniqueTagValue = mp3stat(@mp3ss, "author", 1);
#
#	NOTE: 
#	Return an array that contain all unique value of selected tag
#
#-------------------------------------------------------------------------------------------------------------

sub mp3stat (\@$$) {
	
#	function argument
	my $mp3s 	= shift;
	my $tagSel	= shift;
	my $showBar = shift || 0;
	
#	local var
	my @mp3Tags;
	my @UniqueTag;
#	counter for gBar
	my $cnt = 0;
	
	foreach my $mp3 (@$mp3s) {
		
		my $tagVal = $mp3->getInfo($tagSel);														#	get tag value
		
		next unless $tagVal;																		#	skip if tag value is not defined
		
			if (!defined $UniqueTag[0]) {															#	write first value for array initialization
				push  @UniqueTag, $tagVal;	
			}
			
			for my $index (0..scalar @UniqueTag - 1) {								
				last if (lc $tagVal eq lc $UniqueTag[$index]);										#	skip on duplicated value
				$index == (scalar @UniqueTag - 1) ? push  @UniqueTag, $tagVal : next;				#	save value at the and - save not matched value
			}
		
		if ($showBar) {
			$cnt++;
			showPBar(scalar @$mp3s, $cnt, 20);
		}
	}
	
	@UniqueTag;															#	return data
}


sub TagContentMatcher (\@$) {
#	function argument
	my $TagsContent = shift;
	my $TagMatcher	= shift;
	
#	local var
	my @matches;
	
	my $TagMatcherInv = $TagMatcher;
	$TagMatcherInv =~ s/[\ \-]/\.\?/g;
	
	foreach my $content (@$TagsContent) {
			my $contentInv = $content;
			$contentInv =~ s/[\ \-]/\.\?/g;
			
			if ($content =~ /$TagMatcherInv/gi) {
				print "Direct:\t\t$TagMatcher ----- ";
				print "$content\n";
			}
			elsif ($TagMatcher =~ /$contentInv/gi){
				print "Inverse:\t$TagMatcher ----- ";
				print "$content\n";
			}
	}
	
	@matches;
}


#-------------------------------------------------------------------------------------------------------------
#	Generate a statistic about the mp3 files
#
#	mp3stat(mp3info_object, string: tag, int: show_progress_bar)
#
#	ex:
#	my @uniqueTagValue = mp3stat(@mp3ss, "author", 1);
#
#	NOTE: 
#	Return an array that contain all unique value of selected tag
#
#-------------------------------------------------------------------------------------------------------------

sub mp3byTagVal (\@$$) {
#	function argument
	my $mp3s 			= shift;	
	my $tagName			= shift;	
	my $toFind		 	= shift;

#	local var
	my @mp3sResult;
	
	foreach my $mp3 (@$mp3s) {
		if (defined $mp3 && lc $mp3->getInfo($tagName) eq lc $toFind) {
			push @mp3sResult, $mp3;
		}
	}
	
	@mp3sResult
}




1
