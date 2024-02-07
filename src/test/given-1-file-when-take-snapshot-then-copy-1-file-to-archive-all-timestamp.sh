given_file hello.txt 'Hello, world!'
when_take_snapshot
then_file_exists archive/all/$TIMESTAMP/hello.txt 'Hello, world!'
