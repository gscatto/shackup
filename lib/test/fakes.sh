source () {
    echo $TMP/source
}

target () {
    echo $TMP/target
}

given_target_file () {
    FILE_PATH=$1
    FILE_CONTENTS=$2
    mkdir -p $(target)/$(dirname $FILE_PATH)
    echo "$FILE_CONTENTS" > $(target)/$FILE_PATH
}

given_target_symlink () {
    SYMLINK_PATH=$1
    SYMLINK_CONTENT=$2
    mkdir -p $(target)/$(dirname $SYMLINK_PATH)
    ln -s $SYMLINK_CONTENT $(target)/$SYMLINK_PATH
}

given_source_file () {
    FILE_PATH=$1
    FILE_CONTENTS=$2
    mkdir -p $(source)/$(dirname $FILE_PATH)
    echo "$FILE_CONTENTS" > $(source)/$FILE_PATH
}

given_file () {
    FILE_PATH=$1
    FILE_CONTENTS=$2
    mkdir -p $(source)/$(dirname $FILE_PATH)
    echo "$FILE_CONTENTS" > $(source)/$FILE_PATH
}

given_source_directory_exists () {
    mkdir -p $(source)
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

then_file_has_attributes () {
    FILE_PATH="$(target)/$1"
    EXPECTED="$2"
    ACTUAL="$(get_file_attributes $FILE_PATH)"
    if [ ! "$ACTUAL" = "$EXPECTED" ]; then
        echo "ERROR: $FILE_PATH attributes do not match (Expected/Actual):"
        echo "$FILE_ATTRIBUTES_HEADER"
        echo "E $EXPECTED"
        echo "A $ACTUAL"
        exit 1
    fi
}

get_source_file_attributes () {
    FILE_PATH="$(source)/$1"
    get_file_attributes $FILE_PATH
}

FILE_ATTRIBUTES_HEADER='  | perm. bits | time of last data modification      | '
get_file_attributes () {
    stat -c '| %A | %y |' "$1"
}

then_target_has_symlink () {
    FILE_PATH="$(target)/$1"
    EXPECTED="$2"
    if [ ! -L $FILE_PATH ]; then
        echo ERROR: expecting $FILE_PATH to be a symlink
        tree $(target)
        exit 1
    fi
    ACTUAL="$(readlink $FILE_PATH)"
    if [ ! "$ACTUAL" = "$EXPECTED" ]; then
        echo "ERROR: expecting $FILE_PATH to be a symlink to $EXPECTED, got $ACTUAL"
        tree $(target)
        exit 1
    fi
}

then_target_has_hardlinks () {
    INODE_1="$(stat -c '%i' $(target)/$1)"
    INODE_2="$(stat -c '%i' $(target)/$2)"
    if [ ! $INODE_1 = $INODE_2 ]; then
        echo "ERROR: in target, expecting $1 and $2 to have same inode number, but they are $INODE_1 and $INODE_2, respectively"
        exit 1
    fi
}
