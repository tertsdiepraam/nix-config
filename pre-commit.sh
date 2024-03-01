BRANCH=$(git branch --show-current HEAD);
echo "|$BRANCH|";

case "$BRANCH" in
    *main*)
        read -p "Are you sure you want to commit to main??? [y/n]: " yn
        case $yn in
            [Yy]*) echo "Ok, fine, you do you"; exit 0 ;;  
            [Nn]*) echo "Good!"; exit 1 ;;
        esac;;
    *) echo "Go ahead!";;
esac
