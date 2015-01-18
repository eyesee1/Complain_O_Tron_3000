# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def markdown_cheat
    return <<cheater
<div id='markdownCheat'>
<h3>Use markdown syntax</h3>
Blank line between paragraphs.<br />
<kbd>*emphasized*</kbd> &#x2192; <em>emphasized</em><br />
<kbd>**strong**</kbd> &#x2192; <strong>strong</strong><br />
<h4>Lists</h4>
<pre>
* thing one
* thing two
* thing three, etc...
</pre>
<br />
<a href='http://daringfireball.net/projects/markdown/syntax'>more…</a>
</div>
cheater
  end
end
