given_file hello.txt 'Hello, world!'
when_take_snapshot
then_target_has_file archive/all/$TIMESTAMP/hello.txt 'Hello, world!'
then_file_has_attributes archive/all/$TIMESTAMP/hello.txt "$(get_source_file_attributes hello.txt)"
