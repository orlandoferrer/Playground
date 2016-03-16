#!/bin/bash 
sourcepath=“/insert/path/of/WD/NAS/”    # i.e. ”/dev/sdb4:/"
destinationpath=“/insert/path/of/destionation/HD/”    # i.e. “/mnt/hgfs/NAScopy/" #


FILE=/path/to/file/with/filenames/exported/from/RLinux.txt    #i.e. /mnt/hgfs/NAScopy/tree.txt


echo "################################"
k=1
while read line;do
        echo "Line # $k"

		lastchar="${line:(-1)}"
			
		if [ "$lastchar" == "/" ]   #crete folder if entry is a directory 
		then
			#create folder
			echo "this is a FOLDER"
			mkdir -p "$line" 
		
		else
			#copy file
			sourcedir="$sourcepath$line" #need double quotes in full pathname
			destdir=$(dirname "$line") #extract directory 
			destdir="$destinationpath$destdir"
			sudo e2cp -v "$sourcedir" -d "$destdir"
			#echo sudo e2cp -v "$sourcedir" -d "$destdir"

		fi


        ((k++))

done < $FILE
echo “Copied all $k files”