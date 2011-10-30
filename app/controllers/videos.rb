Videos.controllers :videos do

  get :index, map: '/' do
    @videos = Video.all
    render 'videos/index'
  end

end
