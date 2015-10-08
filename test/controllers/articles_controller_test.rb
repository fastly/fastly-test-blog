require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  test 'article creation' do
    assert_difference('Article.count') do
      get :create_article
    end

    assert_redirected_to(articles_url)

  end

  test 'article show' do
    article = articles(:one)

    get :show, id: article

    assert_equal article.record_key, response.headers["Surrogate-Key"]
    assert_response(:success)
  end
end
