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

    assert_equal article.record_key, response.headers['Surrogate-Key']
    assert_response(:success)
  end

  test 'article deletion' do
    article = articles(:two)

    delete :destroy, id: article

    assert_redirected_to(articles_path)
    assert_equal false, Article.exists?(article)
  end

  test 'article index links to articles' do
    get :index

    assert_select 'a[href=?]', "/articles/#{articles(:one).id}"
    assert_select 'a[href=?]', "/articles/#{articles(:two).id}"
  end
end
