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
#			let Y1=$Y_Size-20
#			let Y2=$Y1+10
#			X1=10
#			X2=10
			echo convert -pointsize ${Txt_Font_Size} -fill ${Txt_Color} ${Txt_Font} -draw \'text $X1,$Y1 $Txt\'  -pointsize ${Sub_Font_Size} -fill ${Sub_Color} ${Sub_Font} -draw \'text $X2,$Y2 $Sub\'  $f $f
		fi 
	done 
}


function Get_Arg
{
	_args=("$@")
	Arg_Count=0

	for _arg in $@
	do
#		let Arg_Count=Arg_Count+1
		case $_arg in
			-t)
				echo ${_args[$Arg_Count+1]} | grep "^-" 1> /dev/null 2>&1
				if [ $? -eq 0 ]
				then
					echo "Invalid Arguman!!! -t ${_args[$Arg_Count]}"
					Show_Help
					exit
				fi
				Txt="\""
				Txt="${Txt}""${_args[$Arg_Count+1]}""${Txt}"
				echo $Txt
				let tmp=Arg_Count+1
				while [  $tmp -lt $# ]
				do
					case "${_args[$tmp]}" in
						-s)
							break
						;;
						--help)
							break
						;;
						-f)
                                                        echo ${_args[$tmp+1]} | grep "^-" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                echo "Invalid Arguman!!! -f ${_args[$tmp+1]}"
                                                                Show_Help
                                                                exit
                                                        fi
							ls ${_args[$tmp+1]} 1> /dev/null 2>&1
							if [ $? -eq 0 ]
							then 
								Txt_Font="-font "
								Txt_Font="$Txt_Font"" ${_args[$tmp+1]}"
								echo $Txt_Font
							else
								echo "This Font dose not exist!!!"
								Show_Help
								exit
							fi
						;;
						-p)
                                                        echo ${_args[$tmp+1]} | grep "^-" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                echo "Invalid Arguman!!! -p ${_args[$tmp+1]}"
                                                                Show_Help
                                                                exit
                                                        fi
							echo ${_args[$tmp+1]} | grep "^[0-9]*$" 1> /dev/null 2>&1
							if [ $? -eq 0 ]
							then
								Txt_Font_Size="${_args[$tmp+1]}"
								echo $Txt_Font_Size
							else
								echo "Enter Valid FontSize!!!"
								Show_Help
								exit
							fi
						;;
						-x)
                                                        echo ${_args[$tmp+1]} | grep "^-" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                echo "Invalid Arguman!!! -x ${_args[$tmp+1]}"
                                                                Show_Help
                                                                exit
                                                        fi
                                                        echo ${_args[$tmp+1]} | grep "^[0-9]*$" 1> /dev/null 2>&1
							if [ $? -eq 0 ]
                                                        then
                                                                X1="${_args[$tmp+1]}"
								echo $X1
                                                        else
                                                                echo "Enter Valid Int!!! X1=$X"
                                                                Show_Help
                                                                exit
                                                        fi
						;;
                                                -y)
                                                        echo ${_args[$tmp+1]} | grep "^-" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                echo "Invalid Arguman!!! -y ${_args[$tmp+1]}"
                                                                Show_Help
                                                                exit
                                                        fi
                                                        echo ${_args[$tmp+1]} | grep "^[0-9]*$" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                Y1="${_args[$tmp+1]}"
								echo $Y1
                                                        else
                                                                echo "Enter Valid Int!!! Y!=$Y1"
                                                                Show_Help
                                                                exit
                                                        fi
                                                ;;
                                                -c)
                                                        echo ${_args[$tmp+1]} | grep "^-" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                echo "Invalid Arguman!!! -x ${_args[$tmp+1]}"
                                                                Show_Help
                                                                exit
                                                        fi
                                                        echo ${_args[$tmp+1]} | grep "^[a-z]*$" 1> /dev/null 2>&1
							if [ $? -eq 0 ]
                                                        then
                                                                Txt_Color="${_args[$tmp+1]}"
                                                        else
                                                                echo "Enter color name..."
                                                                Show_Help
                                                                exit
                                                        fi
                                                ;;
					esac
					let tmp=tmp+1
				done
			;;
			-s)
				echo ${_args[$tmp+1]} | grep "^-" 1> /dev/null 2>&1
				if [ $? -eq 0 ]
				then
					echo "Invalid Arguman!!! -s ${_args[$Arg_Count]}"
					Show_Help
					exit
				fi
				Sub="\""
				Sub="${Sub}""${_args[$tmp+1]}""${Sub}"
				echo $Sub
				let tmp=tmp+2
				while [  $tmp -lt $# ]
				do
					case "${_args[$tmp]}" in
						-t)
							break
						;;
						--help)
							break
						;;
						-f)
                                                        echo ${_args[$tmp+1]} | grep "^-" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                echo "Invalid Arguman!!! -f ${_args[$tmp+1]}"
                                                                Show_Help
                                                                exit
                                                        fi
							ls ${_args[$tmp+1]} 1> /dev/null 2>&1
							if [ $? -eq 0 ]
							then 
								Sub_Font="-font "
								Sub_Font="$Txt_Font"" ${_args[$tmp+1]}"
								echo $Sub_Font
							else
								echo "This Font dose not exist!!!"
								Show_Help
								exit
							fi
						;;
						-p)
                                                        echo ${_args[$tmp+1]} | grep "^-" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                echo "Invalid Arguman!!! -p ${_args[$tmp+1]}"
                                                                Show_Help
                                                                exit
                                                        fi
							echo ${_args[$tmp+1]} | grep "^[0-9]*$" 1> /dev/null 2>&1
							if [ $? -eq 0 ]
							then
								Sub_Font_Size="${_args[$tmp+1]}"
								echo $Sub_Font_Size
							else
								echo "Enter Valid FontSize!!!"
								Show_Help
								exit
							fi
						;;
						-x)
                                                        echo ${_args[$tmp+1]} | grep "^-" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                echo "Invalid Arguman!!! -x ${_args[$tmp+1]}"
                                                                Show_Help
                                                                exit
                                                        fi
                                                        echo ${_args[$tmp+1]} | grep "^[0-9]*$" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                X2="${_args[$tmp+1]}"
								echo $X2
                                                        else
                                                                echo "Enter Valid Int!!! X=$X2"
                                                                Show_Help
                                                                exit
                                                        fi
						;;
                                                -y)
                                                        echo ${_args[$tmp+1]} | grep "^-" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                echo "Invalid Arguman!!! -y ${_args[$tmp+1]}"
                                                                Show_Help
                                                                exit
                                                        fi
                                                        echo ${_args[$tmp+1]} | grep "^[0-9]*$" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                Y2="${_args[$tmp+1]}"
								echo $Y2
                                                        else
                                                                echo "Enter Valid Int!!! Y=$Y2"
                                                                Show_Help
                                                                exit
                                                        fi
                                                ;;
                                                -c)
                                                        echo ${_args[$tmp+1]} | grep "^-" 1> /dev/null 2>&1
                                                        if [ $? -eq 0 ]
                                                        then
                                                                echo "Invalid Arguman!!! -x ${_args[$tmp+1]}"
                                                                Show_Help
                                                                exit
                                                        fi
                                                        echo ${_args[$tmp+1]} | grep "^[a-z]*$" 1> /dev/null 2>&1
							if [ $? -eq 0 ]
                                                        then
                                                                Sub_Color="${_args[$tmp+1]}"
								echo $Sub_Color
                                                        else
                                                                echo "Enter color name..."
                                                                Show_Help
                                                                exit
                                                        fi
                                                ;;
					esac
					let tmp=tmp+1
				done

			;;
			--help)
			        Show_Help
			        exit
			;;
		esac
	done
}

function Show_Help
{
	echo heeeeeeeeeeeeeeeeeeeeeeeeeeeeelp
}

Get_Arg "$@"
Drow_Text
