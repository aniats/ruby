# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'

DepositFormSchema = Dry::Schema.Params do
  required(:name).filled(SchemaTypes::StrippedString, format?: /^(([A-Za-zА-Яа-я]+)([' ']?))+$/)
  required(:interest).filled(:float, gt?: 0)
  required(:addition).filled(SchemaTypes::StrippedString, included_in?: %w[да нет])
end
