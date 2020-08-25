# frozen_string_literal: true

require 'psych'
require_relative 'contributor_list'
require_relative 'contributor'
require_relative 'deposit_list'
require_relative 'deposit'

# Storage for all of our data
class Store
  attr_accessor :contributor_list, :deposit_list

  CONTRIBUTOR_DATA_STORE = File.expand_path('../db/contributor_data.yaml', __dir__)
  DEPOSIT_DATA_STORE = File.expand_path('../db/deposit_data.yaml', __dir__)

  def initialize
    @contributor_list = ContributorList.new
    @deposit_list = DepositList.new
    read_deposit_data
    read_contributor_data
    at_exit { write_contributor_data }
    at_exit { write_deposit_data }
  end

  def update_info
    write_deposit_data
    write_contributor_data
    read_deposit_data
    read_contributor_data
  end

  def deposit_info
    read_deposit_data
    names = []
    @deposit_list.each do |_key, value|
      names << value.name
    end
    names
  end

  def read_contributor_data
    return unless File.exist?(CONTRIBUTOR_DATA_STORE)

    yaml_data = File.read(CONTRIBUTOR_DATA_STORE)
    raw_data = Psych.load(yaml_data, symbolize_names: true)
    raw_data[:contributor_list].each do |raw_contributor|
      raw_contributor[:deposit_type] = @deposit_list
                                       .get_deposit_info_by_name(raw_contributor[:deposit_type])
      @contributor_list.add_real_contributor(Contributor.new(**raw_contributor))
    end
  end

  def read_deposit_data
    return unless File.exist?(DEPOSIT_DATA_STORE)

    yaml_data = File.read(DEPOSIT_DATA_STORE)
    raw_data = Psych.load(yaml_data, symbolize_names: true)
    raw_data[:deposit_list].each do |raw_deposit|
      @deposit_list.add_real_deposit(Deposit.new(**raw_deposit))
    end
  end

  def write_contributor_data
    raw_contributor = @contributor_list.all_contributors.map(&:to_h)
    raw_contributor.each do |value|
      value[:deposit_type] = value[:deposit_type].name
    end
    yaml_data = Psych.dump({
                             contributor_list: raw_contributor
                           })
    File.write(CONTRIBUTOR_DATA_STORE, yaml_data)
  end

  def write_deposit_data
    raw_deposit = @deposit_list.all_deposits.map(&:to_h)
    yaml_data = Psych.dump({
                             deposit_list: raw_deposit
                           })
    File.write(DEPOSIT_DATA_STORE, yaml_data)
  end
end
