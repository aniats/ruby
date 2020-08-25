# frozen_string_literal: true

require 'forwardable'

# Class containing info about all existing types of deposits
class DepositList
  extend Forwardable
  def_delegator :@deposits_list, :each

  def initialize(deposits = [])
    @deposits_list = deposits.map do |deposit|
      [deposit.id, deposit]
    end.to_h
  end

  def check_if_deposit_exists(name)
    errors = []
    @deposits_list.each do |_key, value|
      return [] if value.name == name

      errors.concat([value.name])
    end
    errors
  end

  def get_deposit_info_by_name(name)
    @deposits_list.each do |_key, value|
      return value if value.name == name
    end
  end

  def deposit_names
    names = []
    @deposits_list.each do |_key, value|
      names << value.name
    end
    names
  end

  def all_deposits
    @deposits_list.values
  end

  def deposit_by_id(id)
    @deposits_list[id]
  end

  def delete_deposit_by_name(name)
    @deposits_list.each do |key, value|
      @deposits_list.delete(key) if value[:name] == name
    end
  end

  def add_deposit(parameters)
    deposit_id = if @deposits_list.empty?
                   1
                 else
                   @deposits_list.keys.max + 1
                 end
    @deposits_list[deposit_id] = Deposit.new(id: deposit_id,
                                             **parameters.to_h)
    # @deposits_list[deposit_id]
  end

  def add_real_deposit(deposit)
    @deposits_list[deposit.id] = deposit
  end

  def update_deposit(id, parameters)
    deposit = @deposits_list[id]
    parameters.to_h.each do |key, value|
      deposit[key] = value
    end
  end

  def delete_deposit(id)
    @deposits_list.delete(id)
  end
end
