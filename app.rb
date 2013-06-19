require "bundler/setup"
require "sinatra"

get '/' do
  erb :index
end

get '/:width/:height' do
    width = params[:width]
    height = params[:height]


end