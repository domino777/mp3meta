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


#-------------------------------------------------------------------------------------------------------------
#	Creating regex rules from array
#
#	fileTypeRegex(arrString)
#
#	ex:
#	my $regexRules = fileTypeRegex(@values);
#
#	NOTE: 
#	return a string into scalar from array of given value:	$regex -> "val1|val2|val2"
#
#-------------------------------------------------------------------------------------------------------------

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
			$regex = "";
		}
		$regex;
}

#-------------------------------------------------------------------------------------------------------------
#	Folder navigation
#
#	lsFolder(string: path, int: recursive_mode)
#
#	ex:
#	my @pathlist = lsFolder("/home/my/music", 1);
#
#	NOTE: 
#	return file inside given folder and sub folder (if selected)
#
#-------------------------------------------------------------------------------------------------------------

sub lsFolder {
#	function arguments		
		my $mainPath = shift;
		my $recursive = shift || 0;

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

				if (!defined $_) {										# if $_ is undefined, readdir have reaced the end of the folder at selected handler
					$path =~ s/\/([^\/]*)$//;							# return to previous folder
					closedir $fileHNDLs[scalar @fileHNDLs - 1];
					pop @fileHNDLs;										# return to previous file handler
					next;												# up and recheck
				}
				
				my $relative = $mainPath.$path."/".$_;					# completing full path
				$relative =~ s/\/+/\//g;								# cleaning from multiple /
				
		#	saving regular file into the array
				if( -f $relative) {
					push @files, $relative;								# saving file into array
				}
				elsif( -d $relative && $_ ne "." && $_ ne "..") {		# . .. discrimination
					push @files, $relative;								# saving folder into array
					
					if($recursive != 0) {
						$path .="/".$_;									# append folder finded
						opendir(my $_tempfHNDL, $mainPath.$path);		# opend new for recursivering mode
						push @fileHNDLs, $_tempfHNDL;					# save current folder handler
					}
				}
		}
		
		@files;
}

#-------------------------------------------------------------------------------------------------------------
#	Count the number of extension on given array
#
#	fileStat(string: path, int: recursive_mode, string: file_format)
#
#	ex:
#	my %pathlist = fileStat("/home/my/music", 0, ".mp3|.ogg");
#
#	NOTE: 
#	Return an hash cointain file tipe as argument and countig as value of the key
#
#-------------------------------------------------------------------------------------------------------------

sub fileStat (\@\@) {					
#	function argument
		my $files = shift;								#	file list
		my $exts = shift;								#	extensions to find
		
#	local var
		my %statistics;
		my $regex = fileTypeRegex(@$exts);				#	regex rules creation
		
		foreach my $file(@$files) {
			if ( -f $file) {
				$file =~ /([a-zA-Z0-9]*)$/;
				my $ext = lc $1;						# get file extension
				if( $ext ne "" && ( defined $regex && $ext =~ /$regex/i ) || ( !defined $regex && $ext =~ /^[^0-9]/ )) {
					exists $statistics{$ext} ? ($statistics{$ext} = $statistics{$ext} + 1) : ($statistics{$ext} = 1);
				}
			}
		}
		return %statistics;
}


1
