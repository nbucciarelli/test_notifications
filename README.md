To run:

    $ cp ~/config/config_sample.yml config/config.yml

Replace respective fields.

This script will run in the background as a daemon process

    $ ruby test_notifications.rb start
      (test_notifications.rb is now running in the background)
    $ ruby test_notifications.rb restart
      (...)
    $ ruby test_notifications.rb stop

Make sure you have growl installed.