require 'pry-byebug'

AddMovieMutation = GraphQL::Relay::Mutation.define do
    name "AddMovie"
    
    input_field :title, !types.String
    input_field :summary, !types.String
    input_field :year, !types.Int

    return_field :movie, MovieType

    resolve -> (object, args, ctx) {
        movie = Movie.new(
            title: args.title,
            summary: args.summary,
            year: args.year
        )

        movie.save!
        { movie: movie }
    }
end