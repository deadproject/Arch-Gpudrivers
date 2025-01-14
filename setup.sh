#!/usr/bin/env bash
#------------------------------------------------------------------------- 
#  █████╗ ██████╗  ██████╗██╗  ██╗ 
# ██╔══██╗██╔══██╗██╔════╝██║  ██║
# ███████║██████╔╝██║     ███████║ - Driver
# ██╔══██║██╔══██╗██║     ██╔══██║   
# ██║  ██║██║  ██║╚██████╗██║  ██║   
# ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
#-------------------------------------------------------------------------

echo -ne "
-------------------------------------------------------------------------
   █████╗ ██████╗  ██████╗██╗  ██╗ 
  ██╔══██╗██╔══██╗██╔════╝██║  ██║
  ███████║██████╔╝██║     ███████║ - Driver
  ██╔══██║██╔══██╗██║     ██╔══██║   
  ██║  ██║██║  ██║╚██████╗██║  ██║   
  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝
"

# Installing Graphics Drivers
echo -ne "
-------------------------------------------------------------------------
                    Installing Graphics Drivers
-------------------------------------------------------------------------
"
# Graphics Drivers find and install
gpu_type=$(lspci)
if grep -E "NVIDIA|GeForce" <<< ${gpu_type}; then
    pacman -S --noconfirm --needed nvidia
	nvidia-xconfig
elif lspci | grep 'VGA' | grep -E "Radeon|AMD"; then
    pacman -S --noconfirm --needed xf86-video-amdgpu
elif grep -E "Integrated Graphics Controller" <<< ${gpu_type}; then
    pacman -S --noconfirm --needed libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
elif grep -E "Intel Corporation UHD" <<< ${gpu_type}; then
    pacman -S --needed --noconfirm libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa
fi
#SETUP IS WRONG THIS IS RUN
if ! source $HOME/ArchTitus/configs/setup.conf; then
	# Loop through user input until the user gives a valid username
	while true
	do 
		read -p "Please enter username:" username
		# username regex per response here https://unix.stackexchange.com/questions/157426/what-is-the-regex-to-validate-linux-users
		# lowercase the username to test regex
		if [[ "${username,,}" =~ ^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$ ]]
		then 
			break
		fi 
		echo "Incorrect username."
	done 
# convert name to lowercase before saving to setup.conf
echo "username=${username,,}" >> ${HOME}/ArchTitus/configs/setup.conf

    #Set Password
    read -p "Please enter password:" password
echo "password=${password,,}" >> ${HOME}/ArchTitus/configs/setup.conf

    # Loop through user input until the user gives a valid hostname, but allow the user to force save 
	while true
	do 
		read -p "Please name your machine:" name_of_machine
		# hostname regex (!!couldn't find spec for computer name!!)
		if [[ "${name_of_machine,,}" =~ ^[a-z][a-z0-9_.-]{0,62}[a-z0-9]$ ]]
		then 
			break 
		fi 
		# if validation fails allow the user to force saving of the hostname
		read -p "Hostname doesn't seem correct. Do you still want to save it? (y/n)" force 
		if [[ "${force,,}" = "y" ]]
		then 
			break 
		fi 
	done 

    echo "NAME_OF_MACHINE=${name_of_machine,,}" >> ${HOME}/ArchTitus/configs/setup.conf

# Finalize Installation
echo -ne "
-------------------------------------------------------------------------
                      Installation Complete!
                    You can reboot your system.
-------------------------------------------------------------------------
"