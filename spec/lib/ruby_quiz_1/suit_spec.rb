describe Suit do

  let :name do
    :club
  end

  let :value do
    0
  end

  subject do
    described_class.new name, value
  end

  it "initiazes and gets the name" do
    expect(subject.name).to eq name
  end

  it "initializes and gets the name" do
    expect(subject.value).to eq value
  end

end
