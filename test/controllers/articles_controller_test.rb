require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  test 'article creation' do
    assert_difference('Article.count') do
      get :create_article
    end
  end
end
