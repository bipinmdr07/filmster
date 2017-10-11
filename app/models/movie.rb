class Movie < ActiveRecord::Base
  has_one :review
  validates_presence_of :title, :plot, :release_date, :released, :runtime, :popularity, :genre, :language, :budget, :average_vote, :vote_count, :poster, :homepage, :tmdb_id, :imdb_id
end
