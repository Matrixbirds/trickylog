# == Schema Information
# Schema version: 20160310132348
#
# Table name: articles
#
#  id             :uuid             not null, primary key
#  title          :string           not null
#  description    :string
#  author_id      :uuid             not null
#  content        :text             not null
#  comments_count :string           default("0"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :integer          default(0), not null
#
# Foreign Keys
#
#  fk_rails_e74ce85cbc  (author_id => users.id)
#

require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

  setup do
    @article = create(:article)
  end

  test 'should access index with http status 200' do
    get :index
    assert_response :success
  end

  test 'should access page parameters' do
    get :index, page: 1
    assert_response :success
  end

  test 'should access create with http status 200' do
    assert_difference 'Article.count', 1 do
      post :create, article: attributes_for(:article, :author_id => @article.author.id)
    end
  end

  test 'should delete article success' do
    assert_difference 'Article.count', -1 do
      delete :destroy, id: @article.id
    end
    assert_redirected_to articles_path
  end

  test 'should access show with http status 200' do
    get :show, id: PinYin.of_string(@article.title).join('-')
    assert_response :success
  end

  test 'should access update with http status 200' do
    article_params = attributes_for(:article)
    put :update, id: PinYin.of_string(@article.title).join('-'), article: { title: article_params[:title] }
    assert_redirected_to @article.reload
    assert_equal article_params[:title], Article.last.title
  end

end
