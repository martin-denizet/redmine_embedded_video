require 'redmine'
require 'dispatcher'
require 'embedded_video_asset_tag_helper_patch'

Redmine::Plugin.register :redmine_embedded_video do
  name 'Redmine Embedded Video'
  author 'Martin Denizet'
  author_url 'https://github.com/martin-denizet'
  url 'https://github.com/martin-denizet/redmine_embedded_video'
  description 'This is a plugin orginaly written by Nikolay Kotlyarov for embedding flv video'
  version '0.1.0'
end

Redmine::WikiFormatting::Macros.register do
  desc "Wiki video embedding"
  macro :video do |o, args|
    @width = 400
    @height = 300

    @width = args[1] if args[1]
    @height = args[2] if args[2]


    @num ||= 0

    @num += 1

    attachment = o.attachments.find_by_filename(args[0])

    if attachment
      video_file = url_for(:controller => 'attachments', :action => 'download', :id => attachment, :filename => attachment.filename)
      file_url = video_file
    else
      file_url = args[0].gsub(/<[^\>]+>/,'')
    end

    #We only need the JavaScript once
    @swfobject_tag=(@num==1)?javascript_include_tag('swfobject.js', :plugin => :redmine_embedded_video):''

    <<END
<p id='video_#{@num}'>Your broswer cannot display the video, plase check that Adobe Flash Player is installed<br/><a href="http://get.adobe.com/flashplayer/">Get Flash</a></p>
#{@swfobject_tag}

<script type='text/javascript'>
var s1 = new SWFObject('#{image_path 'player.swf', :plugin => :redmine_embedded_video}','player','#{@width}','#{@height}','9');

s1.addParam('allowfullscreen','true');
s1.addParam('allowscriptaccess','always');

s1.addParam('flashvars','file=#{file_url}');
s1.write('video_#{@num}');
</script>
END
  end

  macro :videos do |o, args|

    return "VIDEO"+args[0]

  end

end
