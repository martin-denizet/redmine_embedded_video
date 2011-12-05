require 'redmine'
require 'dispatcher'

Redmine::WikiFormatting::Macros.register do
	desc "Wiki video embedding"
	macro :video do |o, args|
		@num ||= 0
		@num = @num + 1
		attachment = o.attachments.find_by_filename(args[0])
		if attachment
			video_file = url_for (:controller => 'attachments', :action => 'download', :id => attachment, :filename => attachment.filename)
			file_url = "#{Setting.protocol}://#{Setting.host_name.split('/').first}#{video_file}"
		else
			file_url = args[0].gsub(/<[^\>]+>/,'')
		end
<<END
<p id='video_#{@num}'>PLAYER</p>
<script type='text/javascript' src='#{Setting.protocol}://#{Setting.host_name}/plugin_assets/redmine_embedded_video/swfobject.js'></script>
<script type='text/javascript'>
var s1 = new SWFObject('#{Setting.protocol}://#{Setting.host_name}/plugin_assets/redmine_embedded_video/player.swf','player','400','300','9');
s1.addParam('allowfullscreen','true');
s1.addParam('allowscriptaccess','always');
s1.addParam('flashvars','file=#{file_url}');
s1.write('video_#{@num}');
</script>
END
  end
end