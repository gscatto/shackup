given_file hello.txt 'Hello, world!'
given_file bye.txt 'Bye, world!'
when_take_snapshot
then_file_exists archive/all/$TIMESTAMP/hello.txt 'Hello, world!'
then_file_exists archive/all/$TIMESTAMP/bye.txt 'Bye, world!'
