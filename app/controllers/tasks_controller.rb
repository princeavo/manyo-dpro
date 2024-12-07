class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    if params[:sort_deadline_on].blank?
      #@tasks = Task.order_by_created_at.page(params[:page])
      if params[:sort_prority].blank?
        @tasks = Task.order_by_created_at.page(params[:page])
      else
        @tasks = Task.order_by_priority_desc.page(params[:page])
      end
    else
      @tasks = Task.order_by_deadline.page(params[:page])
    end

    if params[:title].present? && params[:status].present?
      # return search results where both name and status are valid
      @tasks = Task.search_title(params[:title]).search_status(params[:status]).page(params[:page])
      # When the only parameter passed is the task name
    elsif params[:title].present?
      @tasks = Task.search_title(params[:title]).page(params[:page])
      # When the only parameter passed is status
    elsif params[:status].present?
      @tasks = Task.search_status(params[:status]).page(params[:page])
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: t('notice.create_task') }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: t('notice.update_task') }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_path, status: :see_other, notice: t('notice.delete_task') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :content,:deadline_on,:priority,:status)
    end
end
