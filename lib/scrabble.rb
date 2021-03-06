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
      @comparator = ComparatorChain.new([ScoreComparator.new, LengthComparator.new])
    end

    def score
      return 0 unless present?

      chars.map { |char| SCORES[char] }.reduce(:+)
    end

    def length
      text.length
    end

    def to_s
      text
    end

    private

    attr_reader :comparator

    def <=>(other)
      comparator.compare(self, other)
    end

    def chars
      text.upcase.chars
    end

    def present?
      !text.nil? && !text.empty?
    end
  end

  class Comparator
    def compare(this, that)
      raise NotImplementedError
    end
  end

  class ComparatorChain < Comparator
    def initialize(comparators)
      @comparators = comparators
    end

    def compare(this, that)
      comparators.map do |comparator|
        comparator.compare(this, that)
      end.find do |comparison_result|
        !comparison_result.zero?
      end || 0
    end

    private

    attr_reader :comparators
  end

  class ScoreComparator < Comparator
    def compare(this, that)
      this.score <=> that.score
    end
  end

  class LengthComparator < Comparator
    MAX_LETTERS = 7

    def compare(this, that)
      return 1 if this.length == MAX_LETTERS
      return -1 if that.length == MAX_LETTERS
      that.length <=> this.length
    end
  end
end
