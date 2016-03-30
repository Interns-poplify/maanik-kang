class CommentsController < ApplicationController
def create
	@comment=Comment.new(comment_params)
	@comment.article_id = params[:article_id]
	@comment.user_id = current_user.id
	@comment.save

  redirect_to article_path(@comment.article)
end
def comment_params
  params.require(:comment).permit(:body,:article_id)
end
end
