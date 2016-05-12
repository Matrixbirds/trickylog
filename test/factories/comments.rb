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

FactoryGirl.define do
  factory :comment do
    title "Hello, #{FFaker::Name.name}"
    content "Hello, #{FFaker::Name.name}"
    trait :associate_author do
      association :author, factory: :user, name: FFaker::Name.name
    end
    trait :associate_article do
      association :article, factory: :article
    end
  end
end
