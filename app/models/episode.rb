class Episode < ApplicationRecord
  has_one_attached :episode_image
  belongs_to :podcast
end
