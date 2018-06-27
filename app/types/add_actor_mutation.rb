AddActorMutation = GraphQL::Relay::Mutation.define do
    name "AddActor"
    
    input_field :name, !types.String
    input_field :bio, !types.String
    input_field :movieIds, types[types.Int]

    return_field :actor, ActorType
    return_field :errors, types.String

    resolve -> (object, args, ctx) {
        if actor = Actor.find_by_name(args.name)
            return { actor: actor }
        end
        
        actor = Actor.new(
            name: args.name,
            bio: args.bio,
        )

        # add association of actors to this movie
        if args.movieIds.size > 0
            movies = Movie.find(args.movieIds)
            actor.movies << movies
        end

        # If saving was successful
        if actor.save 
            { actor: actor }
        else
            { actor: nil }
        end
    }
end