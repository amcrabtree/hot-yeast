#!/usr/bin/env sh

## alignment pipeline
## Authors: Angela Crabtree

################ CHECK PYTHON ##################
RSC=$(RScript --version)
REFNAME=$(echo "${RSC}" | cut -d" " -f2)
if [[ ${REFNAME} == "command" ]]
then 
	zenity --error \
		--width=400 --height=100 \
		--text "You don't have R installed\!\n\nInstall R (https://www.r-project.org/). "
	exit 0
fi

################ CHOOSE AND PROOF FILE ##################
S_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SCRIPT="${S_DIR}/hot-yeast_CL.R"

ANS_i=$(zenity --question --text "Does your data file have lawn strains listed along the top row and killer strains along the left side?"; echo $?)
if [[ ${ANS_i} == "1" ]] # if no
then
	exit 0 
fi

## choose an input file
FILE=$(zenity --file-selection --text "Choose your data file")
EXTN=$(basename "${FILE}" | cut -d"." -f2)   # store name of extension
if [[ "${FILE}" == "" ]] 
then 
	exit 0 
elif [[ ${EXTN} != "csv" ]] 
then 
	zenity --error --width=400 --height=200 \
		--text "Please select a data file in CSV format (ends in .csv)"
	exit 0
fi

## save a file-info-specific CLI variable so I can loop with different parameters
PRECLI="${CLI}"
LOOP="0" # initialize loop
while [ ${LOOP} == "0" ]
do
	################ CHANGING BAND SIZES ##################
	ANS=$(zenity --question --text "Do you want to use default parameters?"; echo $?)
	if [[ ${ANS} == "1" ]]
	then
		# height of output file
		ANS_h=$(zenity --scale --text "What HEIGHT would you like your output file, in inches?" --min-value 1 --max-value 50 --value 10 --step 5)
		CLI="${PRECLI} ${ANS_h}"
	
		# width of output file
		ANS_w=$(zenity --scale --text "What WIDTH would you like your output file, in inches?" --min-value 1 --max-value 50 --value 10 --step 5)
		CLI="${CLI} ${ANS_w}"
	
		# type of output file
		ANS_t=$(zenity --list --column "option" --column "file type" TRUE jpeg FALSE pdf FALSE tiff FALSE png --radiolist)
		CLI="${CLI} ${ANS_t}"
	
		# number of killing categories
		ANS_c=$(zenity --scale --text "What is the number of killing categories? ex: kill (1) and no kill (0) would be '2'" --min-value 2 --max-value 7 --value 2 --step 1)
		CLI="${CLI} ${ANS_c}"
	
	fi

	################ RUN FULL COMMAND ##################
	
	cd "${S_DIR}"
	echo "\nRscript \"${SCRIPT}\" \"${FILE}\" ${CLI}\n"
	Rscript "${SCRIPT}" "${FILE}"${CLI}

	################# OPTIONAL LOOP ##################
	LOOP=$(zenity --question --text "Do you want to try different parameters?"; echo $?)
	
	echo "\nOutput files are located in the script folder.\n"
done

exit 0