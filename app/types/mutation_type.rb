MutationType = GraphQL::ObjectType.define do
    name "Mutation"

    field :add_movie, field: AddMovieMutation.field
    field :add_actor, field: AddActorMutation.field
end