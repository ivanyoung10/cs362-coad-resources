require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
<<<<<<< HEAD
  it "tests default title" do
    expect(full_title()).to eq "Disaster Resource Network"
  end
=======
  
>>>>>>> 5b125f39b8624b9127581dc376bd9d7c719e7ce5

  it "tests page title addition" do
    expect(full_title("1")).to eq "1 | Disaster Resource Network"
  end
end
