#!/bin/bash
while :
do
    # Get all the directories
    dotfiles=$(find . -maxdepth 1 -not -name "." -not -name ".git" -type d -printf '%P\n')

    # Check if array of directory is empty
    if [[ -z "$dotfiles" ]]; then
        echo "There are no dotfiles here!"
    fi

    PS3="Choose which dotfile you want to link: "

    #Symlink dotfiles to the specified location
    select dotfile in ${dotfiles}
    do
        echo -e "Where do you want to link the files? (empty for $HOME): \c"
        read -e location 
        if [ -z "$location" ]; then
            location="${HOME}"
        fi

        echo "Symlinking to $location ..."
        stow --verbose=2 $dotfile -t $location
        retval=$?

        if [ $? -eq 0 ]; then
            echo "$dotfile Done!"
        fi
        break
    done

    exit 0
done
