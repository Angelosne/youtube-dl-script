#!/bin/bash
#Define variables


#Define functions

download_and_convert () {
  echo "Paste (CTRL + SHIFT + V) the link of the video/playlist"
	read url
	youtube-dl -o '%(title)s.%(ext)s' -x --audio-format mp3 --audio-quality 5 $url
	echo "Download completed. Press any key to continue..."
  read
}

download_only () {
  echo "Paste (CTRL + SHIFT + V) the link of the video/playlist"
	read url
	youtube-dl -o '%(title)s.%(ext)s' $url
	echo "Download completed. Press any key to continue..."
  read
}

download_and_convert_subfolder() {
  echo "Paste (CTRL + SHIFT + V) the link of the video/playlist"
	read url
	youtube-dl -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' -x --audio-format mp3 --audio-quality 5 $url
	echo "Download completed. Press any key to continue..."
  read
}

download_only_subfolder() {
  echo "Paste (CTRL + SHIFT + V) the link of the video/playlist"
	read url
	youtube-dl -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' $url
	echo "Download completed. Press any key to continue..."
  read
}


main_menu() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo " M A I N - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Download and convert to mp3 a video/playlist"
	echo "2. Download a video/playlist"
  echo "3. Advanced menu"
	echo "4. Exit"
}

main_options() {
	local choice
	read -p "Enter choice [ 1 - 4] " choice
	case $choice in
		1) download_and_convert ;;
		2) download_only ;;
    3) advanced_menu ;;
    4) exit 0;;
		*) echo -e "Invalid option. Press any key to try again" && read;;
	esac
}

advanced_menu() {
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo " A D V A N C E D - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "1. Download and convert to mp3 a playlist creating subfolder"
	echo "2. Download a playlist creating subfolder"
  echo "3. Back to main menu"
	echo "4. Exit"
  advanced_options
}

advanced_options() {
  local choice
	read -p "Enter choice [ 1 - 4] " choice
	case $choice in
	    1) download_and_convert_subfolder ;;
	    2) download_only_subfolder ;;
      3) show_menus ;;
      4) exit 0;;
	    *) echo -e "Invalid option. Press any key to try again" && read
      advanced_menu;;
	esac
}



#Main program
while true
do
#Menu
main_menu
#choose option
main_options

done
