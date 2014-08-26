require 'scrabble/version'

module Scrabble
  SCORES = {
    'A' => 1, 'B' => 3, 'C' => 3, 'D' => 2,
    'E' => 1, 'F' => 4, 'G' => 2, 'H' => 4,
    'I' => 1, 'J' => 8, 'K' => 5, 'L' => 1,
    'M' => 3, 'N' => 1, 'O' => 1, 'P' => 3,
    'Q' => 10, 'R' => 1, 'S' => 1, 'T' => 1,
    'U' => 1, 'V' => 4, 'W' => 4, 'X' => 8,
    'Y' => 4, 'Z' => 10
  }

  def self.score(word)
    return 0 if word.nil? || word.empty?

    word.upcase.chars.map do |char|
      SCORES.fetch(char)
    end.reduce(:+)
  end

  def self.highest_score_from(words)
    words.max do |word1, word2|
      [method(:score_comparator), method(:length_comparator)].map do |comparator|
        comparator.call(word1, word2)
      end.max
    end
  end

  def self.score_comparator(word1, word2)
    score(word1) <=> score(word2)
  end

  private_class_method :score_comparator

  def self.length_comparator(word1, word2)
    all_tiles = 7
    return 1 if word1.length == all_tiles
    return -1 if word2.length == all_tiles
    word2.length <=> word1.length
  end

  private_class_method :length_comparator
end
