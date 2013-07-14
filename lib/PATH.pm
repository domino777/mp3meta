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
#       @version        : 0.3

use warnings;
use strict;


sub fileTypeRegex (\@){
		my $exts = shift;
		
		my $regex;
				
		if (defined !@$exts) {
			foreach my $ext (@$exts) {				#	regex preparation
					$regex .= $ext."|";
			}		
			$regex =~ s/\|$//;
		}
		else {
			$regex = "*";
		}
		$regex;
}

#-------------------------------------------------------------------------------------------------------------
#	Folder navigation
#
#	lsFolder(string: path, int: recursive_mode, string: file_format)
#
#	ex:
#	my @pathlist = lsFolder("/home/my/music");
#
#	NOTE: 
#	return file inside given folder and sub folder
#
#-------------------------------------------------------------------------------------------------------------

sub lsFolder {
#	function arguments		
		my $mainPath = shift;

#	local var
		my @fileHNDLs;
		my @files;
		my $path = "";
		
		opendir(my $mainPathHNDL, $mainPath) || die "unable to read the $mainPath directory\n";
		
		push @fileHNDLs, $mainPathHNDL;
		
		print "$mainPath\n";
		
		while ((scalar @fileHNDLs) > 0) {
			
			#	reading inside folder
				$_ = readdir($fileHNDLs[scalar @fileHNDLs - 1]);

				if (!defined $_) {
					$path =~ s/\/([^\/]*)$//;
					closedir $fileHNDLs[scalar @fileHNDLs - 1];
					pop @fileHNDLs;		#	return to previous file handler
					next;				#	up and recheck
				}
				
				my $relative = $mainPath.$path."/".$_;
				$relative =~ s/\/+/\//g;
				
			#	saving regular file into the array
				if( -f $relative) {
					push @files, $relative;
				}
				elsif( -d $relative && $_ ne "." && $_ ne "..") {
					$path .="/".$_;		# append folder finded
					opendir(my $_tempfHNDL, $mainPath.$path);
					push @fileHNDLs, $_tempfHNDL;
				}
		}
		
		@files;
}

#-------------------------------------------------------------------------------------------------------------
#	Count the number of each given extension inside the given array directory
#
#	fileStat(string: path, int: recursive_mode, string: file_format)
#
#	ex:
#	my %pathlist = fileStat("/home/my/music", 0, ".mp3|.ogg");
#
#	NOTE: 
#	qualcosa da scrivere
#
#-------------------------------------------------------------------------------------------------------------

sub fileStat (\@\@) {					
		my $files = shift;							#	file list
		my $ext	= shift;							#	extensions to find
		
		my %statistics;
		my $regex;
				
		foreach my $extType (@$ext) {				#	hash preparation
				$statistics{$extType} = 0;
				$regex .= $extType."|";
		}		
		$regex =~ s/\|$//;

		foreach my $file (@$files) {
			if (-f $file && $file =~ /(\.)($regex)$/) {
				$statistics{$2}++;
			}
		}
				
		return %statistics;
}


1
