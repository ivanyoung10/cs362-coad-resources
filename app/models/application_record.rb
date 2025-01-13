# Active Record:
# Unknown, but probably checks if something is currently happening or if it is a past event that is no longer relevant.

# Application Record:
# The application record is what all of the input for Ticket, Organization, Region, User, and ResourceCategory is a parent class of.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
