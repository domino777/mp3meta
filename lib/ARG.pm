#!/usr/bin/perl
#getArg.pm
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

#       @author         : Mauro Ghedin
#       @contact        : domyno88 at gmail dot com
#       @version        : 0.2

use warnings;
use strict;

#----------------------------------------------------------------------------------
#	Return an array with separated argumens
#----------------------------------------------------------------------------------

sub getArgv {
	my @arguments;
	foreach (@_) {
		if(/^-/ && !/^--/) {
			s/-//;											# removing all dash for having only arguments
			while (1) {
				/^([a-zA-Z])/;								# take firs char
				defined $1 ? push @arguments, $1 : last;	# push or exit
				s/$1//g if defined $1;						# removing previous char's argumetns if it is defined
			}
		}
		elsif(/^--/) {										# getting argument with double dash
			s/--//;
			push @arguments, $_ unless !$_;
		}
		else {												# getting other argument
			push @arguments, $_;
		}
	}
return @arguments;
}

1
