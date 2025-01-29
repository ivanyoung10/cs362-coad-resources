require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TIcketsHelper. For example:
#
# describe TIcketsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TicketsHelper, type: :helper do

    describe "format phone number" do
      it "adds US code" do
        expect(format_phone_number("+1-111-111-1111")).to eq("+11111111111")
      end
    end

end
