class LabelsController < ApplicationController
  def index
    @labels = Label.includes(:tasks).all
    render "labels/index"
  end
  def new
    @label = Label.new
    render "labels/new"
  end
  def create
    @label = Label.create(label_params)
    if @label.save
      flash[:success] = "Label ajouté avec succès"
      redirect_to labels_path
    else
      render "labels/new"
    end
  end
  def edit
    @label = Label.find(params[:id])
    render "labels/update"
  end
  def update
    @label = Label.find(params[:id])
    if @label.update(label_params)
      flash[:success] = t("update_label_page.success_message")
      redirect_to labels_path
    else
      flash[:error] = @label.errors.full_messages.join(', ')
      redirect_to labels_path
    end
  end
  def destroy
    @label = Label.find(params[:id])
    if @label.destroy
      flash[:success] = t("delete_label_page.success_message")
      redirect_to labels_path
    else
      flash[:error] = @label.errors.full_messages.join(', ')
      redirect_to labels_path
    end
  end
  private
    def label_params
      params.require(:label).permit(:name)
    end
end
