require 'railfrog'
require 'railfrog/transform/base_transformer'

module Railfrog
  module Transform


    # Maruku is a processor for Markdown content - see http://www.maruku.org/
    class MarukuTransformer < BaseTransformer
      
      def transform!(content, in_mime_type, out_mime_type, logger = nil)
        return nil if content.nil?
        new_content = nil
        new_out_mime_type = nil
        # Only Markdown to HTML transformation is supported
        return content unless in_mime_type == Mime::MARKDOWN.to_str
        begin
          require 'maruku'
          new_content = Maruku.new(content).to_html
          new_out_mime_type = Mime::HTML.to_str
        rescue StandardError => e
          logger.warn("Error in Maruku processing: #{e.message}. Is the 'maruku' gem installed?")
          new_content = content_for_error("Maruku processor for Markdown is not available", content)
	  end
        content.replace(new_content) unless new_content.nil?
        out_mime_type.replace(new_out_mime_type) unless new_out_mime_type.nil?
      end
    end

  end
end
