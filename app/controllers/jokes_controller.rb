class JokesController < ApplicationController
  before_action :set_joke, only: [:show, :update, :destroy]

  def index
    @jokes = Joke.all
    render json: @jokes
  end
  
  def create
    @joke = Joke.create(joke_params)
    if @joke.errors.any?
      render json: @joke.errors, status: :unprocessable_entity # fails to meet validation
    else
      render json: @joke, status: 201
    end
  end

  def show
    render json: @joke
  end

  def update
    @joke.update(joke_params)
    if @joke.errors.any?
      render json: @joke.errors, status: :unprocessable_entity # fails to meet validation
    else
      render json: @joke, status: 201
    end
  end
  
  def destroy
    @joke.delete
    render json: 204
  end
  
  def random
    # Checks if there are categories listed in params
    if params[:category]
      puts "Searching for #{params[:category]}"
      count = Joke.find_by_category(params[:category]).count

      # This will run if there are no jokes under the category and ends
      if count == 0
        return render json: {error: "No jokes of that category"}, status: 404
      end

      # Pulls the random joke from the category
      @joke = Joke.find_by_category(params[:category]).offset(rand(count)).first
    
    # Below will run when category params is not called
    else
      # Get a random joke from the mix
      offset = rand(Joke.count)
      @joke = Joke.offset(offset).first
    end

    # Renders and returns the joke
    render json: @joke, status: 200
  end
  


  private
  def joke_params
    params.require(:joke).permit(:category_id, :body)
  end
  
  def set_joke
    begin
      @joke = Joke.find(params[:id])
    rescue => exception
      render json: {error: "Joke Not found"}, status: 404 
    end
  end
  

end
