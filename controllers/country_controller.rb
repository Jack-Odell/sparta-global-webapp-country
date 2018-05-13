class CountryController < Sinatra::Base

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  configure :development do
    register Sinatra::Reloader
  end

  # index
  get "/" do
    @title = "Countries"
    @country = Country.all
    erb :"countrys/index"
  end

  # NEW
  get "/new" do
    @country = Country.new
    erb :"countrys/new"
  end

  # SHOW
  get "/:id" do
    id = params[:id]
    @country = Country.find id
    erb :"countrys/show"
  end

  # EDIT
  get "/:id/edit" do
    id = params[:id]
    @country = Country.find id
    erb :"countrys/edit"
  end

  # POST
  post "/" do
    country = Country.new

    country.country = params[:country]
    country.population = params[:population]
    country.gdp = params[:gdp]

    country.save

    redirect "/"
  end

  # DELETE
  delete "/:id" do
    id = params[:id]

    country = Country.new

    country.destroy id

    redirect "/"
  end

  # UPDATE
  put "/:id" do
    id = params[:id]

    country = Country.find(id)

    country.country = params[:country]
    country.population = params[:population]
    country.gdp = params[:gdp]

    country.save

    redirect "/"

  end
end
