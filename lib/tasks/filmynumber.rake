require 'movie_run_data'

namespace :filmynumber do
  
  if ENV['RAILS_ENV'] == "test"
    task(:environment) do
    end
  end
  
  desc "Pull and load the data related to movies currently running in hyderabad"
  task(:load => :environment) do
    mrd = MovieRunData.new
    mrd.populate
  end

  desc "Calculate max potential viewership percentage"
  task(:daily_analytics => :environment) do
    sql_query = <<-eos
      INSERT INTO daily_analytics(movie_id, movie_name,run_date, show_count, show_percent)
      SELECT m.id as movie_id, m.name as movie_name, now() as run_date,
      COUNT(s.movie_id) AS show_count, (COUNT(s.movie_id)/all_shows.total)*100 AS show_percent
      FROM shows s, movies m, (SELECT COUNT(id) AS total FROM shows) all_shows
      WHERE s.movie_id = m.id GROUP BY(s.movie_id);
    eos
    ActiveRecord::Base.connection.execute(sql_query)
  end
  
end
