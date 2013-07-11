#!/usr/bin/perl
#perly.pl
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
#       @version        : 3.0-beta-1

# TODO
#       Aggiungere le chiavi da rimuovere da file txt esterno .lst
#       Gestire erro (fatto) -- gestire u' errori
#       Aggiungere lista estensioni da controllare in .cfg
#       Scrivere man
#       deafult da .cfg?
#       LOG?

use warnings;
use strict;

sub getArgv {
	my @arguments;
	foreach (@_) {
		if(/^-/ && !/^--/) {
			s/-//;					# removing all dash for having only arguments
			while (1) {
				s/$1//g if defined $1;
				/^([a-zA-Z])/;			# take firs char
				defined $1 ? push @arguments, $1 : last;
			}
		}
		elsif(/^--/) {
			s/--//;
			push @arguments, $_ unless !$_;
		}
	}
return @arguments;
}
