# TUT.BY Telegram Bot

<img src="https://github.com/datarockets/TUTBYBot/blob/master/screenshot.png" alt="alt text" width="30%">

An absolutely simple bot for Telegram Messenger written in one night in Ruby for #1 news website in Belarus

Yes, it's always accessible by [@tutbybot] nickname.

## What can you do now?

  - Read the latest news from variety of categories like politics, economics and etc.
  - Get the currencies (USD, EUR and BYR)
  - Searching for news

## What are the next steps?

  - Subscriptions to the certain category of news
  - Ability to send your news to the editorial office

## Usage for learning
1. Fork it
2. Obtain your [Bot Token] and [Botan Token], copy examples_secrets.rb to config folder, rename to secrets.rb and put your tokens like in example.
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
> You have to configure your own secrets.rb in config folder.

[@tutbybot]: <https://telegram.me/tutbybot>
[Bot Token]: <https://telegram.me/botfather>
[Botan Token]: <https://botan.io>
[Dzmitry Chyrta]: <https://github.com/chyrta>
[Aleks Senkov]: <https://github.com/AleksSenkou>

## Credits
1. [Dzmitry Chyrta]
2. [Aleks Senkov]
