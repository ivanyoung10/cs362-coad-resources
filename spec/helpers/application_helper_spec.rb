require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it "tests default title" do
    expect(full_title()).to eq "Disaster Resource Network"
  end

  it "tests page title addition" do
    expect(full_title("1")).to eq "1 | Disaster Resource Network"
  end
end
