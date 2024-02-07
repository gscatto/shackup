given_file hello.txt 'Hello, world!'
given_file bye.txt 'Bye, world!'
when_take_snapshot
then_file_exists latest/all/hello.txt 'Hello, world!'
then_file_exists latest/all/bye.txt 'Bye, world!'
