#!/usr/bin/perl
#mp3meta
#
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
#
#       @author         : Mauro Ghedin
#       @contact        : domyno88 at gmail dot com
#       @version        : 0.1

use warnings;
use strict;

#	Loading external library
use MP3::Tag;

#	Loaging mp3meta library
use lib::ARG;;
use lib::PATH;

my @arg = getArgv(@ARGV);

my @fileExt = ("mp3", "rar", "jpg", "ace");

#my @files = lsFolder($arg[0], 1, @fileExt);

my @files = lsFolder($arg[0]);

my %stat = fileStat(@files, @fileExt);

#print "@files\n";
foreach (@files) {
		print "$_\n";
}

print scalar @files."\n";
foreach my $key (keys %stat) {
	print "$key: \t\ $stat{$key}\n";
}
#print "@files\n";

#$ARGV[0] =~ s/[\ \[\]]/[(\\\ )(\\\[)(\\\])]/g;

#foreach ( glob($ARGV[0]."*.mp3") ) {
#	print "$_\n";
#	my $mp3File = MP3::Tag->new($_);
#
#	my @mp3Data = $mp3File->autoinfo();
#
#	print "@mp3Data\n\n";
#}
