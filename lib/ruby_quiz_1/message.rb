module RubyQuiz1
  class Message

    def initialize(value, solitaire=Solitaire.new(StandardDeck.new))
      @value = value
      @solitaire = solitaire
    end

    def encrypt
      character_groups.collect(&:encrypted).join(" ")
    end

    def decrypt
      character_groups.collect(&:decrypted).join(" ")
    end

  private

    def value
      @value
    end

    def stripped_value
      value.upcase.gsub(/[^A-Z]/,"")
    end

    def solitaire
      @solitaire
    end

    def character_groups
      @character_groups ||= begin
        stripped_value.chars.each_slice(5).collect do |character_group_value|
          CharacterGroup.new character_group_value.join, solitaire
        end
      end
    end

  end
end
