#!/usr/bin/perl
#strMatcher.pm
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

use lib::strCmp;

=pod

---------------------------------------------------------------------------------------------------

=head3	String comparation

	strCmp(string: string, string: string, int: %_matchMax, int: %_matchMin)

	ex:
	my $found = strCmp("llo wor", "Hello world");

	NOTE: 
	Return 1 if the strings match
	Return 2 if the strings match without space or not-alphanumeric chars
	Return 3 if the match value is more then %_match
	
	Minimum string lenght for damerau-levenshtein algorithm is set to 4. String with less then 4
	are ignored and is compared only with fndLiteral and fndCollapse
	
	%_matchMax is applay for string with lenght more than 50 chars
	%_matchMin is applay for string with lenght equal to 4
	
	This range is adapted according with patter string

---------------------------------------------------------------------------------------------------

=cut

sub strCmp (\$\$) {
	my $str1	= shift;
	my $str2	= shift;
	my $maxSp		= shift || 90;
	my $minSp		= shift || 60;

	return 1 if fndLiteral($$str1, $$str2);
	return 2 if fndCollapse($$str1, $$str2);
	
	# Equality percentage computation
	
	my $str1Len = length($$str1);
	my $str2Len = length($$str2);
	
	my $DLd = damerauLevenshteinLenght($$str1, $$str2);
	$DLd	-= abs( $str1Len - $str2Len );
	
	print $$str1." ---- ". $$str2."\n\n";
	
	#return 3 if ( $sp <= ( $str1Len > $str2Len ? ($str2Len - $DLd) / $str2Len * 100 : ($str1Len - $DLd) / $str1Len * 100 ) && $$str1Len >= 4 $$str2Len >=4 );
	return ( $str1Len > $str2Len ? ($str2Len - $DLd) / $str2Len * 100 : ($str1Len - $DLd) / $str1Len * 100 );
	
	return 0;
}

1;
