class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    # @users = User.all
    @users = User.paginate(:page => params[:page], :per_page=>10)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def page_show
     table = params[:table].to_i
     # @users = User.paginate(:page => params[:page], :per_page=>5)
    if table == 5
      @users = User.first(5)
    elsif table ==10
      @users = User.first(10)
    elsif table==15
      @users = User.first(15)
    elsif table==20
      @users = User.first(20)
    else
      @users = User.all
    end
     respond_to do |format|
     format.js
    end
  end

  def import
    # debugger
    User.import(params[:file])
    redirect_to root_url, notice: "Data Imported"
  end

  def do_search
    # debugger
    # @users = User.where("name Like ?", "%#{params[:search]}%")
      @users = User.where("name Like ?", "%#{params[:search]}%")
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :address, :mobile)
    end
end
