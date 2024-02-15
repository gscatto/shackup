given_target_file archive/all/20010101T010101UTC/data/hello.txt 'hello, world!'
given_target_symlink latest/all ../archive/all/20010101T010101UTC
given_source_file hello.txt 'HELLO, WORLD!'
when_take_snapshot
then_target_has_file archive/all/20240207T1742CET/data/hello.txt 'HELLO, WORLD!'
