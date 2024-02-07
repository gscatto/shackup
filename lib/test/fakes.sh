target () {
    echo $TMP/target
}

take_snapshot () {
    src/main/take_snapshot $(target)
}

then_create_directory () {
    DIRECTORY=$(target)/$1
    if [ ! -d $DIRECTORY ]; then
        echo ERROR: expecting $DIRECTORY to be a directory
        tree $(target)
        exit 1
    fi
}
