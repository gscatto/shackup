target () {
    echo $TMP/target
}

when_take_snapshot () {
    src/main/take_snapshot $(target) $TIMESTAMP
}

then_create_directory () {
    DIRECTORY=$(target)/$1
    if [ ! -d $DIRECTORY ]; then
        echo ERROR: expecting $DIRECTORY to be a directory
        tree $(target)
        exit 1
    fi
}
