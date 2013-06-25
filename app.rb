class App < Sinatra::Base
  include MiniMagick

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

    if File.exists? "./sloths/cache/#{width}_#{height}.jpg"
      grab_from_cache(width, height)
    else 
      create_new_image(width, height)
    end

  end

  not_found do
    erb :not_found
  end

  def grab_from_cache(width, height)
    puts "Cached File available"
    sloth = File.open "./sloths/cache/#{width}_#{height}.jpg"
    puts "Here be the sloth: #{sloth.to_s}" 
    send_file(sloth)
  end

  def create_new_image(width, height)
    puts "Creating new image..."

    sloths = %w[one two three four five six] 
    sloth = sloths.sample 

    content_type 'image/jpg'
    image = MiniMagick::Image.open("./sloths/#{sloth}.jpg")
    image.resize("#{width}x#{height}")

    puts 'Cacheing new image for future use..'
    image.write("./sloths/cache/#{width}_#{height}.jpg")

    image.to_blob
  end


end