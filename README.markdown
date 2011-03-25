jekyll-gist-tag renders the markup to embed a gist in your page in a manner that will work with or without
JavaScript enabled or available.  The resulting markup for the example below looks something like this:

	<div class="highlight"><div class="code"><script src="https://gist.github.com/885179.js?file=example.htaccess.txt"></script><noscript><pre><code class="apache">
	<span class="nb">redirect</span> <span class="m">301</span> /?cat=1 http://www.somesite.com/
	<span class="nb">redirect</span> <span class="m">301</span> /?cat=5 http://www.somesite.com/category/standards
	</code></pre><p><a href="https://gist.github.com/885179">This Gist</a> hosted on <a href="http://github.com/">GitHub</a>.</p></noscript></div>
	</div>

# Installation

Add jekyll-gist-tag.rb to the _plugins directory of your jekyll site

# Usage

{% render_gist gist_raw_url.type pygments_lexer }

## Example

{% render_gist https://gist.github.com/raw/885179/f030d8edd3e0cf45a9bfa6cea8979d7c006d7c4c/example.htaccess.txt apache %}

If omitted, the file extension from the gist will be passed to pygments.