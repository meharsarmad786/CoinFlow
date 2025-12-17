class TransactionsController < ApplicationController
  before_action :set_cryptocurrency, only: [:new, :create]

  def index
    @transactions = current_user.transactions.recent.page(params[:page]).per(20)
    @filter = params[:filter]
    
    case @filter
    when 'buy'
      @transactions = @transactions.buys
    when 'sell'
      @transactions = @transactions.sells
    end
  end

  def new
    @transaction = Transaction.new
    @transaction.cryptocurrency = @cryptocurrency if @cryptocurrency
    @transaction.transaction_type = params[:type] if params[:type]
  end

  def create
    @transaction = current_user.transactions.build(transaction_params)
    
    if @transaction.save
      redirect_to transactions_path, notice: "Transaction recorded successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_cryptocurrency
    if params[:crypto_id]
      @cryptocurrency = Cryptocurrency.find_by(id: params[:crypto_id]) || Cryptocurrency.find_by(symbol: params[:crypto_id].upcase)
    end
  end

  def transaction_params
    params.require(:transaction).permit(:cryptocurrency_id, :transaction_type, :quantity, :price, :total_amount)
  end
end
