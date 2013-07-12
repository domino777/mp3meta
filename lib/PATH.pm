#!/usr/bin/perl
#PATH.pml
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
#       @version        : 0.2

use warnings;
use strict;

#-------------------------------------------------------------------------------------------------------------
#	Folder navigation
#
#	lsFolder(string: path, int: recursive_mode, string: file_format)
#
#	ex:
#	my @pathlist = lsFolder("/home/my/music", 0, "*.mp3 *.ogg");
#
#	NOTE: 
#	qualcosa da scrivere
#
#-------------------------------------------------------------------------------------------------------------

sub lsFolder {					
        my $path = shift;
        my $recursive = shift;
	my $ext = shift || "*";
        my @files;

        $path =~ s/[\ \[\]]/[(\\\ )(\\\[)(\\\])]/g;
        $path =~ s/([^\/]$)/$1\//;

        foreach my $file (glob("$path*")) {
                if (-f $file && $file=~ /($ext)$/) {
                        push @files, $file;
                }
                elsif (-d $file) {
                        push @files, $file;
                        if ($recursive) {
                                push @files, lsFolder($file, $recursive, $ext);
                        }
                }
        }
        return @files;
}

1
