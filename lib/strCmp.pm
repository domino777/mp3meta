#!/usr/bin/perl
#strCmp.pm
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


use lib::base::base;

#---------------------------------------------------------------------------------------------------
#	Find literally a string into an other
#
#	fndLiteral(string: string_to_find, string: string_were_find)
#
#	ex:
#	my $found = fndLiteral("llo", "Hello world");
#
#	NOTE: 
#	Return 1 if string is found into the other string
#
#---------------------------------------------------------------------------------------------------

sub fndLiteral ($$) {
	$str1 = shift;	#	string to find
	$str2 = shift;	#	string were find
	
	return ( $str2 =~ /$str1/ig ? 1 : 0);		#	return true if str1 is in str2
}

#---------------------------------------------------------------------------------------------------
#	Find literally a string into an other but non apha-numeric charset are removed
#
#	fndCollapse(string: string_to_find, string: string_were_find)
#
#	ex:
#	my $found = fndCollapse("llo wor", "Hello -#%£ world");
#
#	NOTE: 
#	Return 1 if string is found into the other string
#
#
#---------------------------------------------------------------------------------------------------

sub fndCollapse ($$) {
	$str1 = shift;	#	string to find
	$str2 = shift;	#	string were find
	
	$str1 =~ s/[^\w\d]//g;
	$str2 =~ s/[^\w\d]//g;
	
	return ( $str2 =~ /$str1/ig ? 1 : 0);		#	return true if str1 is in str2
}

sub LevenshteinLen ($$) {
	my @arStr1 = strToArray(lc shift);
	my @arStr2 = strToArray(lc shift);
	
	my @d;
	
	for my $indx (0..scalar @arStr1 ) {																#	Levenshtein matrix init ( x axe)
		$d[$indx][0] =  $indx;
	}
	
	for my $indx (0..scalar @arStr2 ) {																#	Levenshtein matrix init ( y axe)
		$d[0][$indx] =  $indx;
	}
	
	for my $y (1..scalar @{ $d[0] } - 1) {
		for my $x (1..scalar @d - 1 ) {
			if ( $arStr1[$x - 1] eq $arStr2[$y - 1] ) {
				$d[$x][$y] = $d[$x - 1][$y - 1];
			}
			else {
				$d[$x][$y] = min( 
								$d[$x - 1][$y] + 1, 				#	deletion
								$d[$x][$y - 1] + 1, 				#	insertion
								$d[$x - 1][$y - 1] + 1 );			#	substitution
			}
		}
	}
	
	return $d[scalar @d - 1][scalar @{ $d[0] } - 1];
			
}	

1;
