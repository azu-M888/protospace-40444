class CommentsController < ApplicationController

  def new
    @Comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save!
        redirect_to "/prototype/#{@comment.prototype_id}"
    else
        @prototype = Prototype.find(params[:id])
        @comments = @prototype.comments
        render "prototypes/show"
    end
end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end