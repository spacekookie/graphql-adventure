
QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root for this schema"

  field :movie do
    type MovieType
    argument :id, !types.ID
    resolve -> (obj, args, ctx) {
      Movie.find(args[:id])
    }
  end
  
  field :actor do
    type ActorType
    argument :id, !types.ID
    resolve -> (obj, args, ctx) {
      Actor.find(args[:id])
    }
  end

  field :movies do
    type types[MovieType]
    argument :year, types.Int
    resolve -> (obj, args, ctx) {
      if args[:year].present?
        Movie.where(year: args[:year])
      else
        Movie.all
      end
    }
  end
end