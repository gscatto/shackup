given_file files/hello.txt 'Hello, world!'
when_take_snapshot
then_file_exists latest/all/files/hello.txt 'Hello, world!'
