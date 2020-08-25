# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'

CloseAccountFormSchema = Dry::Schema.Params do
  required(:account_number).filled(:integer, gt?: 0)
  required(:date).filled(:date)
end
