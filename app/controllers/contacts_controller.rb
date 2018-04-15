class ContactsController < ApplicationController
  before_action :find_contact, only: [:show]

  def index
    @contacts = Contact.all.order("created_at DESC")
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(item_params)
    if @contact.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

    def item_params
      params.require(:contact).permit(:first_name, :last_name)
    end

    def find_contact
      @contact = Contact.find(params[:id])
    end

end
