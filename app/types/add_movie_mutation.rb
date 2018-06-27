require 'pry-byebug'

AddMovieMutation = GraphQL::Relay::Mutation.define do
    name "AddMovie"
    
    input_field :title, !types.String
    input_field :summary, !types.String
    input_field :year, !types.Int
    input_field :actorIds, types[types.Int]

    return_field :movie, MovieType
    return_field :errors, types.String

    resolve -> (object, args, ctx) {
        if movie = Movie.find_by_title(args.title)
            return { movie: movie }
        end
        
        movie = Movie.new(
            title: args.title,
            summary: args.summary,
            year: args.year
        )

        # add association of actors to this movie
        if args.actorIds.size > 0
            actors = Actor.find(args.actorIds)
            movie.actors << actors
        end

        # If saving was successful
        if movie.save 
            { movie: movie }
        else
            { movie: nil }
        end
    }
end