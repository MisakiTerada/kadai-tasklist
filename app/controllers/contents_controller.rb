class ContentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @content = current_user.contents.build(content_params)
    if @content.save
      flash[:success] = " タスクを投稿しました。"
      redirect_to root_url
    else
      @contents = current_user.contents.order('created_at DESC').page(params[:page])
      flash.now[:danger]="タスクの投稿に失敗しました。"
      render "tasks/index"
    end
  end

  def destroy
    @content.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def content_params
    params.require(:content).permit(:content)
  end
    
    def correct_user
    @content = current_user.contents.find_by(id: params[:id])
    unless @content
      redirect_to root_url
    end
  end
end
