#!/bin/bash
#Define variables


#Define functions

download_and_convert () {
  echo "Paste (CTRL + SHIFT + V) the link of the video/playlist"
	read url
	youtube-dl -o '%(title)s.%(ext)s' -x --audio-format mp3  $url
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
	youtube-dl -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' -x --audio-format mp3 $url
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
  echo "3. Give URL for more info"
  echo "4. Back to main menu"
	echo "5. Exit"
  advanced_options
}

advanced_options() {
  local choice
	read -p "Enter choice [ 1 - 5] " choice
	case $choice in
	    1) download_and_convert_subfolder ;;
	    2) download_only_subfolder ;;
      3) get_url && url_menu;;
      4) show_menus ;;
      5) exit 0;;
	    *) echo -e "Invalid option. Press any key to try again" && read
      advanced_menu;;
	esac
}

get_url() {
  clear
  read -p "Paste (CTRL + SHIFT + V) URL: " url
}

url_menu() {
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~"
	echo " U R L - M E N U"
	echo "~~~~~~~~~~~~~~~~~~~~~"
  echo "1. Show titles of playlist"
	echo "2. Count"
  echo "3. Back to main menu"
  echo "4. Back to advanced menu"
	echo "5. Exit"
  url_options
}

url_options() {
  local choice
	read -p "Enter choice [ 1 - 5] " choice
	case $choice in
		1) show_titles ;;
		2) count ;;
    3) main_menu ;;
    4) advanced_menu;;
    5) exit 0;;
		*) echo -e "Invalid option. Press any key to try again" && read
    url_menu;;
	esac
}

count(){
  youtube-dl --flat-playlist $url | grep "Downloading .* videos" | awk -F " " '{print "There are "$6" "$7}'

  echo "Press any key to continue..."
  read
}
show_titles(){
  youtube-dl -e $url
  echo "Download completed. Press any key to continue..."
  read
}

#Main program
while true
do
#Menu
main_menu
#choose option
main_options

done
