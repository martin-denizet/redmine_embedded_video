module ActionView
  module Helpers
    module AssetTagHelper
      def javascript_include_tag_with_video(*sources)
        out = javascript_include_tag_without_video(*sources)
        if sources.is_a?(Array) and sources[0] == 'jstoolbar/textile'
          out += javascript_tag <<-javascript_tag
jsToolBar.prototype.elements.video = {
	type: 'button',
        title: 'Flash video player',
	fn: {
		wiki: function() { this.encloseSelection("{{video(", ")}}") }
	}
}
          javascript_tag
          out += stylesheet_link_tag 'toolbar', :plugin => 'redmine_embedded_video'
        end
        out
      end
      alias_method_chain :javascript_include_tag, :video
    end
  end
end