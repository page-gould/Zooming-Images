#!/usr/bin/perl -w

# Copyright (c) Elizabeth Page-Gould

use strict;

makeZoomingGIFs();

sub makeZoomingGIFs {
    my ($iterations,$delay);
    if ($#ARGV != -1) {
        print "Hey!";
        $iterations = $ARGV[0];
        $delay = $ARGV[1];
    }
    else {
        $iterations = 10;
        $delay = 100;
    }
    print "Will make $iterations frames per movie with $delay ms per frame\n";
    my $imageArrayRef = gatherImages();
    my @pics = @{$imageArrayRef};
    setupEnvironment();
    foreach my $pic (@pics) {
        generateImageSizes($pic,$iterations);
        convertToGIF($pic,$delay);
        cleanUp();
    }
    system("rm -r temp/");
}

sub gatherImages {
    if (-e "Images/") {print "Found Images/ directory ... good :)\n";}
    else {print "Can\'t find images to convert to .mpg ... please create a directory named \"Images\", copy the images you want to convert into that directory, and run this script again. If this script doesn't seem to recognize an existing Images/ directory, kindly email liz\@psych.utoronto.ca\n";}
    opendir (DIR,"Images/") or die $!, "Couldn\'t open Images directory for processing\n";
    my @imageArray = grep(/[jpg|jpeg|bmp|png]$/i,readdir(DIR)) or die "Couldn't get list of images from the Images directory. Make sure the images are in a subdirectory called Images, and they are either in JPEG, bitmap, or PNG format.\n";
    closedir (DIR) or die $!, "Couldn\'t properly close directory after reading\n";
    print "Found and will process these images:\n";
    foreach my $item (@imageArray) {
        chomp $item;
        print "  .. $item\n";
    }
    return (\@imageArray);
 }

sub setupEnvironment {
    if (-e "temp/") {
        if (-e "temp/*") {
            system (`rm temp/*`);
            print "Found temp/ and emptied it ... good!  :)\n";
        }
        else {
            print "Found temp/ and it was already emptied... good!  :)\n";
        }
    }
    else {
        system (`mkdir temp`);
        print "Created temp\/ ... all good. :)\n";
    }
    if (-e "Movies/") {print "Found Movies/ ... good!  :)\n";}
    else {
        system (`mkdir Movies`);
        print "Created Movies\/ ... all good. :)\n";
    }
}

sub generateImageSizes {
    my ($imageName,$iterations) = @_;
    print "Beginning $imageName ...\n";
    my $width = `identify -format \"%w\" Images/${imageName}`;
    my $height = `identify -format \"%h\" Images/${imageName}`;
    my $ratio = $height / $width;
    my ($maxHeight) = ($height * 3);
    my ($maxWidth) = ($width * 3);
    my $minHeight = $height/2;
    my $minWidth = $width/2;
    my $heightIncrement = ($maxHeight - $minHeight)/$iterations;
    my $widthIncrement = ($maxWidth - $minWidth)/$iterations;
    my $count = $iterations;
    my $fileName;
    my $currWidth = $maxWidth;
    my $currHeight = $maxHeight;
    while ($count > 0) {
        if ($count < 10) {$fileName = "0"."$count"."$imageName";}
        else {$fileName = "$count"."$imageName";}
        $currWidth = $currWidth - $widthIncrement;
        $currHeight = $currHeight - $heightIncrement;
	if ($currHeight >= $height) {system("convert Images\/${imageName} -resize ${currWidth}x${currHeight} -gravity Center -crop \"${width}x${height}+0+0\"\\! temp\/${fileName}");}
	else {
	  my $bHeight = ($height - $currHeight)/2;
	  my $bWidth = ($width - $currWidth)/2;
	  system("convert Images\/${imageName} -resize ${currWidth}x${currHeight} -fill white -gravity Center -border ${bWidth}x${bHeight} -size \"${width}x${height}+0+0\" -gravity Center -crop \"${width}x${height}+0+0\"\\! temp\/${fileName}");
	}
        print "  .. made $fileName with width of $currWidth and height of $currHeight\n";
        $count--;
    }
    print "Finished Manipulating Image: $imageName\nWill begin converting to .gif ...\n";
}

sub convertToGIF {
    my $name = $_[0];
    my $delay = $_[1];
    $name =~ s/\.jpg$//i;
    $name =~ s/\.jpeg$//i;
    $name =~ s/\.bmp$//i;
    $name =~ s/\.png$//i;
    $name =~ s/$/.gif/;
    system("convert -delay ${delay}x1000 temp\/\* Movies\/${name}");
    print "Finished Making Zooming GIF: $name\n";
}

sub cleanUp {
    system(`rm temp/*`);
}
