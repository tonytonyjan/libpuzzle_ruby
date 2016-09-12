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

p1.similar? p2 # default threshold is 0.6
p1.similar? p2, threshold: 0.7

# get exact distance
p1.distance p2

# compress
p1.compress # => compressed string

# uncompress
Puzzle.uncompress 'COMPRESSED_STRING' # => #<Puzzle>
```

# Integrate with ActiveRecord

Follow the naming convention of ActiveRecord, the database schema will look like:

```
+---------------------------------+
|            signatures           |
+---------------------------------+
|   id   | signature | picture_id |
+--------+-----------+------------+

+-------------------------------------+
|                words                |
+-------------------------------------+
| id | position | word | signature_id |
+----+----------+------+--------------+
```

```ruby
class Word < ActiveRecord::Base
  belongs_to :signature
end

class Signature < ActiveRecord::Base
  K, N = 10, 100
  has_many :words

  def cut_vectors_into_words!
    puzzle = Puzzle.uncompress signature
    i = 0
    while i < N && word = puzzle.vector.byteslice(i, K)
      words.find_or_create_by! word: word, position: i
      i += 1
    end
  end

  def similar_signatures
    Signature.distinct.joins(:words)
      .where('EXISTS (SELECT * FROM words AS _words WHERE _words.sig_id = ? AND _words.position = words.position and _words.word = words.word)', id)
      .where.not(id: id)
      .select{ |sig| Puzzle.uncompress(sig.signature) == Puzzle.uncompress(signature) }
  end

end
```
