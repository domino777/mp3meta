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


#---------------------------------------------------------------------------------------------------
#	Find literally a string into an other
#
#	fndLiteral(string: string_to_find, string: string_were_find)
#
#	ex:
#	my $found = fndLiteral("llo", "Hello world");
#
#	NOTE: 
#	Return 1 if string is fount into the other string
#
#---------------------------------------------------------------------------------------------------

sub fndLiteral ($$) {
	$str1 = shift;	#	string to find
	$str2 = shift;	#	string were find
	
	return ( $str2 =~ /$str1/ig ? 1 : 0);		#	return true if str1 is in str2
}

1;
