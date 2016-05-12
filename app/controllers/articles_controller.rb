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

class ArticlesController < ApplicationController

  before_action :find_article, only: [:update, :show, :destroy]

  def index
    @articles = Article.page(params[:page])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "创建成功"
      redirect_to article_path(@article)
    else
      flash[:failure] = "创建失败"
      redirect_to :back
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "更新成功"
      redirect_to article_path(@article)
    else
      flash[:failure] = "更新失败"
      redirect_to :back
    end
  end

  def show
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
    def find_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description, :author_id, :content, :comments_count, :created_at, :updated_at, :status)
    end

end
