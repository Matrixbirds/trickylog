class HomeController < ApplicationController
  def hackathon
  end

  def picture
  end

  def message_board
  end

  def weekly
    @news = News.page(params[:page]).per(30)
  end
end
