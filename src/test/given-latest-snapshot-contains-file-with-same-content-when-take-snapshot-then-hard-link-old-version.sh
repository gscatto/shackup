given_target_file archive/all/20010101T010101UTC/data/hello.txt 'Hello, world!'
given_target_symlink latest/all ../archive/all/20010101T010101UTC
given_source_file hello.txt 'Hello, world!'
when_take_snapshot
then_target_has_hardlinks archive/all/$TIMESTAMP/data/hello.txt archive/all/20010101T010101UTC/data/hello.txt

