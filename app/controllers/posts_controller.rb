class PostsController < ApplicationController

  def index 
    @posts = Post.all.order("created_at desc")
    posts_json = []
    for posts in @posts
      user = User.find_by({"id" => posts["user_id"]})
      posts_json << {
        "username" => user["username"],
        "real_name" => user["real_name"],
        "body" => posts["body"],
        "created_at" => posts["created_at"]
      }
    end
    respond_to do |format|
      format.html
      format.json { render :json => posts_json}
    end
end

  def create
    post = Post.new
    post["body"] = params["body"]
    post["user_id"] = current_user["id"]
    post.save
    redirect_to "/posts"
  end

end
