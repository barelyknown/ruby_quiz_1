describe StandardDeck do

  it "has the right cards in the right order" do
    expect(subject.collect(&:total_value)).to eq (1..52).to_a + [53, 53]
  end

end
