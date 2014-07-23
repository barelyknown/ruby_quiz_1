describe Message do

  describe "#decrypt" do
    {
      "CLEPK HHNIY CFPWH FDFEH" => "YOURC IPHER ISWOR KINGX",
      "ABVAW LWZSY OORYK DUPVH" => "WELCO METOR UBYQU IZXXX"
    }.each do |k,v|
      context "with the encrypted message \"#{k}\"" do
        subject do
          described_class.new k
        end
        it "decrypts to \"#{v}\"" do
          expect(subject.decrypt).to eq v
        end
      end
    end
  end

  describe "#encrypt" do
    {
      "YOURC IPHER ISWOR KINGX" => "CLEPK HHNIY CFPWH FDFEH",
      "WELCO METOR UBYQU IZXXX" => "ABVAW LWZSY OORYK DUPVH",
      "WELCO METOR UBYQU IZ" => "ABVAW LWZSY OORYK DUPVH",
    }.each do |k,v|
      context "with the message #{k}" do
        subject do
          described_class.new k
        end
        it "encrypts to \"#{v}\"" do
          puts subject.send(:character_groups).collect(&:characters).join(" ")
          expect(subject.encrypt).to eq v
        end
      end
    end
  end

  describe "#character_groups", :private do
    {
      "HELLO WORLD" => "HELLO WORLD",
      "Hi There How Are You" => "HITHE REHOW AREYO UXXXX",
      "HI! IT IS VERY NICE to see you" => "HIITI SVERY NICET OSEEY OUXXX"
    }.each do |key, value|
      context "with a message #{key}" do
        subject { described_class.new key }
        let :character_groups do
          value.split(" ").collect { |v| CharacterGroup.new(v) }
        end
        it "builds the character groups #{value}" do
          expect(subject.character_groups).to eq character_groups
        end
      end
    end
  end

end
