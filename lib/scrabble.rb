require "scrabble/version"

module Scrabble
  def self.score(word)
    Word.new(word).score
  end

  def self.highest_score_from(words)
    words.map { |word| Word.new(word) }.max.text
  end

  class Word
    SCORES = {
      "A" => 1, "B" => 3, "C" => 3, "D" => 2,
      "E" => 1, "F" => 4, "G" => 2, "H" => 4,
      "I" => 1, "J" => 8, "K" => 5, "L" => 1,
      "M" => 3, "N" => 1, "O" => 1, "P" => 3,
      "Q" => 10, "R" => 1, "S" => 1, "T" => 1,
      "U" => 1, "V" => 4, "W" => 4, "X" => 8,
      "Y" => 4, "Z" => 10
    }

    attr_reader :text

    def initialize(text)
      @text = text
    end

    def score
      return 0 unless present?

      chars.map { |char| SCORES[char] }.reduce(:+)
    end

    def length
      text.length
    end

    private

    def <=>(other)
      WordComparator.new(self, other).execute
    end

    def chars
      text.upcase.chars
    end

    def present?
      !text.nil? && !text.empty?
    end
  end

  class WordComparator
    MAX_LETTERS = 7

    def initialize(this, that)
      @this = this
      @that = that
    end

    def execute
      tie? ? resolve_tie : this.score <=> that.score
    end

    private

    attr_reader :this, :that

    def tie?
      this.score == that.score
    end

    def resolve_tie
      return 1 if this.length == MAX_LETTERS
      return -1 if that.length == MAX_LETTERS
      that.length <=> this.length
    end
  end
end
