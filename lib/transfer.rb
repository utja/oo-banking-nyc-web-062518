require_relative '../lib/bank_account'
require 'pry'
class Transfer

  attr_accessor :sender, :receiver, :amount, :status, :counter

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @counter = 0
  end

  def valid?
    if @sender.valid? && @receiver.valid?
      true
    else
      false
    end
  end

  def execute_transaction

    if self.valid? && self.counter < 1 && self.sender.balance > self.amount
      self.sender.deposit(-self.amount)
      self.receiver.deposit(self.amount)
      @status = "complete"
      @counter += 1
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.counter == 1 && self.status == "complete"
      self.sender.deposit(self.amount)
      self.receiver.deposit(-self.amount)
      @status = "reversed"
      @counter -= 1
    end
  end

end
