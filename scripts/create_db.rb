require 'sequel'

DB = Sequel.sqlite('db/blog_db.db')

DB.create_table :users do
	String :id, :primary_key=>true
	String :password
	String :name
	String :surname
	String :email
end

DB.create_table :posts do
  primary_key :id
  String :title
  String :content
  Datetime :created_at
  Datetime :updated_at
  foreign_key(:user_id, :users, :type=>String)
  Integer :view_count
end

DB.create_table :comments do 
  primary_key :id
  String :content
  Datetime :created_at
  Datetime :updated_at
  foreign_key(:user_id, :users, :type=>String)
  foreign_key(:post_id, :posts)
end

DB.create_table :tags do
  primary_key :id
  String :name
end

DB.create_join_table(:post_id=>:posts, :tag_id=>:tags)