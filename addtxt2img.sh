#========================================================================================
#                          ____                 _       				#
#                         |  _ \ __ _ _ __ ___ (_)_ __  				#
#                         | |_) / _` | '_ ` _ \| | '_ \ 				#
#                         |  _ < (_| | | | | | | | | | |				#
#                         |_| \_\__,_|_| |_| |_|_|_| |_|				#
#                                                       				#
#              _   _        _  _            _               _     _ 			#
#             | \ | | __ _ (_)(_) __ _ _ __| |__   __ _ ___| |__ (_)			#
#             |  \| |/ _` || || |/ _` | '__| '_ \ / _` / __| '_ \| |			#
#             | |\  | (_| || || | (_| | |  | |_) | (_| \__ \ | | | |			#
#             |_| \_|\__,_|/ |/ |\__,_|_|  |_.__/ \__,_|___/_| |_|_|			#
#                        |__/__/                                   			#
#											#
# Add Text to Pictures : 20-April-2012							#
# Ramin.najarbashi@Gmail.com								#
# Version : 0.00 beta									#
#========================================================================================

#! /bin/bash

X_Size=0 # width
Y_Size=0 # height
My_Loc="`pwd`"
Txt_Font=""
Sub_Font=""
#Txt_Font="-font"
#Txt_Font=${Txt_Font}" /usr/share/fonts/truetype/freefont/FreeSans.ttf"
#Sub_Font="-font"
#Sub_Font=${Sub_Font}" /usr/share/fonts/truetype/freefont/FreeMonoBold.ttf"
Txt_Color="red"
Sub_Color="red"
Txt_Font_Size=20
Sub_Font_Size=10
Txt="Ramin.Najarbashi@Gmail.Com"
Sub="`date +%a-%m-%Y`"
X1=0 # For main Text
X2=0 # For Sub Text	
Y1=0 # For main Text
Y2=0 # For Sub Text

