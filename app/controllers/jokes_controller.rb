class JokesController < ApplicationController
  # Since Knock gem is installed in this API, then we are able to use the "authenticate_user" action
  before_action :authenticate_user, except: [:index, :random, :show]
  before_action :set_joke, only: [:show, :update, :destroy]
  # Note: check_owner needs to be after the set_joke since there needs to be a joke there for accessing
  before_action :check_owner, only: [:update, :destroy]

  def index
    @jokes = Joke.all
    render json: @jokes
  end
  
  def create
    @joke = current_user.jokes.create(joke_params)
    if @joke.errors.any?
      render json: @joke.errors, status: :unprocessable_entity # fails to meet validation
    else
      render json: @joke, status: 201
    end
  end

  def show
    render json: @joke.transform_joke
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

  # Checks whether or not the user is the actual owner of the joke
  def check_owner
    if current_user.id != @joke.user.id
      render json: {error: "You are not permitted"}, status: 401
    end
  end
  

end
