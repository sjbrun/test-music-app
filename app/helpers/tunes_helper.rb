module TunesHelper
  
  def embed_youtube(youtube_url)
    ## http://blog.41studio.com/embed-responsive-youtube-video-in-rails-4/
    youtube_id = youtube_url.split("/").last
    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}", allowfullscreen: "allowfullscreen")
  end
  
  def embed_spotify(spotify_url)
    spotify_id = spotify_url.split("%3A").last
    content_tag(:iframe, nil, src: "https://embed.spotify.com/?uri=spotify%3Atrack%3A#{spotify_id}")
  end

  def embed(url)
    case
    when url.include?('youtu.be')
      embed_youtube(url)
    when url.include?('open.spotify')
      embed_spotify(url)
    else
      link_to(url, url, target: "_blank")
    end
  end

end