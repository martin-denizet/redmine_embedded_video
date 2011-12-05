require 'redmine'
require 'dispatcher'

Redmine::Plugin.register :redmine_embedded_video do
  name 'Redmine Embedded Video'
  author 'Nikolay Kotlyarov'
  description 'This is a plugin for embedding flv video'
  version '0.0.1'
end

Redmine::WikiFormatting::Macros.register do
    desc "Wiki video embedding"
    macro :video do |o, args|
        @width = args[1] if args[1]
        @height = args[2] if args[2]
        @width ||= 400
        @height ||= 300

        @num ||= 0

        @num = @num + 1

        attachment = o.attachments.find_by_filename(args[0])

        if attachment
            video_file = url_for(:controller => 'attachments', :action => 'download', :id => attachment, :filename => attachment.filename)
            file_url = "#{Setting.protocol}://#{Setting.host_name.split('/').first}#{video_file}"
        else
            file_url = args[0].gsub(/<[^\>]+>/,'')
        end
<<END
<p id='video_#{@num}'>PLAYER</p>
<script type='text/javascript' src='#{Setting.protocol}://#{Setting.host_name}/plugin_assets/redmine_embedded_video/swfobject.js'></script>

<script type='text/javascript'>
var s1 = new SWFObject('#{Setting.protocol}://#{Setting.host_name}/plugin_assets/redmine_embedded_video/player.swf','player','#{@width}','#{@height}','9');

s1.addParam('allowfullscreen','true');
s1.addParam('allowscriptaccess','always');

s1.addParam('flashvars','file=#{file_url}');
s1.write('video_#{@num}');
</script>
END
  end

end
