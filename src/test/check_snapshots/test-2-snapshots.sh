given_target_file archive/all/20221010T000000UTC/meta/sha1sum.gz '<20221010T000000UTC SHA1SUM checksums>'
given_target_file archive/all/20190102T011234UTC/meta/sha1sum.gz '<20190102T011234UTC SHA1SUM checksums>'
when_check_snapshots
then_checksum_checks "20190102T011234UTC SHA1SUM checksums\n20221010T000000UTC SHA1SUM checksums\n"
