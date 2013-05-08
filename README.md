small script to automatically update your twitter profile pic and/or background banner based on whatever you want... weather, random, at some regular interval, etc.

How to make it work
-------------------

1. tpc.pl is does all the work. to be able to change your profile and/or banner pic, it needs read/write permissions to your twitter account. to get these permissions, you need to generate: consumer key, consumer secret, access token, and access token secret.

2. Creating access tokens/keys
    * goto https://dev.twitter.com, sign in.
    * upper right dropdown, My Applications.
    * Create new application.
    * Goto Settings tab and pick Read and Write Access.
    * click "Update this Twitter application's settings" at bottom
    * Under Details tab, click "Create my access token". 
    * goto OAuth tool tab and grab the 4 keys.

In the script I store these keys in /secret/twitter2.config. The format of this file is easy, here's an example:

    consumer_key        => 'asdfjk',
    consumer_secret     => 'lajflsakjfd',
    token        => 'alskjdflsakjdflk',
    token_secret => 'ajfalkjfd',
  
Now you need to put your profile pictures under ./pool. You can use jpg, gif, or png, I think they'll all work even though the mime_type in the script says image/png.
* Pictures must be < 800 kB and will be scaled down by twitter if too big.

If you run the script now, it should upload a random picture to twitter to replace your profile picture. You can run it regularly with cron or trigger it off something else. If you want to change your banner, just uncomment the section in the script that runs "update_profile_banner".

If the script errors back like this:

    HTTP Response Code: 401
    HTTP Message......: Unauthorized
    Twitter error.....: Error processing your OAuth request: Read-only application cannot POST at tpc.pl line 37

Just recreate your access token in the Details tab. Don't forget to update your access tokens in /secret/twitter2.config.


my sample picture pool of files is a subset of sprites from https://code.google.com/p/project6014/
