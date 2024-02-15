given_file files/hello.txt 'Hello, world!'
when_take_snapshot
then_target_has_file archive/all/20240207T1742CET/data/files/hello.txt 'Hello, world!'
