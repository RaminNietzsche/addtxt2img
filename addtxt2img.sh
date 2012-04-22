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
#Txt_Font=""
#Sub_Font=""
Txt_Font="-font"
Txt_Font=${Txt_Font}" /usr/share/fonts/truetype/freefont/FreeSans.ttf"
Sub_Font="-font"
Sub_Font=${Sub_Font}" /usr/share/fonts/truetype/freefont/FreeMonoBold.ttf"
Txt_Color="red"
Sub_Color="red"
Txt_Font_Size=20
Sub_Font_Size=10
Txt="Ramin.Najarbashi@Gmail.Com"
Sub="`date +%a-%m-%Y`"

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
			convert -pointsize $Txt_Font_Size -fill $Txt_Color $Txt_Font -draw 'text '$X1','$Y1' '$Txt' ' -pointsize $Sub_Font_Size -fill $Sub_Color $Sub_Font -draw 'text '$X2','$Y2' '$Sub' ' $f $f
			echo $Sub_Font
		fi 
done 

for _arg in 
