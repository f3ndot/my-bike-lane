MyBikeLane Toronto
======================

The open-source rebuild of the [@gwhalin](https://twitter.com/gwhalin)'s MyBikeLane.com using Ruby on Rails.

### Available Sites ####
- **[Stable, Live Production Site](http://www.mybikelane.to/)**
- [Bleeding-Edge, Testing Site](http://staging.mybikelane.to/)


Upcoming Features
----------------------

These features are listed in no particular order:

- Ability to sync existing accounts to Twitter, Facebook, Google logins
- Google and Facebook login support
- User donor badge
- AJAX-Driven / instant picture upload support
- Cropping, rotating photos
- International support
- Easier mobile / smartphone support
- Developer API
- User profiles
- User profiles privacy settings
- Awards / Leaderboards
- Better Statistics
- Better UI design
- Logo


A Word on Funding
----------------------

I know it's a silly project, but it does cost me money to run. If you have enjoyed using the site please consider [buying me a cup of coffee](http://www.mybikelane.to/page/support-mybikelane-toronto).


Questions or Problems?
----------------------

Have a suggestion, bug, or problem? [Contact me](mailto:me@justinbull.ca)

**Developers:** If you have any issues with MyBikeLane Toronto, please add an [issue on GitHub](https://github.com/f3ndot/my-bike-lane/issues) or fork the project and send a pull request.


Development
-----------

Developed with Ruby 2 or higher. You'll want to get Ruby on your system using RVM, RBenv, what-have-you.

__As a requirement for image uploading to work, you'll need ImageMagick or GraphicsMagick command-line tool installed.__ You can check if you have it installed by running

```
$ convert -version
Version: ImageMagick 6.8.9-7 Q16 x86_64 2014-09-11 http://www.imagemagick.org
Copyright: Copyright (C) 1999-2014 ImageMagick Studio LLC
Features: DPC Modules
Delegates: bzlib fftw freetype jng jpeg lcms ltdl lzma png tiff xml zlib
```

If you don't have it, it's pretty easy to install on Linux. Mac users can use Homebrew:

```
brew install imagemagick
```

Install all the dependencies for the app by running Bundler's install command. (run `gem install bundle` first if `bundle` doesn't exist in your PATH)

```
bundle install --without staging production
```

Once this succeeds, bootstrap the Rails app database (development uses SQLite3):

First define your development database configuation (create the file `config/database.yml`):

```yml
development:
  adapter: sqlite3
  database: db/development.sqlite3
  pool: 5
  timeout: 5000
```

Then bootstrap it with the seed data and schema:

```
bundle exec rake db:setup
```

Ok! You're ready to start developing. Start the server by invoking:

```
bundle exec rails server
```

For more specifics, read up on the [Ruby on Rails 3.2.18](http://guides.rubyonrails.org/v3.2.18/) documentation

Special Thanks
----------------------

My thanks to [Greg Whalin](https://twitter.com/gwhalin) for founding MyBikeLane and maintaining it for so long.


License
----------------------

Copyright (c) 2014 Justin A. S. Bull

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
