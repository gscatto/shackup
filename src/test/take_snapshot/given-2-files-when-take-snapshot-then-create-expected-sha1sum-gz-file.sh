given_source_file hello.txt 'Hello, world!'
given_source_file bye.txt 'Bye, world!'
when_take_snapshot
then_target_has_file archive/all/$TIMESTAMP/meta/sha1sum.gz "<archive/all/$TIMESTAMP/data/hello.txt;archive/all/$TIMESTAMP/data/bye.txt>"
