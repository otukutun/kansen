class League < ActiveHash::Base
  include ActiveHash::Associations
  has_many :matches
end