source () {
    echo $TMP/source
}

target () {
    echo $TMP/target
}

given_file () {
    FILE_PATH=$1
    FILE_CONTENTS=$2
    mkdir -p $(source)/$(dirname $FILE_PATH)
    echo "$FILE_CONTENTS" > $(source)/$FILE_PATH
}

when_take_snapshot () {
    src/main/take_snapshot $(source) $(target) $TIMESTAMP
}

then_create_directory () {
    DIRECTORY=$(target)/$1
    if [ ! -d $DIRECTORY ]; then
        echo ERROR: expecting $DIRECTORY to be a directory
        tree $(target)
        exit 1
    fi
}

then_file_exists () {
    FILE_PATH=$(target)/$1
    FILE_CONTENTS="$2"
    if [ ! -f $FILE_PATH ]; then
        echo ERROR: expecting $FILE_PATH to be a file
        tree $(target)
        exit 1
    fi
    if [ ! "$FILE_CONTENTS" = "$(cat $FILE_PATH)" ]; then
        echo ERROR: expecting $FILE_PATH to have the following content:
        echo "$FILE_CONTENTS"
        echo ERROR: but got
        cat $FILE_PATH
        exit 1
    fi
}
