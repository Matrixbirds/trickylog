# == Schema Information
# Schema version: 20160310132348
#
# Table name: comments
#
#  id         :uuid             not null, primary key
#  title      :string           not null
#  content    :string
#  author_id  :uuid             not null
#  article_id :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default(0), not null
#
# Foreign Keys
#
#  fk_rails_f44b1e3c8a  (author_id => users.id)
#

class Comment < ActiveRecord::Base
  enum status: %i[normal deprecated hidden]
  belongs_to :author, class_name: :User, foreign_key: :author_id, touch: true
  belongs_to :article

  validates :content, :title, presence: true
  validates_uniqueness_of :title
end
