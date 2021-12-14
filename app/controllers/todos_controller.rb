class TodosController < ApplicationController
  before_action :set_todo, only: %i[show update destroy]

  # GET /todos. -----------
  def index
    @todos = Todo.all
    render_json_response(@todos)
  end

  # POST /todos. -----------
  def create
    # Note that we’re using create! instead of create.
    # The model will raise an exception ActiveRecord::RecordInvalid
    # so we can avoid deep nested if statements in the controller.
    @todo = Todo.create!(todo_params)
    render_json_response(@todo, :created)
  end

  # GET /todos/:id. -----------
  def show
    render_json_response(@todo)
  end

  # PUT /todos/:id. -----------
  def update
    @todo.update(todo_params)
    head :no_content
  end

  # DELETE /todos/:id. -----------
  def destroy
    @todo.destroy
    head :no_content
  end

  # ----------- -----------
  private

  def todo_params
    # Whitelist params.
    params.permit(:title, :created_by)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
