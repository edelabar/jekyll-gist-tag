# Installation

Add jekyll-gist-tag.rb to the _plugins directory of your jekyll site

# Usage

{% render_gist gist_raw_url.type pygments_lexer }

## Example

{% render_gist https://gist.github.com/raw/885179/f030d8edd3e0cf45a9bfa6cea8979d7c006d7c4c/fixing-the-serps-when-changing-permalink-structure.htaccss.txt apache %}

If omitted, the file extension from the gist will be passed to pygments.