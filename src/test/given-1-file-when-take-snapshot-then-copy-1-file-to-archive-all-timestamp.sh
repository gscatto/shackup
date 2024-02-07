given_file hello.txt 'Hello, world!'
when_take_snapshot
then_target_has_file archive/all/$TIMESTAMP/hello.txt 'Hello, world!'
