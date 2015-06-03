[![Build Status](https://travis-ci.org/tonytonyjan/libpuzzle_ruby.svg?branch=master)](https://travis-ci.org/tonytonyjan/libpuzzle_ruby)

This Ruby gem is made for image simularity comparison, using the C libary [libpuzzle](http://www.pureftpd.org/project/libpuzzle).

# Install

```
gem install libpuzzle
```

Make sure you have installed libpuzzle (>= 0.11) first.

# Install Libpuzzle

Homebrew:

```
brew install libpuzzle
```

APT:

```
apt-get install libpuzzle1 libpuzzle-dev
```

Compile:

```
sudo apt-get install -qq libgd2-xpm-dev
wget http://download.pureftpd.org/pub/pure-ftpd/misc/libpuzzle/releases/libpuzzle-0.11.tar.bz2
tar -xvj -f libpuzzle-0.11.tar.bz2
cd libpuzzle-0.11 && ./configure && make && sudo make install
```

Since the object file is located in `/usr/local/lib`, you might want to export `LD_LIBRARY_PATH` before gem installation, for example:

```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
gem install libpuzzle
```

# Usage

```ruby
# load image
p1 = Puzzle.new('foo.png')
p2 = Puzzle.new('bar.png')

# check simularity with threshold 0.6
p1 == p2

# get exact distance
p1.distance p2

# compress
p1.compress # => compressed string

# uncompress
Puzzle.uncompress 'COMPRESSED_STRING' # => #<Puzzle>
```
