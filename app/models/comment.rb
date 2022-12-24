class Comment < ApplicationRecord

  belongs_to :customer

  belongs_to :photo

  has_many :reports, dependent: :destroy

end
