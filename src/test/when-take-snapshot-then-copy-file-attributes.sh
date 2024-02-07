given_file hello.txt 'Hello, world!'
when_take_snapshot
then_file_exists latest/all/hello.txt 'Hello, world!'
then_file_has_attributes latest/all/hello.txt "$(get_source_file_attributes hello.txt)"
