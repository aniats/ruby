# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'
require_relative 'store'

ContributorFormSchema = Dry::Schema.Params do
  required(:name).filled(SchemaTypes::StrippedString, format?: /^([A-Za-zА-Яа-я])+$/)
  required(:surname).filled(SchemaTypes::StrippedString, format?: /^([A-Za-zА-Яа-я])+$/)
  required(:patronymic).filled(SchemaTypes::StrippedString, format?: /^([A-Za-zА-Яа-я])+$/)
  required(:deposit_type).filled(SchemaTypes::StrippedString,
                                 format?: /^(([A-Za-zА-Яа-я]+)([' ']?))+$/)
  required(:account_number).filled(:integer, gt?: 0)
  required(:sum).filled(:float, gt?: 0)
  required(:start_date).filled(:date)
  required(:key_word).filled(SchemaTypes::StrippedString, format?: /^([A-Za-zА-Яа-я])+$/)
  required(:last_date).filled(:date)
end
