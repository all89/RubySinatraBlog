#POST ADDING, DISPLAYING, EDITING AND DELETING.

#SEARCH AND TAGS

#All posts are ordered from the newest to the oldest, and they are also paginated ( each page has 3 posts ).
get "/" do
  page = params.fetch "page", 1
  per_page = params.fetch "per_page", 3
  @posts = ((Post.order(:created_at).reverse).extension(:pagination).paginate(page.to_i,per_page.to_i))
  @title = "Home || TechX"	
  erb :'posts/index'
end

#New Post form is going to be displayed and using POST below each post is saved into the database and shown in the main page.
get "/posts/create" do
  @post = Post.new
  @title = "Create post"
  erb :'posts/create'
end

#Posts are created with the specific tags.
post "/posts" do
  @post = Post.new
  @post.title = params[:title]
  @post.content = params[:content]
  @post.tag_list = params[:tags]
  @post.user_id = session[:user]
  @post.created_at = DateTime.now
  @post.view_count = 0
  @post.save

  params[:tags].split(',').map do |n|
  tempTag = Tag.where(:name => n.strip).first
  Posts_Tags.insert(:post_id=>@post.id, :tag_id=>tempTag.id)
  end

  redirect '/'
end
  	
#Whenever we click READ MORE or in the Post Title we are going to be forwarded to the specific detailed post.
get "/posts/:id" do
  @post = Post[params[:id]]
  @title = @post.title
  @comments = Comment.where(:post_id => params[:id]).all
  @post.update(:view_count => @post.view_count+1)
  erb :'posts/view'
end

#Each specific post can be edited from the same form and displayed in its new shape.
get "/posts/:id/edit" do
  @post = Post[params[:id]]
  @title = "Edit Form"
  erb :'posts/edit'
end

put "/posts/:id" do
  @post = Post[params[:id]]
  @post.update(params[:post])
  redirect "/posts/#{@post.id}"
end

#Each post can also be deleted and removed from our Blog. When a post is deleted the appropriate comments and tags that belong to that post are also deleted.
delete "/posts/:id" do
  @post_tag = Posts_Tags.where(:post_id => params[:id]).destroy
  @comment = Comment.where(:post_id => params[:id]).destroy
  @post = Post[params[:id]].destroy
  redirect "/"
end


#Search Form
post '/search' do
  @results = Post.where(Sequel.ilike(:title, "%#{params[:query]}%")).all
  erb :'posts/search'
end

#Tags
get '/tags/:id' do
  @tag = Tag[params[:id]]
  erb :'posts/tags'
end