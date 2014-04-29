class CommentsController < ApplicationController
  def create
  end

  def destroy
  end
  private
  def get_commentable
    @commentable = params[:commentable].classify.constantize.find(commentable_id)
  end

  def commentable_id
    params[(params[:commentable].singularize + "_id").to_sym]
  end
end
