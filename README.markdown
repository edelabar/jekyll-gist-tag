jekyll-gist-tag renders the markup to embed a gist in your page in a manner that will work with or without
JavaScript enabled or available.  The resulting markup for the example below looks something like this:

	<div class="highlight">
		<div class="code">
			<script src="https://gist.github.com/885179.js?file=example.htaccess.txt"></script>
			<noscript>
				<pre><code class="apache">
					<span class="nb">redirect</span> <span class="m">301</span> /?cat=1 http://www.somesite.com/
					<span class="nb">redirect</span> <span class="m">301</span> /?cat=5 http://www.somesite.com/category/standards
				</code></pre>
				<p><a href="https://gist.github.com/885179">This Gist</a> hosted on <a href="http://github.com/">GitHub</a>.</p>
			</noscript>
		</div>
	</div>
	
# Requirements

This is a Jekyll plugin so it requires [Jekyll](https://github.com/mojombo/jekyll), as of now it also requires [Pygments](http://pygments.org/) as documented in the [Jekyll install](https://github.com/mojombo/jekyll/wiki/install).  I'm new to Ruby, so please excuse my code, it was unceremoniously hacked from the [Jekyll source](https://github.com/mojombo/jekyll/blob/master/lib/jekyll/tags/highlight.rb) but seems to be working for me.

# Installation

Add jekyll-gist-tag.rb to the _plugins directory of your Jekyll site

# Usage

{% render_gist *gist_raw_url_with_filename* *[pygments_lexer]* }

Where:

gist_raw_url_with_filename is the gist's raw URL (e.g. https://gist.github.com/raw/885179/f030d8edd3e0cf45a9bfa6cea8979d7c006d7c4c/example.htaccess.txt)

[pygments_lexer] is the optionally provided name of the pygments lexer for highlighting the code. If omitted, the file extension from the gist will be passed to pygments as the lexer.

The list of included lexers is available in the [Pygments documentation](http://pygments.org/docs/lexers).

## Example

{% render_gist https://gist.github.com/raw/885179/f030d8edd3e0cf45a9bfa6cea8979d7c006d7c4c/example.htaccess.txt apache %}