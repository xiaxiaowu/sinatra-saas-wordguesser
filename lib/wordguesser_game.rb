class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses,:wrong_guesses,:word_with_guesses
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = ''
    $i=0
    while $i<@word.size do
      $i+=1
      @word_with_guesses=@word_with_guesses + '-'
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

  def guess(guesse)
    raise ArgumentError if guesse == '' or guesse=~/[^a-zA-Z]/ or guesse==nil
    guesse=guesse.downcase
    if guesses.include? guesse or wrong_guesses.include? guesse
      return false
    elsif word.include? guesse
      $i=0
      while $i<@word.size do
        if guesse==@word[$i]
          word_with_guesses[$i]=guesse
        end
        $i+=1
      end
      @guesses = @guesses+guesse
      return true
    else
      @wrong_guesses = @wrong_guesses+guesse
      return true
    end
  end

  def check_win_or_lose()
    if word_with_guesses==word
      return :win
    elsif @guesses.size+@wrong_guesses.size >= 7
      return :lose
    else
      return :play
    end
  end
end

