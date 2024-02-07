given_source_file Documents/hello.txt 'Hello, world!'
when_take_snapshot
then_target_has_file archive/all/$TIMESTAMP/meta/sha1sum.gz '<09fac8dbfd27bd9b4d23a00eb648aa751789536d  Documents/hello.txt>'
