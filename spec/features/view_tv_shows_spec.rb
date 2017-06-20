require "spec_helper"
require "pry"

feature "user views list of TV shows" do
  # As a TV fanatic
  # I want to view a list of TV shows
  # So I can find new shows to watch
  #
  # Acceptance Criteria:
  # * I can see the names and networks of all TV shows

  scenario "view list of TV shows" do
    # First create some sample TV shows
    game_of_thrones = TelevisionShow.create!({
        title: "Game of Thrones", network: "HBO",
        starting_year: 2011, genre: "Fantasy"
      })

    married_with_children = TelevisionShow.create!({
        title: "Married... with Children", network: "Fox",
        starting_year: 1987, ending_year: 1997,
        genre: "Comedy"
      })

    # The user visits the index page
    visit "/television_shows"

    # And should see both TV shows listed (just the title and network)
    expect(page).to have_content("Game of Thrones (HBO)")
    expect(page).to have_content("Married... with Children (Fox)")
  end

  # As a TV fanatic
  # I want to view the details for a TV show
  # So I can find learn more about it

  # Acceptance Criteria:
  # * I can see the title, network, start and end year, genre, and synopsis
  #   for a show.
  # * If the end year is not provided it should indicate that the show is still
  #   running.

  scenario "view details for a TV show" do

    a_team = TelevisionShow.create!({
        title: "A-Team", network: "NBC",
        starting_year: 1983, ending_year: 1987, genre: "Action"
      })

    visit '/television_shows/4'

    expect(a_team.title).to eq("A-Team")
    expect(a_team.network.downcase).to eq("nbc")
    expect(a_team.starting_year).to eq(1983)
    expect(a_team.ending_year).to eq(1987)
    expect(a_team.genre.downcase).to eq("action")
    expect(a_team.synopsis).to eq(nil)
  end

  scenario "view details for a TV show with missing information" do
    this_old_house = TelevisionShow.create!({
        title: "This Old House", network: "PBS",
        starting_year: 1979, genre: "Action"
      })

    visit '/television_shows/5'

    expect(this_old_house.title).to eq("This Old House")
    expect(this_old_house.network.downcase).to eq("pbs")
    expect(this_old_house.starting_year).to eq(1979)
    expect(this_old_house.ending_year).to eq(nil)
    expect(this_old_house.genre.downcase).to eq("action")
    expect(this_old_house.synopsis).to eq(nil)

  end
end
