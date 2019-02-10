class Episode < ApplicationRecord
  has_one_attached :episode_image
  has_one_attached :mp3_file
  belongs_to :podcast
end
