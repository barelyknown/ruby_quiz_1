module RubyQuiz1
  class CharacterGroup

    def initialize(value, solitaire=nil)
      raise ArgumentError unless String(value) =~ /\A[A-Z]{1,5}\z/
      @value = String(value)
      @keystream = generate_keystream(solitaire) if solitaire
    end

    def characters
      pad(value)
    end

    def numbers
      @numbers ||= characters.chars.collect do |c|
        ("A".."Z").to_a.index(c) + 1
      end
    end

    def encrypted
      return unless keystream
      convert_to_characters(encrypted_numbers)
    end

    def decrypted
      return unless keystream
      convert_to_characters(decrypted_numbers)
    end

    def ==(other)
      characters == other.characters
    end

  private

    def value
      @value
    end

    def pad(value)
      value + "X" * (5 - value.length)
    end

    def keystream
      @keystream
    end

    def generate_keystream(solitaire)
      self.class.new(characters.chars.collect { |l| solitaire.next_key }.join)
    end

    def encrypted_numbers
      numbers.collect.with_index do |n, i|
        e = n + keystream.numbers[i]
        e -= 26 if e > 26
        e
      end
    end

    def decrypted_numbers
      numbers.collect.with_index do |n, i|
        k = keystream.numbers[i]
        n += 26 if n <= k
        n - k
      end
    end

    def convert_to_characters(numbers)
      numbers.collect { |n| ("A".."Z").to_a[n - 1] }.join
    end

  end
end
