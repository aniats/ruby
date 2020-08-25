# frozen_string_literal: true

require_relative 'contributor'
require 'forwardable'

# class containing info about all contributors in a bank
class ContributorList
  extend Forwardable
  def_delegator :@contributors_list, :each

  def initialize(contributors = [])
    @contributors_list = contributors.map do |contributor|
      [contributor.id, contributor]
    end.to_h
  end

  def contributor_by_id(id)
    @contributors_list[id]
  end

  def add_contributor(parameters, deposit)
    contributor_id = if @contributors_list.empty?
                       1
                     else
                       @contributors_list.keys.max + 1
                     end
    # parameters.deposit_type = deposit
    parameters.to_h[:deposit_type] = deposit
    @contributors_list[contributor_id] = Contributor.new(id: contributor_id,
                                                         **parameters.to_h)
    # @contributors[contributor_id]
  end

  def add_real_contributor(contributor)
    @contributors_list[contributor.id] = contributor
  end

  def update_contributor(id, parameters)
    contributor = @contributors_list[id]
    parameters.to_h.each do |key, value|
      contributor[key] = value
    end
  end

  def delete_contributor(id)
    @contributors_list.delete(id)
  end

  def all_contributors
    @contributors_list.values
  end

  def contributors_sorted_by_surname
    surnames = {}
    @contributors_list.each do |_key, value|
      surnames[value[:surname]] = { name: value[:name], patronymic: value[:patronymic] }
    end
    surnames.sort.to_h
  end

  def most_popular_deposit
    types = stats_for_most_popular_deposit
    types.each do |_key, value|
      value[:average_sum] = value[:sum] / value[:clients]
    end
    types.sort_by { |_key, value| value[:clients] }.to_a.reverse.to_h
  end

  def stats_for_most_popular_deposit
    types = {}
    @contributors_list.each do |_key, value|
      types[value[:deposit_type]] = if types.key?(value[:deposit_type])
                                      return_res_stats(types[value[:deposit_type]], value)
                                    else
                                      { clients: 1,
                                        sum: value[:sum],
                                        start_date: value[:start_date] }
                                    end
    end
    types
  end

  def return_res_stats(hash1, hash2)
    hash1[:clients] += 1
    hash1[:sum] += hash2[:sum]
    hash1[:start_date] = hash2[:start_date] if hash1[:start_date] < hash2[:start_date]
    hash1
  end

  def account_number?(account_number_)
    @contributors_list.each do |_key, value|
      return [] if value[:account_number] == account_number_.to_i
    end
    ['Такого счета нет']
  end

  def key_word?(key_word_, account_number_)
    @contributors_list.each do |_key, value|
      return [] if value[:account_number] == account_number_.to_i && value[:key_word] == key_word_
    end
    ['Неверное ключевое слово']
  end

  def surname?(surname_, account_number_)
    @contributors_list.each do |_key, value|
      return [] if value[:account_number] == account_number_.to_i && value[:surname] == surname_
    end
    ['Неправильная фамилия']
  end

  def addition?(account_number_)
    @contributors_list.each do |_key, value|
      next unless value[:account_number] == account_number_.to_i

      return [] if value[:deposit_type].addition == 'да'

      return ['Для вашего вклада нет возможности пополнения']
    end
  end

  def errors_possible_to_add(account_number_, surname_, key_word_)
    errors = []
    if errors.concat(account_number?(account_number_)).empty?
      errors.concat(addition?(account_number_))
            .concat(surname?(surname_, account_number_))
            .concat(key_word?(key_word_, account_number_))
    end
    errors
  end

  def close_account(account_number_, date_)
    res = {}
    @contributors_list.each do |key, value|
      next unless value[:account_number] == account_number_.to_i

      value[:sum] = count_sum(value, date_)[:sum]
      res[value[:surname]] = { name: value[:name],
                               patronymic: value[:patronymic],
                               sum: value[:sum] }
      @contributors_list.delete(key)
    end
    res
  end

  def addition(account_number_, sum_)
    @contributors_list.each do |_key, value|
      value[:sum] += sum_.to_i if value[:account_number] == account_number_.to_i
    end
  end

  def compensation_for_interest(date_)
    @contributors_list.each do |key, value|
      @contributors_list[key] = count_sum(value, date_)
    end
  end

  def count_sum(value, date_)
    tmp = Date.parse(date_) - value[:last_date]
    if tmp.to_i >= 1
      value[:sum] = value[:sum] * value[:deposit_type].interest * (tmp / 365)
      value[:last_date] = date_
    end
    value
  end

  def delete_deposit_compensation(deposit_type_, date_)
    contributors_and_money = {}
    @contributors_list.each do |key, value|
      next unless value[:deposit_type].name == deposit_type_

      compensation = count_sum(value, date_)
      contributors_and_money[value[:surname]] = { sum: compensation[:sum], name: value[:name],
                                                  patronymic: value[:patronymic] }
      @contributors_list.delete(key)
    end
    contributors_and_money
  end
end
