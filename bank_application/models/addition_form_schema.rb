# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'

AdditionFormSchema = Dry::Schema.Params do
  required(:sum).filled(:float, gt?: 0)
  required(:account_number).filled(:integer, gt?: 0)
  required(:surname).filled(SchemaTypes::StrippedString, format?: /^([A-Za-zА-Яа-я])+$/)
  required(:key_word).filled(SchemaTypes::StrippedString, format?: /^([A-Za-zА-Яа-я])+$/)
end
