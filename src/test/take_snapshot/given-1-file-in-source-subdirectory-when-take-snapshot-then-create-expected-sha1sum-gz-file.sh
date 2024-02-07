given_source_file Documents/hello.txt 'Hello, world!'
when_take_snapshot
then_target_has_file archive/all/$TIMESTAMP/meta/sha1sum.gz '<archive/all/20240207T1742CET/data/Documents/hello.txt;>'
