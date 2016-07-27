Copyright (c) Elizabeth Page-Gould


LICENSE: MIT License


PURPOSE:
Convert JPEG/PNG/bitmap images into GIFs which zoom each picture so it looks like the image is coming toward the screen                      


DEPENDENCIES:
You must install the following programs on your Unix system. If you have a mac, then you should install Homebrew by following the directions below. If you are trying to run this program on Windows, I suggest you install cygwin (http://www.cygwin.com/) 
    1. perl, at least version 5.8                                 
    2. imagemagick                                                
        2.1. On Linux or Unix: `sudo apt-get install imagemagick`.
        2.2. On Mac with Homebrew: `sudo port install imagemagick`
        2.3. On Windows with cygwin: install "imagemagick" from the package GUI                                           


USAGE:
To convert a group of pictures into zooming GIFs:                      

1. Copy this script somewhere on your computer                          
2. Allow the file to be executable (e.g., "chmod 755 zoom.pl")          
3. Make a subdirectry called "Images/" and place all your images in the Images/ directory                                                    
4. Invoke the script with no arguments or two arguments. In order, the two arguments should be:
    4.1. The number of desired frames per video. Default is 10 frames per movie.
    4.2. The length of time each frame should be shown in milliseconds. Default is 100 milliseconds or a tenth of a second.
5. BE PATIENT ... this will take a while if it works correctly      
6. The file will create a subdirectory named 'Movies/' with the zooming GIF files  


CREATED AND MAINTAINED BY:
Elizabeth Page-Gould
http://page-gould.com
liz@psych.utoronto.ca

CITED IN:
Gruber, J., Fischer, J., Page-Gould, E., & Johnson, S. (2016). Too close for comfort? Social distance and emotion perception in remitted Bipolar I Disorder. Manuscript submitted for publication.