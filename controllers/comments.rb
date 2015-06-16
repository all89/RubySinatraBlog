#COMMENT CREATE, EDIT AND DELETE

#Comments are created 
post "/comments" do
  @comment = Comment.new
  @comment.content = params[:content]
  @comment.user_id = session[:user]
  @comment.post_id = params[:post_id]
  @comment.created_at = DateTime.now
  @comment.save
  redirect "/posts/#{params[:post_id]}"
end

get "/comments/:id/edit" do
  @comment = Comment[params[:id]]
  @title = "Edit Comment"
  erb :'comments/edit'
end

put "/comments/:id" do
  @comment = Comment[params[:id]]
  @comment.update(params[:comment])
  redirect "/posts/#{@comment.post_id}"
end

delete "/comments/:id" do
  @comment = Comment[params[:id]].destroy
  redirect "/posts/#{@comment.post_id}"
end