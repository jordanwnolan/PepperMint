class CommentsController < ApplicationController

  def create
    if params[:budget_id]
      item = Budget.find(params[:budget_id])
    elsif params[:goal_id]
      item = Goal.find(params[:goal_id])
    elsif params[:share_id]
      item = Share.find(params[:share_id])
    end

    @comment = item.comments.new(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      flash[:alerts] = ["Comment saved successfully!"]
    else
      flash[:errors] = @comment.errors.full_messages
    end

    if params[:comment][:feed]
      redirect_to feed_url
    else
      redirect_to item
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])

    if @comment
      @comment.destroy
      redirect_to feed_url
    else
      flash[:errors] = ["Something went wrong, you can't delete that comment"]
      redirect_to feed_url
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
