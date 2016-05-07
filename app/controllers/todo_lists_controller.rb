class TodoListsController < ApplicationController
  before_action :require_user
  before_action :set_todo_list, only: [:show, :edit, :update, :destroy]

  def index
    @todo_lists = current_user.todo_lists
  end

  def show
  end

  def new
    @todo_list = current_user.todo_lists.new
  end

  def edit
  end

  def create
    @todo_list = current_user.todo_lists.new(todo_list_params)

    respond_to do |format|
      if @todo_list.save
        format.html { redirect_to @todo_list, notice: 'Todo list was successfully created.' }
        format.json { render action: 'show', status: :created, location: @todo_list }
      else
        format.html { render action: 'new' }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @todo_list.update(todo_list_params)
        format.html { redirect_to @todo_list, notice: 'Todo list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @todo_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo_list.destroy
    respond_to do |format|
      format.html { redirect_to todo_lists_url }
      format.json { head :no_content }
    end
  end

  private
    def set_todo_list
      @todo_list = current_user.todo_lists.find(params[:id])
    end

    def todo_list_params
      params.require(:todo_list).permit(:title)
    end
end

