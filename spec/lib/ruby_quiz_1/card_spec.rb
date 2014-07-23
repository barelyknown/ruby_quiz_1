describe Card do

  let :suit do
    Suit.new :club, 0
  end

  it "can be initialized with a value from 1 to 13" do
    (1..13).each do |n|
      expect{described_class.new(n, suit)}.not_to raise_error
    end
  end

  it "cannot be initialized with a value below 1 or above 13" do
    [0,14].each do |n|
      expect{described_class.new(n, suit)}.to raise_error ArgumentError
    end
  end

  it "calculates the total value" do
    subject = described_class.new 1, Suit.new(:diamond, 13)
    expect(subject.total_value).to eq 14
  end

end
