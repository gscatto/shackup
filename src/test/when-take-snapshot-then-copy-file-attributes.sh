given_file hello.txt 'Hello, world!'
when_take_snapshot
then_file_exists archive/all/$TIMESTAMP/hello.txt 'Hello, world!'
then_file_has_attributes archive/all/$TIMESTAMP/hello.txt "$(get_source_file_attributes hello.txt)"
