#!/usr/bin/perl
#PBAR.pml
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

#-------------------------------------------------------------------------------------------------------------
#	Print a progress bar
#
#	showPBar(int: total_item_count, int: item_processed, int: length of the bar)
#
#	ex:
#	showPBar($total, $count, 10);
#
#	NOTE: 
#	Aspect -->		[#############------------------------------] 30%
#
#-------------------------------------------------------------------------------------------------------------

sub showPBar ($$$) {
	my $itemNo 	= 	shift;
	my $itemCnt = 	shift;
	my $barLen 	=	shift || 20;
	
	my $percent;
	
	$itemCnt != $itemNo ? $percent = $itemCnt * 100 / $itemNo : $percent = 100;			#	percentage calculation
	
	my $varLen = $barLen * $percent / 100;			#	bar lenght calculation
	
	$| = 1;											#	output unbuffered
	
	#for my $nct (0..$barLen) {
	my $barOut = "\r\[";
	
	for my $cntPx (0..$varLen) {
		$barOut .= "#";
	}
	for my $cntPx($varLen..$barLen -1){
		$barOut .= " ";
	}
	
	$barOut .= "\]";

	print "$barOut";
	printf "%2.0f",$percent;
	print "%";
	
	if ($itemNo == $itemCnt) {
		print "\n";
	}
}


#-------------------------------------------------------------------------------------------------------------
#	Print rotative progressive char
#
#	showRBar()
#
#	ex:
#	showRBar();
#
#	NOTE: 
#	Aspect -->			\ 		-> 		| 		-> 		/ 		-> 		-
#					1st cycl	->	2nd cycl	->	3rd cycle	->	4th cycle
#-------------------------------------------------------------------------------------------------------------

my $RBarCrnt = 0;

sub showRBar {
	
	my @RBar = ("\\", "\|", "\/", "\-");
	if ($RBarCrnt > 3) {
		$RBarCrnt = 0;
	}
	$| = 1;
	print "\b".$RBar[$RBarCrnt];
	$RBarCrnt++;
}




1;


