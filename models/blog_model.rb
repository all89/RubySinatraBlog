#blog_model.rb - model of the blog
require 'sequel'

DB = Sequel.sqlite('db/blog_db.db')

Sequel::Model.plugin :timestamps

class User < Sequel::Model
  one_to_many :posts
  one_to_many :comments
end

class Post < Sequel::Model
  many_to_one :user
  one_to_many :comments
  many_to_many :tags, :left_key=>:post_id, :right_key=>:tag_id, :join_table=>:Posts_Tags

  def tag_list=(names)
    names.split(',').map do |n|
      Tag.find_or_create(:name=> n.strip)
    end
  end
end

class Comment < Sequel::Model
  many_to_one :user
  many_to_one :post
end

class Tag < Sequel::Model
  many_to_many :posts, :left_key=>:tag_id, :right_key=>:post_id, :join_table=>:Posts_Tags
end

class Posts_Tags < Sequel::Model
end