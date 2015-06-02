require 'minitest/autorun'
require 'byebug'
require 'puzzle_ext'

class TestMeme < Minitest::Test
  def setup
    @puzzle = Puzzle.new(File.expand_path('../tony.png', __FILE__))
    @compressed = "\xf7\x28\x29\x53\x1f\x01\x21\x4b\x01\x2b\x41\x4e\x67\x1d\x44\x4d\x6c\x51\x51\x05\x4b\x5e\x05\x78\x4a\x29\x7c\x61\x1f\x06\x01\x23\x0f\x00\x7c\x3b\x3f\x59\x59\x2f\x60\x4c\x64\x77\x5d\x30\x1f\x1f\x76\x5d\x53\x31\x21\x7c\x05\x0f\x77\x45\x61\x03\x01\x06\x30\x54\x6a\x5b\x21\x53\x1f\x1f\x53\x21\x51\x62\x22\x1c\x00\x19\x6d\x30\x3a\x53\x10\x2b\x5e\x72\x63\x44\x7b\x52\x21\x54\x5d\x3f\x63\x49\x7b\x6b\x51\x54\x1c\x41\x10\x22\x05\x5f\x03\x77\x18\x19\x78\x55\x7a\x77\x01\x28\x18\x00\x78\x56\x7c\x7c\x06\x76\x63\x04\x19\x5a\x01\x62\x04\x00\x0a\x2d\x7b\x21\x00\x05\x00\x4b\x00\x12\x60\x5f\x1e\x2c\x18\x1d\x4c\x5a\x33\x1a\x70\x6d\x79\x63\x45\x7c\x7b\x75\x7c\x31\x7c\x09\x00\x0b\x6a\x77\x18\x10\x3a\x37\x02\x07\x4b\x01\x5a\x4b\x10\x1b\x2d\x04".force_encoding('BINARY')
  end

  def test_open_file
    Puzzle.new(File.expand_path('../tony_gray.png', __FILE__))
    assert_raises Puzzle::Error do
      Puzzle.new(File.expand_path('../tony_gray.pngg', __FILE__))
    end
  end

  def test_vector
    expected = "\x02\x01\x02\xFE\x01\xFF\xFF\x01\xFF\x01\xFF\x01\xFF\xFF\xFF\xFF\xFE\xFE\x01\xFF\xFF\xFE\xFE\x01\xFF\xFE\xFE\x01\x01\xFF\xFE\x01\x00\x01\xFE\x01\x01\xFE\x02\x02\xFE\xFF\x01\x01\x00\x00\xFE\x01\x01\xFF\x02\xFF\xFF\x01\xFF\xFF\x01\xFE\xFF\xFE\xFE\xFE\x01\x02\x01\x01\xFE\xFF\xFE\xFE\x02\x02\x02\x02\x00\xFF\x01\xFF\x02\x02\x02\x00\x02\x01\xFF\xFF\xFF\xFF\xFF\xFE\xFF\xFE\xFE\xFE\x00\xFF\xFE\x01\xFE\xFE\xFE\xFE\x02\x02\x02\x02\xFF\x00\x01\x00\x00\x02\x00\x01\x02\x00\x01\x00\x02\xFF\xFF\x02\x01\xFF\xFE\x01\xFE\xFE\x02\x02\x01\x02\x01\x01\x01\x01\x02\xFF\xFF\xFF\xFF\xFF\xFF\xFF\x01\x01\x02\x01\x01\x01\x01\xFF\x01\x02\x02\xFF\x01\xFF\xFF\x02\x02\x02\xFE\xFF\xFE\xFE\x01\xFE\x02\x01\x02\x02\x01\x00\x00\x02\x01\x01\xFE\xFE\xFF\xFE\xFE\xFF\xFF\xFE\x01\x02\xFF\x02\xFF\x01\xFF\xFF\x02\xFF\x01\x01\x01\xFF\xFF\x01\xFF\x01\xFF\xFF\xFF\xFF\xFF\xFF\x01\xFF\x01\x01\xFF\xFF\xFF\xFF\x01\x01\x02\x01\x02\xFF\xFF\x01\xFE\xFF\xFE\xFE\xFE\xFE\xFE\xFF\x02\xFF\x02\x01\x02\xFF\x01\xFF\x00\x01\xFF\x01\xFF\x01\xFE\x01\x01\xFF\x02\x01\x01\x02\x00\x02\x02\x02\x01\x01\x01\x00\x01\x02\x02\x00\xFF\x01\x01\xFF\xFF\x02\xFF\x01\x01\x01\x01\x01\x00\x00\x02\x02\x01\x01\x02\x00\x01\x02\x02\x00\xFF\x02\xFF\xFF\x01\x02\xFF\x01\x01\xFE\xFF\xFE\x01\x00\xFF\x01\xFE\x02\xFF\xFF\xFE\xFF\xFE\xFE\x02\x01\x01\xFE\xFE\x02\x01\x02\x02\x02\xFE\xFE\xFE\xFF\xFE\x02\x02\xFE\x00\x01\x00\x02\x02\x02\x01\x02\xFF\xFE\xFE\xFE\x01\xFF\x02\x02\xFE\xFE\xFE\xFE\xFE\x02\x02\xFF\x00\x01\x02\x02\x02\x02\x02\x02\xFF\xFF\xFE\x01\x01\x02\x02\x02\x01\x02\xFE\xFE\xFE\xFE\xFF\xFE\x01\x01\xFF\xFE\xFE\x01\x02\x01\x02\xFE\xFE\xFE\xFE\xFE\xFE\x00\xFE\xFE\x02\xFF\x01\x02\x02\x01\xFF\xFF\xFE\xFE\xFE\xFE\xFF\xFE\xFE\xFE\xFE\xFE\xFE\x01\xFE\xFE\xFE\x01\x01\xFE\xFF\x02\x01\xFE\x02\x01\xFE\xFF\xFF\x02\x01\xFF\x02\x02\xFE\x02\xFE\xFF\xFF\xFE\x01\xFE\x01\x01\xFF\xFE\x00\xFF\xFE\xFF\x00\x00\x02\x02\xFF\x02\xFF\x02\x02\x02\x02\x01\x02\x01\x00\x02\x02\x02\x01\x02\x02\x00\x01\x02\x02\x02\x02\x02\x02\xFF\x02\x02\x02\x02\xFF\xFE\xFE\xFE\xFE\xFF\x00\xFE\xFF\xFF\x02\x02\x01\x02\x02\x02\xFE\xFF\x01\xFE\x01\xFF\x00\xFE\xFF\x00\x00\xFE\xFE\x00\xFF\xFE\xFE\xFE\x01\xFF\xFE\xFE\xFE\x01\x01\xFE\xFE\x01\xFF\x01\xFE\x00\xFE\xFF\xFE\x02\xFF\x02".force_encoding('BINARY')
    assert_equal expected, @puzzle.vector
  end

  def test_compare
    pattern = File.join(File.expand_path('..', __FILE__), 'tony*.{jpg,png,gif}')
    Dir[pattern].map{ |path| Puzzle.new(path) }.combination(2).each do |pair|
      assert pair[0] == pair[1]
    end
  end

  def test_compress
    assert_equal @compressed, @puzzle.compress
  end

  def test_uncompress
    puzzle = Puzzle.uncompress @compressed
    assert_equal @puzzle.vector, puzzle.vector
  end

end