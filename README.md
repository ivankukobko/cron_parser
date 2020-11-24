# Cron Parser is you bestest friend

Script deciphers cron commands
```
$ ./cron_parser.sh '0 0 0 0 * /bin/sh'

minute       0
hour         0
day of month 0
month        0
day of week  0 1 2 3 4 5 6
command      /bin/sh
```

Does not yet fully validate input

### Testing
```
$ ruby lib/cron_parser_test.rb
```
