class Rest::PostsController < ApplicationController
  layout false
  before_action :authenticate, :fetch_room
  respond_to :json

  def create
    post = @room.posts.create(post_params)
    post.user = current_user
    respond_with :rest, post
  end

  def update
  end

  def destroy
  end

  private

  def fetch_room
    @room = Room.find(params[:room_id])
  end

  def post_params
    params.require(:post).permit(:text, :room_id)
  end
end
