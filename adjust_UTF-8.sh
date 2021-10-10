#!/bin/bash

# filename: adjust_UTF-8.sh
# author: @leodrivera

Help(){
#Show Help

## `cat << EOF` This means that cat should stop reading when EOF is detected
cat << EOF
Script for adjusting between UTF-8 with BOM and without BOM

The default UTF-8 type is without BOM

Usage: ./adjust_UTF-8.sh [-bv] -f <File or Folder> -c <File or Folder>

-b,		--BOM,			Convert to UTF-8 with BOM type.

-e,		--extension,		Define extension for checking in the folder (default = srt)

-c,		--check,		Check if a file or the files in a folder is UTF-8 BOM ou UTF-8.

-f,					To chose a folder to change all the files in it or to chose a file to change it only.

-v,		--verbose,		Run script in verbose mode

-h,		--help,			Display help

EOF
# EOF is found above and hence cat command stops reading. This is equivalent to echo but much neater when printing out.
}


# $@ is all command line parameters passed to the script.
# -o is for short options like -v
# -l is for long options with double dash like --version
# the comma separates different long options
options=$(getopt -l "bom,extension:,check:,file:,verbose,help" -o "be:c:f:vh" -n 'Please refer to help' -- "$@")

# set --:
# If no arguments follow this option, then the positional parameters are unset. Otherwise, the positional parameters 
# are set to the arguments, even if some of them begin with a -.
eval set -- "$options"

verbose=0
bom=0
extension='srt'

convert() {
	if [ $bom -eq 1 ]; then
		#Add the \xEF\xBB\xBF hex codes in the beginning of the file, transforming it into BOM.
		sed -i '1s/^/\xef\xbb\xbf/' $1
		[ $verbose -eq 1 ] &&  echo "File $1 converted to UTF-8 BOM"
	else
		#Remove the \xEF\xBB\xBF hex codes from the beginning of the file.
		sed -i 's/\xef\xbb\xbf//' $1
		[ $verbose -eq 1 ] &&  echo "File $1 converted to UTF-8"
	fi
}

while true
	do
		case $1 in
			-b|--BOM) 
			   #UTF-8 with BOM type
			   bom=1
			   [ $verbose -eq 1 ] &&  echo "Selected UTF-8 with BOM"
			   ;;
			   
			-v|--verbose) 
				#Set Verbose true
				verbose=1
				#set -xv
				;;
			
			-e|--extension)
				#Chose extension
				shift
				extension=$1
				;;
				
			-c|--check)
				#Check if the file has UTF-8 BOM
				shift
				asset=$1
				if [ -d $asset ]; then
					for file in $asset'/'*$extension; do 
						[[ -f "$file" ]] || continue
						eval file $file
					done
				else
					eval file $asset
				fi
				;;
				
			-f)
				#Check if it's a file or a folder
				shift
				asset=$1
				if [ -d $asset ]; then
					for file in $asset'/'*$extension; do 
						[[ -f "$file" ]] || continue
						convert $file
					done
				else
					convert $asset
				fi
				;;
				 
			-h|--help) 
				# display Help
				Help
				exit 0
				;;
				
			--)
			shift
			break
			;;
			
			*)
			echo "Internal error!" 
			exit 1
			;;
		esac
		shift
	done
