given_file hello.txt 'Hello, world!'
given_file bye.txt 'Bye, world!'
when_take_snapshot
then_target_has_file archive/all/20240207T1742CET/data/hello.txt 'Hello, world!'
then_target_has_file archive/all/20240207T1742CET/data/bye.txt 'Bye, world!'