function Drow_Text
{
	for f in $My_Loc/*
	do
	#	File_Ext="`echo $f | rev | cut -d. -f1 | rev`"  # Find File extention
		File_Ext="`file $f | awk {'print $2'}`" #Find File Type
		if [ "$File_Ext" == "PNG" -o "$File_Ext" == "JPEG" -o "$File_Ext" == "GIF" ]
		then
			X_Size=`identify $f | awk {'print $3'} | cut -dx -f1`
			Y_Size=`identify $f | awk {'print $3'} | cut -dx -f2`
			let Y1=$Y_Size-20
			let Y2=$Y1+10
			X1=10
			X2=10
			convert -pointsize ${Txt_Font_Size} -fill ${Txt_Color} ${Txt_Font} -draw "text $X1,$Y1 \"$Txt\""  -pointsize ${Sub_Font_Size} -fill ${Sub_Color} ${Sub_Font} -draw "text $X2,$Y2 \"$Sub\""  $f $f
			echo -e "\e[1;32mFile $f Size :($X_Size, $Y_Size).... OK!"
		fi 
	done 
}


function Get_Arg
{
	read -p "Please Enter Directory (Leave Blank for current Directory): "  Run_Dir
	if [ "$Run_Dir" != "" ]
	then
		if [ -d $Run_Dir ]
		then
			My_Loc="$Run_Dir"
			echo $My_Loc
		else
			Show_Help "DirErr"
		fi
	fi
	Get_Font "Main"
	Get_Color "Main"
	Get_Size "Main"
	Get_Text "Main"
	Get_Font "Sub"
	Get_Color "Sub"
	Get_Size "Sub"
	Get_Text "Sub"	
}

function Get_Font
{
	read -p "Enter $1 Font name (Use 'L' to display Font List or 'R' for select Random) : " tmpfnt
	identify -list font | grep "Font:" | cut -d: -f2 | grep "^ $tmpfnt$" 1> /dev/null 2>&1
	if [ $? -eq 0 ]
	then
		if [ "$1" == "Main" ]
		then
			Txt_Font="-font "
			Txt_Font="$Txt_Font""$tmpfnt"
		else
			Sub_Font="-font "
			Sub_Font="$Sub_Font""$tmpfnt"
		fi
	elif [ "$tmpfnt" == "L" ]
	then
		identify -list font | grep "Font:" | cut -d: -f2 | less
		Get_Font $1
	elif [ "$tmpfnt" == "R" ]
	then
		Fnt_Lst=`identify -list font | grep "Font:" | cut -d: -f2`
		Fnt_Arr_Lst=($Fnt_Lst)
		Fnt_Arr_Lst_Count=${#Fnt_Arr_Lst[*]}
		randfnt="${Fnt_Arr_Lst[$((RANDOM%Fnt_Arr_Lst_Count))]}"
		if [ "$1" == "Main" ]
		then
			Txt_Font="-font "
			Txt_Font="$Txt_Font""$randfnt"
		else
			Sub_Font="-font "
			Sub_Font="$Sub_Font""$randfnt"
		fi
	else
		echo -e "\e[1;33mFont ('$tmpfnt') not found... \e[0m"
		Get_Font $1
	fi
}

function Get_Color
{
	read -p "Enter $1 Font Color name (Use 'L' to display Font List or 'R' for select Random) : " tmpclr
	identify -list color | awk {'print $1'} | grep "^$tmpclr$" 1> /dev/null 2>&1
#	echo $tmpclr
#	echo $?
	if [ $? -eq 0 ]
	then
		if [ "$1" == "Main" ]
		then
			Txt_Color="$tmpclr"
		else
			Sub_Color="$tmpclr"
		fi
	elif [ "$tmpclr" == "L" ]
	then
		tmpcount=`identify -list color | wc -l`
		let tmpcount=tmpcount-5
		identify -list color | awk {'print $1'} | tail -"$tmpcount" | less 
		Get_Color $1
	elif [ "$tmpclr" == "R" ]
	then
		tmpcount=`identify -list color | wc -l`
		Clr_Lst=`identify -list color | awk {'print $1'} | tail -"$tmpcount"`
		Clr_Arr_Lst=($Clr_Lst)
		Clr_Arr_Lst_Count=${#Clr_Arr_Lst[*]}
		randclr="${Clr_Arr_Lst[$((RANDOM%Clr_Arr_Lst_Count))]}"
		if [ "$1" == "Main" ]
		then
			Txt_Color="$randclr"
		else
			Sub_Color="$randclr"
		fi
	else
		echo -e "\e[1;33mColor ('$tmpclr') not found...\e[0m"
		Get_Color $1
	fi
	
}

function Get_Size
{
	read -p "Enter $1 Font Size (Enter 0 to use Defullt) : " tmpsiz
	echo $tmpsiz | grep "^[0-9]*$"  1> /dev/null 2>&1
	if [ $? -eq 0  ]
	then
		if [ "$1" == "Main" -a "$tmpsiz" != "0" ]
		then
			Txt_Font_Size="$tmpsiz"
		elif [ "$tmpsiz" != "0" ]
		then
			Sub_Font_Size="$tmpsiz"
		fi
	else
		Show_Help "SizErr"
		Get_Size $1
	fi
}


function Get_Text
{
	read -p "Enter $1 Text (Leave Blank to use Defullt) : " tmptxt
	if [ "$tmptxt" != ""  ]
	then
		if [ "$1" == "Main" ]
		then
			Txt="$tmptxt"
		else
			Sub="$tmptxt"
		fi
	fi
}

function Show_Help()
{
	echo -e "\e[1;31mheeeeeeeeeeeeeeeeeeeeeeeeeeeeelp\e[0m"
	if [ "$1" == "DirErr" ]
	then
		echo -e -e "\e[1;31mDirectory Not Found ...\e[0m"
		exit
	elif [ $1 == "SizErr" ]
	then
		echo -e "\e[1;31mFont Size must be number : 1, 2, 3, 4, 5, 6, ..., 50, 51, ... ok? :D\e[0m"
	fi
}

Get_Arg "$@"
Drow_Text
