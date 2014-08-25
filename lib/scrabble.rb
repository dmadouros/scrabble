require "scrabble/version"

module Scrabble
  ALL_TILES = 7
  SCORES = {
    "A" => 1, "B" => 3, "C" => 3, "D" => 2,
    "E" => 1, "F" => 4, "G" => 2, "H" => 4,
    "I" => 1, "J" => 8, "K" => 5, "L" => 1,
    "M" => 3, "N" => 1, "O" => 1, "P" => 3,
    "Q" => 10, "R" => 1, "S" => 1, "T" => 1,
    "U" => 1, "V" => 4, "W" => 4, "X" => 8,
    "Y" => 4, "Z" => 10
  }

  def self.score(word)
    return 0 if word.nil? || word.empty?

    word.chars.reduce(0) do |result, letter|
      result + SCORES[letter.upcase]
    end
  end

  def self.highest_score_from(words)
    words.reduce('') do |best_word, word|
      two_words = [best_word, word]
      next resolve_tie_between(two_words) if score(best_word) == score(word)

      two_words.max_by { |w| score(w) }
    end
  end

  def self.resolve_tie_between(two_words)
    return two_words.first if two_words.first.length == ALL_TILES
    return two_words.last if two_words.last.length == ALL_TILES
    return two_words.min_by { |word| word.length }
  end
end
