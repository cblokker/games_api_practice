class Video < ActiveRecord::Base
  belongs_to :player

  has_attached_file :attachment, processors: [:transcoder]
  validates_attachment_content_type :attachment, content_type: /\Avideo\/.*\Z/
end
