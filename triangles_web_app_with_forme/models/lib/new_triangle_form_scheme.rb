require 'dry-schema'

NewTriangleFormScheme = Dry::Schema.Params do
  required(:first).filled(:float).value(gt?: 0)
  required(:second).filled(:float).value(gt?: 0)
  required(:third).filled(:float).value(gt?: 0)
end