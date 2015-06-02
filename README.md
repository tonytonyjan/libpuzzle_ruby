# Install

```
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
Puzzle.uncompress "COMPRESSED_STRING" # => #<Puzzle>
```
