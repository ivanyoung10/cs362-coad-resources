require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DashboardHelper, type: :helper do

  it "tests user admin" do
    useradmin = User.create!(email: "admin@gmail.com", role: :admin, password: "password")
    expect(dashboard_for(useradmin)).to eq "admin_dashboard"

  end

  it "tests submitted org" do
    unapprovedorg = Organization.create!(
      name: "unapprovedorg", 
      email: "email@gmail.com", 
      phone: "+1-111-111-1111",
      primary_name: "name",
      secondary_name: "namename",
      secondary_phone: "+1-222-222-2222",
      status: :submitted
    )

    usersubmitedorg = User.create!(
      email: "admin@gmail.com", 
      role: :organization, 
      password: "password",
      organization: unapprovedorg
    )

    expect(dashboard_for(usersubmitedorg)).to eq "organization_submitted_dashboard"

  end

  it "tests approved org" do
    approvedorg = Organization.create!(
      name: "approvedorg", 
      email: "email@gmail.com", 
      phone: "+1-111-111-1111",
      primary_name: "name",
      secondary_name: "namename",
      secondary_phone: "+1-222-222-2222",
      status: :approved
    )

    userapprovedorg = User.create!(
      email: "admin@gmail.com", 
      role: :organization, 
      password: "password",
      organization: approvedorg
    )

    expect(dashboard_for(userapprovedorg)).to eq "organization_approved_dashboard"
  end
end
