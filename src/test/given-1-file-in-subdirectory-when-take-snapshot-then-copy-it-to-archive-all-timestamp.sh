given_file files/hello.txt 'Hello, world!'
when_take_snapshot
then_file_exists archive/all/$TIMESTAMP/files/hello.txt 'Hello, world!'
