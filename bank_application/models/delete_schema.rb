# frozen_string_literal: true

require 'dry-schema'

DeleteSchema = Dry::Schema.Params do
  required(:confirmation).filled(true)
end
