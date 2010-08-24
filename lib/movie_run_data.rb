require 'nokogiri'
require 'open-uri'

class MovieRunData
  def initialize
    page_1 = Nokogiri::HTML(open('http://www.google.co.in/movies?near=hyderabad&hl=en&sort=1'))
    page_2 = Nokogiri::HTML(open('http://www.google.co.in/movies?near=hyderabad&hl=en&sort=1&start=10'))
    @pages = [page_1, page_2]
    @pages = [page_1]
  end
  
  def populate
    @pages.each do |page|
      page.search('div[@class="movie_results"]/div[@class="movie"]').each do |movie|
        movie_name = movie.search('div[@class="header"]/div[@class="desc"]/h2/a').first.content
        @movie_record = Movie.find_or_create_by_name(movie_name)
      
        # populate movie run data
        if( movie.search('p[@class="show_more"]').empty? )
          visit_theaters(movie)
        else
          google_movie_page = Nokogiri::HTML(open(
            'http://www.google.co.in' + movie.search('p[@class="show_more"]/a').first['href']
          ))
          this_movie = google_movie_page.search('div[@class="movie_results"]/div[@class="movie"]')
          visit_theaters(this_movie)
        end
      end
    end
  end
  
  private
  
  def visit_theaters(movie)
    movie.search('div[@class="showtimes"]/div[@class]/div[@class="theater"]').each do |theater|
      show_theater_name_times(theater)
    end
  end
  
  def show_theater_name_times(theater)
    theater_name = theater.search('div[@id]/div[@class="name"]/a').first.content
    @theater_record = Theater.find_or_create_by_name(theater_name)
    
    show_times_str = theater.search('div[@class="times"]').first.content
    
    show_times = show_times_str.scan(/\d{1,2}:\d{1,2}\s*(?:am|pm){0,1}/)
    show_times = show_times.map {|show_time| show_time.rstrip }
    if( show_times[0] !~ /(?:am|pm)$/ && show_times[0].match(/(^\d{1,2}):\d{1,2}/)[1].to_i < 12 )
      show_times[0] += "am"
    end
    show_times = show_times.map {|show_time|
      show_time.rstrip
      show_time !~ /(?:am|pm)$/ ? show_time += "pm" : show_time
    }
    show_times.each {|show_time|
      @show_record = Show.create(
        :start => DateTime.strptime(Date.today.to_s + " " + show_time, "%Y-%m-%d %I:%M%p"),
        :theater => @theater_record,
        :movie => @movie_record
      )
    }
  end
end
