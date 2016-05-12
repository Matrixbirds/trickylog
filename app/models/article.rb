# == Schema Information
# Schema version: 20160310132348
#
# Table name: articles
#
#  id             :uuid             not null, primary key
#  title          :string           not null
#  subtitle       :string
#  slug           :string           indexed
#  description    :string
#  author_id      :uuid             not null
#  content        :text             not null
#  comments_count :string           default("0"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :integer          default(0), not null
#
# Indexes
#
#  index_articles_on_slug  (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_e74ce85cbc  (author_id => users.id)
#

class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  paginates_per 5

  enum status: %i[normal deprecated hidden]

  default_scope ->{ order('created_at') }

  belongs_to :author, class_name: :User, foreign_key: :author_id

  has_many :comments

  validates :title, :content, presence: true
  validates_uniqueness_of :title

  def normalize_friendly_id(input)
    "#{PinYin.of_string(input).join("-")}"
  end

  def should_generate_new_friendly_id?
    title_changed? || super
  end

end
