# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'
require_relative 'store'

DeleteDepositFormSchema = Dry::Schema.Params do
  required(:date).filled(:date)
  required(:deposit_type).filled(SchemaTypes::StrippedString,
                                 format?: /^(([A-Za-zА-Яа-я]+)([' ']?))+$/)
end
