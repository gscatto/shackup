given_file hello.txt 'Hello, world!'
when_take_snapshot
then_file_exists latest/all/hello.txt 'Hello, world!'
