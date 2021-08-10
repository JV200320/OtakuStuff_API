require 'net/http'
require 'uri'
require 'json'

@uri = URI('https://api.jikan.moe/v3/top/anime')
def get(args)
  args.each do |k,v|
    p k
    if k == :hey
      puts('opa')
    else
      puts('epa')
    end
  end
end
get({q: "hey", hey: 'opa'})
