class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

#=================================================================== 
  def new_deposit
    @account = Account.find(params[:id])
  end
  def create_deposit
    @account = Account.find(params[:id])
    if deposit_params[:amount].to_f > 1000 #&& @account.deposit(deposit_params)
      flash[:alert] = "Deposit more than a thousand in same day is not allowed "
      render :new_deposit
    else
      if @account.deposit(deposit_params)
        flash[:notice] = "Deposit completed Successfully"
        @account.transactions.create!(amount: deposit_params[:amount] , debit: true ,atm_machine_id: session[:my_atm])
        redirect_to atm_machine_path(session[:my_atm])  
      else
        flash.alert = @account.errors.full_messages.to_sentence
        render :new_deposit
      end
    end
  end
#============================================================== 
  def new_withdrawal
    @account = Account.find(params[:id])
  end
  def create_withdrawal
     @account = Account.find(params[:id])
    if withdrawal_params[:amount].to_f >= 500# && @account.withdrawal(withdrawal_params)
      flash[:alert] = "Withdrawal not completed Successfully maybe amount more than 500"
      render :new_withdrawal
    else
      if @account.withdrawal(withdrawal_params)
        flash[:notice] = "Withsrawal completed Successfully"
        @account.transactions.create!(amount: deposit_params[:amount] , debit: false ,atm_machine_id: session[:my_atm])
        redirect_to atm_machine_path(session[:my_atm])  
      else
        flash.alert = @account.errors.full_messages.to_sentence
        render :new_withdrawal
      end
    end
  end
#===============================================================  
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
    session[:my_atm] = params[:my_atm] 
  end
 
  # GET /accounts/1/edit
  def edit
    session[:my_atm] = params[:my_atm] 
  end
  
  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:account_number, :account_id, :balance, :status)
  end

  def deposit_params
      params.require(:account).permit(:amount)
  end
  
  def withdrawal_params
    params.require(:account).permit(:amount)
  end
end
