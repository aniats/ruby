require 'dry-schema'

TriangleFilterFormSchema = Dry::Schema.Params do
  required(:min).filled(:float)
  required(:max).filled(:float)
end
