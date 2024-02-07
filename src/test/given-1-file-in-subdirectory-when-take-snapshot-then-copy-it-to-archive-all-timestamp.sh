given_file files/hello.txt 'Hello, world!'
when_take_snapshot
then_target_has_file archive/all/$TIMESTAMP/files/hello.txt 'Hello, world!'
