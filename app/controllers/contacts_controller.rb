class ContactsController < ApplicationController
  before_action :find_contact, only: [:show, :edit, :update, :destroy]

  def index
    if (params.has_key?(:limit) && params.has_key?(:page))
      @limit = params[:limit].to_i
      @page = params[:page].to_i
    else
      @limit = 10
      @page = 1
    end
    @next_page = @page + 1
    @prev_page = @page - 1
    @contacts = Contact.all.order("created_at ASC")
                           .limit(@limit * @page)
                           .offset(@limit * @page - @limit)
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    p contact_params
    if @contact.update(contact_params)
      redirect_to contact_path(@contact)
    else
      render 'edit'
    end
  end

  def destroy
    @contact.destroy
    redirect_to root_path
  end

  private

    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :tag_list)
    end

    def find_contact
      @contact = Contact.find(params[:id])
    end

end
