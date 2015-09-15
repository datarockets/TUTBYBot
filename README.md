# TUT.BY Telegram Bot
An absolutely simple bot for Telegram Messenger written in one night in Ruby for #1 news website in Belarus

Yes, it's always accessible by [@tutbybot] nickname.

## What can you do now?

  - Read the latest news from variety of categories like politics, economics and et.c
  - Get the currencies (USD, EUR and BYR)

## What are the next steps?
  
  - Subscriptions
  - Sending news to the editorial office
  - Searching by some text query
  - Much cleaner code (now it's awful)

## Usage for learning
1. Fork it
2. Obtain your [Bot Token] and [Botan Token] and put in TOKEN and BOTAN_TOKEN variables.
3. Install necessary gems and run it as a background job.

```sh
$ bundle install
$ ruby control.rb start
```

4. If you want to stop using it, just type:

```sh
$ ruby control.rb stop
```

### Pay attention!
> The API methods were obtained through decompiling
> the official TUT.BY Android application.
> 
> Constants::TOKEN and Constants::BOTAN_TOKEN are NULL. You need to obtain your own access tokens.

[@tutbybot]: <http://telegram.me/tutbybot>
[Bot Token]: <http://telegram.me/botfather>
[Botan Token]: <https://appmetrica.yandex.com>