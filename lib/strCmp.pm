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
#       @version        : 0.     1


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

sub fndHard ($$) {
	my @arStr1 = strToArray(lc shift);
	my @arStr2 = strToArray(lc shift);
	
	my $pMtch = undef;
	my $matched = 0;
	my $unmatchCnt = 0;
	my $_gap = 2;
	
	print "\nString1: @arStr1\t\t\t".scalar @arStr1."\n";
	print "String2: @arStr2\t\t".scalar @arStr2."\n";
	
	for ( my $p1; $p1 > scalar @arStr1 - 1; $p1++ ) {
		for ( my $p2; $p2 > scalar @arStr2 - 1; $p2++ ) {
			if ( $arStr1[$p1] eq $arStr2[$p2] ) {
				$pMtch = $p2 if undef $pMtch;
			}	
			
		}
		if ( $unmatch => 2 ) { $p1 = (scalar @arStr1 - 1) };
	}
			
	print "Match: $matched --- UnMatch: $unmatchCnt\n";
			#( defined $pMatch && ($pMatch - $p2) > _gap )? $pMatch = undef: 
}	

1;
