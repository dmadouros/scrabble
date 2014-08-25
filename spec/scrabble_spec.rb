require './lib/scrabble'

describe Scrabble do

  describe '.score' do
    it 'scores an empty word as 0' do
      expect(Scrabble.score('')).to eq 0
    end

    it 'scores an nil word as 0' do
      expect(Scrabble.score(nil)).to eq 0
    end

    it 'scores a single letter' do
      expect(Scrabble.score('a')).to eq 1
      expect(Scrabble.score('f')).to eq 4
    end

    xit 'scores a word' do
      expect(Scrabble.score('home')).to eq 9
      expect(Scrabble.score('sound')).to eq 6
      expect(Scrabble.score('word')).to eq 8
      expect(Scrabble.score('hello')).to eq 8
    end

    xit 'returns highest score word' do
      word_list = ['home', 'word', 'hello', 'sound']
      expect(Scrabble.highest_score_from(word_list)).to eq 'home'
    end

    xit 'returns the shortest word in the case of a tie' do
      expect(Scrabble.highest_score_from(['hello', 'word', 'sound'])).to eq 'word'
    end

    xit 'returns the word that uses all 7 letters in case of a tie' do
      expect(Scrabble.highest_score_from(['home', 'word', 'silence'])).to eq 'silence'
    end

    xit 'returns the first word if both same length in case of a tie' do
      expect(Scrabble.highest_score_from(['hi', 'word', 'ward'])).to eq 'word'
    end
  end
end