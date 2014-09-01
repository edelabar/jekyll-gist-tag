require 'open-uri'
require 'albino'

module Jekyll
  class RenderGist< Liquid::Tag

    def initialize(tag_name, params, tokens)
      super
      
      url, specified_language = params.split(' ')

      if %r|https://gist.githubusercontent.com/.*/(.*)/raw/(.*)/(.*\.([a-zA-Z]+))| =~ url
        @gist = $1
        @uuid = $2
        @file = $3
        file_language = $4
      elsif %r|https://gist.github.com/raw/(.*)/(.*)/(.*\.([a-zA-Z]+))| =~ url
        @gist = $1
        @uuid = $2
        @file = $3
        file_language = $4
      else
        $stderr.puts "Failed to parse gist URL '#{url}' from tag."
        $stderr.puts "URL should be in the form 'https://gist.githubusercontent.com/edelabar/885585/raw/97636729211894478563debbe776c4a69bb19fce/example.txt'"
        exit(1);
      end
      
      @language = specified_language || file_language
            
    end

    def get_gist_contents(gist,uuid,file,user)
      
      # https://gist.githubusercontent.com/edelabar/885585/raw/97636729211894478563debbe776c4a69bb19fce/in-beginning-there-was-doctype.fifth.html      
      gist_url = "https://gist.githubusercontent.com/#{user}/#{gist}/raw/#{uuid}/#{file}"
      
      begin
        open(gist_url).read
      rescue => error
        $stderr.puts "Unable to open gist URL: #{error}"
        exit(1);
      end
      
    end
    
    def lookup(context, name)
      lookup = context
      name.split(".").each { |value| lookup = lookup[value] }
      lookup
    end
    
    def render(context)
      
      user = lookup(context, 'site.github_username')
      @code = get_gist_contents(@gist,@uuid,@file,user)
      
      if context.registers[:site].highlighter == 'pygments'
        render_pygments(context, @code, @language)
      end
    end

    def render_pygments(context, code, language)
      output = add_code_tags(Albino.new(code, language).to_s, language)
      output = context["pygments_prefix"] + output if context["pygments_prefix"]
      output = output + context["pygments_suffix"] if context["pygments_suffix"]
      output
    end

    def add_code_tags(code, language)
      # Add nested <code> tags to code blocks
      code = code.sub(/<pre>/,"<div class=\"gist\"><script src=\"https://gist.github.com/#{@gist}.js?file=#{@file}\"> </script><noscript><pre><code class=\"#{language}\">")
      code = code.sub(/<\/pre>/,"</code></pre><p><a href=\"https://gist.github.com/#{@gist}\">This Gist</a> hosted on <a href=\"http://github.com/\">GitHub</a>.</p></noscript></div>")
    end
    
  end
end

Liquid::Template.register_tag('render_gist', Jekyll::RenderGist)
