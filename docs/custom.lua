-- Filter images with this function if the target format is HTML
if FORMAT:match 'html' then
    function Image(elem)
        -- Use CSS style to center image
        elem.attributes.style = 'display: block; margin-left: auto; margin-right: auto;'
        return elem
    end
end

-- From https://gist.github.com/Merovex/05e3216f8f4f6e965cd9d564b1496719
-- Converts "* * *" Horizontal Rule to a "#" separator in Word DOCX
local hashrule = [[<w:p>
<w:pPr>
  <w:pStyle w:val="HorizontalRule"/>
    <w:ind w:firstLine="0"/>
    <w:jc w:val="center"/>
</w:pPr>
<w:r>
  <w:t>#</w:t>
</w:r>
</w:p>]]

function HorizontalRule(elem)
    if FORMAT == 'docx' then
        return pandoc.RawBlock('openxml', hashrule)
    end
end

-- From https://newbedev.com/pandoc-markdown-page-break
-- Return a block element causing a page break in the given format.
local function newpage(format)
    if format == 'docx' then
        local pagebreak = '<w:p><w:r><w:br w:type="page"/></w:r></w:p>'
        return pandoc.RawBlock('openxml', pagebreak)
    elseif format:match 'html.*' then
        return pandoc.RawBlock('html', '<div style=""></div>')
    elseif format:match 'tex$' then
        return pandoc.RawBlock('tex', '\\newpage{}')
    elseif format:match 'epub' then
        local pagebreak = '<p style="page-break-after: always;"> </p>'
        return pandoc.RawBlock('html', pagebreak)
    else
        -- fall back to insert a form feed character
        return pandoc.Para {pandoc.Str '\f'}
    end
end

-- Filter function called on each RawBlock element.
function RawBlock(el)
    -- check that the block is TeX or LaTeX and contains only \newpage or
    -- \pagebreak.
    if el.text:match '\\newpage' then
        -- use format-specific pagebreak marker. FORMAT is set by pandoc to
        -- the targeted output format.
        return newpage(FORMAT)
    end
    -- otherwise, leave the block unchanged
    return nil
end
