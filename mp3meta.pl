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
#package class::mp3info;

use warnings;
use strict;

#	Loading external library
use MP3::Tag;

#	Loaging mp3meta library
use lib::ARG;;
use lib::PATH;
use lib::MP3;

use threads;
use threads::shared;
use class::mp3info;



# ------------   Curses TEST START  -------------------------

#use Curses::UI;

#my $curs = Curses::UI->new(_clear_on_exit => 1);

#$curs->mainloop;

#$curs->dialog("prova");

# ------------   Curses TEST END    -------------------------


my @arg = getArgv(@ARGV);

my @fileExt = ("mp3", "ogg");

print "Getting file from folder  ";

print "\nRetriveing files infromation... ";

my @files = lsFolder($arg[0], 1, 1);


#my @stat = fileStat(@files, @fileExt);

my @mp3sObj;

print "\n---------------------- CLASS --------------------\n";

foreach my $file (@files) {
	if (-f $file && $file =~ /\.mp3$/){
		my $obj = mp3info->new($file);
		push @mp3sObj, $obj;
		@mp3sObj[(scalar @mp3sObj) - 1]->fileInit();
	}
}


my @stat =  mp3stat(@mp3sObj, "album", 1);

foreach (@stat) {
	print "$_\n";
}
 
#my $obj = mp3info->new("/run/media/domyno/Elements/Documenti/MusicTst/Fish_-_Robe_Grosse-2005-MSC/01_Grossa_Feat.Esa-MSC.mp3");
#print $obj->getPath();
#$obj->fileInit();
#$obj->getInfo("artist");
#print $obj->getTitle();
#print "\n";
print "-------------------- CLASS END  -----------------\n";
	
#my @res2 = $thr1->join();

#print "\nProcess completed\n";


#my @data = TagContentMatcher(@{$TagStat->[2]}, "bassimaestro");

#print "@files\n";
#foreach (@files) {
#		print "$_\n";
#}

#print scalar @files."\n";
#foreach my $key (keys %stat) {
#	print "$key: \t\ $stat{$key}\n";
#}
