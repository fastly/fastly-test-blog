class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  after_create  :purge_all
  after_save    :purge
  after_destroy :purge, :purge_all

  # Creates a new Comment, associated with an article
  def create_random_comment
    self.comments.create(name: Faker::Name.name, body: Faker::Hacker.say_something_smart)
  end

  # Creates a new Article
  def self.create_random_article
    a = Article.new
    a.title = Faker::Company.catch_phrase
    a.body = Faker::Lorem.paragraph(Random.rand(65..85))
    a.save
    a
  end
end
