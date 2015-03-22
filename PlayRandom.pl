#!/usr/bin/perl -w

use Cwd;
 
my $root= getcwd;  #an array of starting directories
my @fileList = [];

$total =  CountFilesInDirectory($root);
if ($total > 0) {
	$randFile = rand($total);
	print $fileList[$randFile] . "\n";
#	system("$fileList[$randFile]");
}

sub CountFilesInDirectory
{
	$dir = $_[0];

	my $count = 0;
	
	opendir(DIR, $dir) || die "Can't open directory: $dir!\n";


	my @files = grep { !/^\..*$/ } readdir (DIR);
	@files = map { $dir . '/' . $_ } @files;

    # Close the directory.
    closedir (DIR);
	
	for (@files) {
		$f = $_;
	
		if (-d $f) {
			$count = $count + CountFilesInDirectory($f);
		}
	   	else {
	   		if ($f =~ m/.*(\.avi|\.mkv|\.avi|\.mp4)$/) {
		   		$count = $count + 1;
#				print "$f\n";
				push(@fileList, $f)
				
	   		}
	   	}
	}	
	$count;
}