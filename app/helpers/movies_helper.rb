module MoviesHelper

    def total_gross(movie)
        gross = movie.total_gross
        if movie.flop?
            "Flop!"
        else     
            number_to_currency(movie.total_gross)
        end
    end

    def year_of(movie)
        #movie.released_on.strftime("%Y")
        movie.released_on.year
    end

    def average_stars(movie)
        if movie.average_stars.zero?
            content_tag(:strong, "No reviews")
        else
            "*" * movie.average_stars.round
        end
    end

    def nav_link_to(filter, url)
        if current_page?(url)
            link_to filter, url, class: "active"
        else
            link_to filter, url
        end
    end

end
