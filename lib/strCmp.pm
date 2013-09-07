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

=pod

---------------------------------------------------------------------------------------------------

=head3 Find literally a string into an other

	fndLiteral(string: string_to_find, string: string_were_find)

	ex:
	my $found = fndLiteral("llo", "Hello world");

	NOTE: 
	Return 1 if string is found into the other string

---------------------------------------------------------------------------------------------------

=cut

sub fndLiteral ($$) {
	$str1 = shift;	#	string to find
	$str2 = shift;	#	string were find
	
	return ( $str2 =~ /$str1/ig ? 1 : 0);		#	return true if str1 is in str2
}

=pod

---------------------------------------------------------------------------------------------------

=head3 Find literally a string into an other but non apha-numeric charset are removed

	fndCollapse(string: string_to_find, string: string_were_find)

	ex:
	my $found = fndCollapse("llo wor", "Hello -- world");

	NOTE: 
	Return 1 if string is found into the other string

---------------------------------------------------------------------------------------------------

=cut

sub fndCollapse ($$) {
	$str1 = shift;	#	string to find
	$str2 = shift;	#	string were find
	
	$str1 =~ s/[^\w\d]//g;
	$str2 =~ s/[^\w\d]//g;
	
	return ( $str2 =~ /$str1/ig ? 1 : 0);		#	return true if str1 is in str2
}

=pod

---------------------------------------------------------------------------------------------------

=head3 Damerau-Levenshtein distance computation

	damerauLevenshteinLenght(string: string_to_find, string: string_were_find)

	ex:
	my $dLenght = damerauLevenshteinLenght("llo wor", "Hello world");

	NOTE: 
	Return (int) distance between two strings

---------------------------------------------------------------------------------------------------

=cut

sub damerauLevenshteinLenght ($$) {
	my @arStr1 = strToArray(lc shift);
	my @arStr2 = strToArray(lc shift);
	
	
	my @DA;
	my @d;																							#	distance matrix
	
	my $cost = 0;
	my $strSum = scalar @arStr1 + scalar @arStr2;	
	
	$d[0][0] = $strSum;
	
	for my $indx (0..scalar @arStr1 + 1) {															#	Levenshtein matrix init ( x axe)
		$d[$indx + 1][1] =  $indx;
		$d[$indx + 1][0] =  $strSum;
	}
	
	for my $indx (0..scalar @arStr2 + 1) {															#	Levenshtein matrix init ( y axe)
		$d[1][$indx + 1] =  $indx;
		$d[0][$indx + 1] =  $strSum;
	}
	
	for my $index (0..94) { $DA[$index] = 0 };														# 94 : ascii printable char
	
	for my $i (1..scalar @arStr1 + 1) {
		my $DB = 0;
		print "\n";
		for my $j (1..scalar @arStr2 + 1) {
			
			my $i1 = $DA[$arStr2[$j - 1]];
			my $j1 = $DB;
			
			$cost = 1;
			
			$cost = 0 if $arStr1[$i - 1] eq $arStr2[$j - 1];
			
			$DB = $j if $cost == 0;
			
			$d[$i+1][$j+1] = min (	$d[$i][$j] + $cost, 
									$d[$i + 1][$j] + 1, 
									$d[$i][$j + 1] + 1, 
									$d[$i1][$j1] + ($i - $i1 - 1 ) + 1 + ($j - $j1 - 1 )
								);
								
			print $d[$i][$j]."   ";
		}
		$DA[$arStr1[$i - 1]] = $i;
	}
	return $d[scalar @d - 1][scalar @{ $d[0] } - 1];			
}	

1;
