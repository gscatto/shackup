given_file hello.txt 'Hello, world!'
when_take_snapshot
then_target_has_file archive/all/20240207T1742CET/data/hello.txt 'Hello, world!'
then_target_file_has_attributes archive/all/20240207T1742CET/data/hello.txt "$(get_source_file_attributes hello.txt)"
