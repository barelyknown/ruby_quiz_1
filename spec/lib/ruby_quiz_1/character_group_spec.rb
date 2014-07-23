module RubyQuiz1
  describe CharacterGroup do

    let :solitaire do
      Solitaire.new(StandardDeck.new)
    end

    context "when the value is valid and does not need padding" do
      let(:value) { "ABCDE" }
      subject { described_class.new value }
      it "has characters that are the same as the value" do
        expect(subject.characters).to eq value
      end
    end

    context "when the value is valid and needs padding" do
      (1..4).each do |n|
        value = "A" * n
        characters = value + "X" * (5 - n)
        context "with #{5 - n} Xs (#{value})" do
          subject do
            described_class.new value
          end
          it "has the characters #{characters}" do
            expect(subject.characters).to eq characters
          end
        end
      end
    end

    context "when the value is invalid" do
      ["a", "1", "!", nil, "ABCDEF"].each do |value|
        context "such as #{value}" do
          it "raises an argument error" do
            expect{described_class.new(value)}.to raise_error ArgumentError
          end
        end
      end
    end

    it "compares equality to another character group using the characters" do
      value = "ABCDE"
      expect(described_class.new(value)).to eq described_class.new(value)
    end



    describe "private methods", :private do
      {
        "CODEI" => [3,15,4,5,9],
        "NRUBY" => [14,18,21,2,25],
        "LIVEL" => [12,9,22,5,12],
        "ONGER" => [15,14,7,5,18]
      }.each do |k,v|
        it "converts the value #{k} to the numbers #{v}" do
          subject = described_class.new k
          expect(subject.numbers).to eq v
        end
      end

      {
        [[3,15,4,5,9],[4,23,10,24,8]] => [7,12,14,3,17]
      }.each do |k,v|
        it "calculates the encrypted numbers" do
          subject = described_class.new "CODEI"
          allow(subject).to receive(:numbers).and_return(k[0])
          allow(subject).to receive(:keystream).and_return(double(CharacterGroup, numbers: k[1]))
          expect(subject.encrypted_numbers).to eq v
        end
      end

      {
        [[7,12,14,3,17],[4,23,10,24,8]] => [3,15,4,5,9]
      }.each do |k,v|
        it "calculates the decrypted numbers" do
          subject = described_class.new "CODEI"
          allow(subject).to receive(:numbers).and_return(k[0])
          allow(subject).to receive(:keystream).and_return(double(CharacterGroup, numbers: k[1]))
          expect(subject.decrypted_numbers).to eq v
        end
      end

      it "converts numbers to characters" do
        subject = described_class.new "CODEI"
        expect(subject.convert_to_characters([3,15,4,5,9])).to eq "CODEI"
      end
    end


  end
end
