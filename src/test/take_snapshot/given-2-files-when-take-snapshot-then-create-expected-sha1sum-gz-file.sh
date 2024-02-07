given_source_file hello.txt 'Hello, world!'
given_source_file bye.txt 'Bye, world!'
when_take_snapshot
then_target_has_file archive/all/$TIMESTAMP/meta/sha1sum.gz "<09fac8dbfd27bd9b4d23a00eb648aa751789536d  hello.txt\nd3fb3ed4f9ffb8d24283db241a34f756f8487b70  bye.txt>"
