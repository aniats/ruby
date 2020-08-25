# frozen_string_literal: true

require 'dry-schema'

require_relative 'schema_types'

CompensationForInterestFormSchema = Dry::Schema.Params do
  required(:date).filled(:date)
end
