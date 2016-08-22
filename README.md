# TUT.BY Telegram Bot

<img src="https://github.com/chyrta/TUTBYBot/blob/master/screenshot.png" alt="alt text" width="30%">

An absolutely simple bot for Telegram Messenger written in one night in Ruby for #1 news website in Belarus

Yes, it's always accessible by [@tutbybot] nickname.

## What can you do now?

  - Read the latest news from variety of categories like politics, economics and et.c
  - Get the currencies (USD, EUR and BYR)
  - Searching for news

## What are the next steps?

  - Subscriptions
  - Sending news to the editorial office
  - Much cleaner code (now it's awful)

## Usage for learning
1. Fork it
2. Obtain your [Bot Token] as put it into config.rb
3. Install necessary gems and run it as a background job.

```sh
$ bundle install
$ ruby app.rb start
```

4. If you want to stop using it, just type:

```sh
$ ruby app.rb stop
```

### Pay attention!
> The API methods were obtained through decompiling
> the official TUT.BY Android application.
>
> You have to configure your own config.rb in config folder.

[@tutbybot]: <http://telegram.me/tutbybot>
[Bot Token]: <http://telegram.me/botfather>

## Credits
1. Dzmitry Chyrta
2. Alex Senkov
