class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  # ルーティングと同じ名前のメソッド名として定義すれば、対応させられるためまず、7つのアクションを全て対応させた
  def index
    if logged_in?
      @content = current_user.contents.build
      @contents = current_user.contents.order('created_at DESC').page(params[:page])
      @tasks = Task.all.page(params[:page]).per(10)
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end

  def edit
  end

  def update

    if @task.update(task_params)
      flash[:success] = 'Taskは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'このTaskは正常に削除されました'
    redirect_to tasks_url
  end
  
  private

 def set_task
    @task=Task.find(params[:id])
  end

 def task_params
    params.require(:task).permit(:content,:status)
  end
  
end

  