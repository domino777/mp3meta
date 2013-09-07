#!/usr/bin/perl
#base.pm
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

=pod

---------------------------------------------------------------------------------------------------

=head3	min & max

	min(value1, value2, ...)
	max(value1, value2, ...)

	ex:
	my $val = max($val1, $val2, $val3, @vals);

	NOTE: 
	Return the minimum/maximum value in a given range of value

---------------------------------------------------------------------------------------------------

=cut

sub min {
	
	my $val		= shift;
	
	while (1) {
		my $valNxt	= ( @_ ? shift : return $val );
		$val = $valNxt if $val > $valNxt;
	}
}

sub max {
	
	my $val		= shift;
	
	while (1) {
		my $valNxt	= ( @_ ? shift : return $val );
		$val = $valNxt if $val < $valNxt;
	}
}

1;
