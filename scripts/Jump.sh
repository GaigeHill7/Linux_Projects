#!bin/bash


#Defining jump function
function jump()
{
        # Save the original Internal Field Separator
        # Controls how word-splitting works
        OLDIFS=$IFS

        # Temporarily change to /, so it splits PWD into pieces
        IFS=/

        # Uses the current working directory, and splits it into path_arr
        path_arr=($PWD)

        # Restore the original IFS
        IFS=$OLDIFS

        #Declare local varaible to track index position
        local pos=-1

        # Loop through each directory in the path array
        for dir in "${path_arr[@]}"; do

                # Increment position counter
                pos=$((pos + 1))

                #If the argument matches the current directory
                if [ "$1" = "$dir" ]; then
                        
                        #Calculate the number of directories in the path
                        dir_in_path=${#path_arr[@]}

                        #Sets cwd to the current working directory
                        cwd=$PWD

                        #Calculate how many levels needed to go up
                        limit=$((dir_in_path - pos - 1))

                        #
                        for ((i=0; i<limit; i++)); do
                                cwd="$cwd/.."
                        done
                        cd "$cwd"
                        break
                fi
        done
}