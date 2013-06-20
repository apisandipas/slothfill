class App < Sinatra::Base
  include Magick

  get '/' do
    erb :index
  end

  get '/:width/:height' do
      # grab params
      width = params[:width]
      height = params[:height]

      raise Sinatra::NotFound unless width.match(/\A[0-9]+\Z/) and height.match(/\A[0-9]+\Z/)

      # Cast as Integers
      width = Integer(width)
      height = Integer(height)


      sloths = [
        'one',
        'two',
        'three',
        'four',
        'five',
        'six'
      ] 

      sloth = sloths.sample

      content_type 'image/jpg'

      image = Magick::Image.read("./sloths/#{sloth}.jpg").first
      image = image.resize_to_fill(width, height)
      image.format = 'jpg'
      image.to_blob

  end

  not_found do
    erb :not_found
  end


end