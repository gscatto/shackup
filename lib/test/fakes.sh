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
    DATETIME_TIMESTAMP='echo 20240207T1742CET' CHECKSUM_CALCULATE='cut -z -d/ -f5- | sed "s/\x0/;/"' COMPRESSION_COMPRESS='echo "<$(cat)>"' src/main/take_snapshot $(source) $(target)
}

when_check_snapshots () {
    CHECKSUM_CHECK="cat >> $TMP/checksum_checks" COMPRESSION_DECOMPRESS="sed 's/^<\(.*\)>$/\1/'" src/main/check_snapshots $(target)
}

then_create_directory () {
    DIRECTORY=$(target)/$1
    if [ ! -d $DIRECTORY ]; then
        echo ERROR: expecting $DIRECTORY to be a directory
        tree $(target)
        exit 1
    fi
}

then_target_has_file () {
    FILE_PATH=$(target)/$1
    FILE_CONTENTS="$2"
    if [ ! -f $FILE_PATH ]; then
        echo ERROR: expecting $FILE_PATH to be a file
        tree $(target)
        exit 1
    fi
    echo "$FILE_CONTENTS" > $TMP/actual
    if ! diff $TMP/actual $FILE_PATH > /dev/null; then
        echo ERROR: expecting $FILE_PATH to have the following content:
        echo "$FILE_CONTENTS"
        echo ERROR: but got
        cat $FILE_PATH
        exit 1
    fi
}

then_target_file_has_attributes () {
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

then_checksum_checks () {
    echo -n "$1" > $TMP/expected
    if ! diff $TMP/expected $TMP/checksum_checks > /dev/null; then
        echo ERROR: expecting the following checksum checks: 
        cat $TMP/expected
        echo "\nERROR: but got:"
        cat $TMP/checksum_checks
        exit 1
    fi
}
