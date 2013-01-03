require 'open-uri'
require 'pygments'

module Jekyll
  class RenderGist< Liquid::Tag

    def initialize(tag_name, params, tokens)
      super
      
      url, specified_language = params.split(' ')

      if %r|https://gist.github.com/raw/(.*)/.*/(.*\.([a-zA-Z]+))| =~ url
        @gist = $1
        @file = $2
        file_language = $3
      else
        $stderr.puts "Failed to parse gist URL '#{url}' from tag."
        $stderr.puts "URL should be in the form 'https://gist.github.com/raw/1234/123456789abcdef/example.txt'"
        exit(1);
      end
      
      @language = specified_language || file_language
      @code = get_gist_contents(url)      
    end

    def get_gist_contents(gist_url)
      begin
        open(gist_url).read
      rescue => error
        $stderr.puts "Unable to open gist URL: #{error}"
        exit(1);
      end
    end
    
    def render(context)
      if context.registers[:site].pygments
        render_pygments(context, @code, @language)
      end
    end

    def render_pygments(context, code, language)
      if Pygments::Lexer.find(@language)
        lexer = Pygments::Lexer.find(@language).name.downcase
      end

      options = {'encoding' => 'utf-8'}
      output = add_code_tags(Pygments.highlight(@code, :lexer => lexer, :options => options), @language)
      output = context["pygments_prefix"] + output if context["pygments_prefix"]
      output = output + context["pygments_suffix"] if context["pygments_suffix"]
    end

    def add_code_tags(code, language)
      # Add nested <code> tags to code blocks
      code = code.sub(/<pre>/,"<div class=\"gist\"><script src=\"https://gist.github.com/#{@gist}.js?file=#{@file}\"> </script><noscript><pre><code class=\"#{language}\">")
      code = code.sub(/<\/pre>/,"</code></pre><p><a href=\"https://gist.github.com/#{@gist}\">This Gist</a> hosted on <a href=\"http://github.com/\">GitHub</a>.</p></noscript></div>")
    end
    
  end
end

Liquid::Template.register_tag('render_gist', Jekyll::RenderGist)
