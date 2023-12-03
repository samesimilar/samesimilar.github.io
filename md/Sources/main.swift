// Michael Spears 2023
// This is a pretty basic HTML formatter for Markdown
// see https://github.com/apple/swift-markdown
// to build and run on the command line: `swift run mdcli`
import Foundation
import Markdown

struct HTMLFormatter : MarkupVisitor {
    var childLevel = 0
    
    mutating func defaultVisit(_ markup: Markdown.Markup) -> String {
        var res = "\n********\(markup.debugDescription())*******\n"
        
        for child in markup.children {
            res += self.visit(child)
        }
        return res
    }
    
    mutating func visitOrderedList(_ orderedList: OrderedList) -> String {
        return "\(getTabs())<ol>\n\(visitChildren(orderedList))\(getTabs())</ol>\n"
    }
    mutating func visitUnorderedList(_ unorderedList: UnorderedList) -> String {
        return "\(getTabs())<ul>\n\(visitChildren(unorderedList))\(getTabs())</ul>\n"
    }
    mutating func visitListItem(_ listItem: ListItem) -> String {
        return "\(getTabs())<li>\(visitChildren(listItem))</li>\n"
    }
    mutating func visitEmphasis(_ emphasis: Emphasis) -> String {
        return "<em>\(visitChildren(emphasis))</em>"
    }
    
    mutating func visitStrong(_ strong: Strong) -> String {
        return "<strong>\(visitChildren(strong))</strong>"
    }
    mutating func visitDocument(_ document: Document) -> String {
        return """
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Running the Nord Modular Classic Editor on Raspberry Pi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
</head>

<body class="container" id="body">
\(visitChildren(document))
</body>
</html>
"""
        
    }
    mutating func visitText(_ text: Text) -> String {
        return text.string + visitChildren(text)
    }
    
    mutating func visitSoftBreak(_ softBreak: SoftBreak) -> String {
        return "\n\(getTabs())\(visitChildren(softBreak))"
    }
    
    mutating func visitCodeBlock(_ codeBlock: CodeBlock) -> String {
        return "\(getTabs())<pre>\(codeBlock.code)" + visitChildren(codeBlock) + "</pre>"
    }
    
    mutating func visitHeading(_ heading: Heading) -> String {
        return "\(getTabs())<h\(heading.level)>"+visitChildren(heading)+"</h\(heading.level)>\n"
    }
    
    mutating func visitInlineCode(_ inlineCode: InlineCode) -> String {
        return "<code>\(inlineCode.code)\(visitChildren(inlineCode))</code>"
    }
    
    mutating func visitLink(_ link: Link) -> String {
        return "<a href='\(link.destination ?? "")'>\(link.title ?? "")\(visitChildren(link))</a>"
    }
    
    mutating func visitImage(_ image: Image) -> String {
        return "<img class='img-fluid' src='\(image.source ?? "")' alt='\(image.plainText)' />"
    }
    mutating func visitParagraph(_ paragraph: Paragraph) -> String {
        if paragraph.parent is ListItem {
            return visitChildren(paragraph)
        } else {
            return "\(getTabs())<p>\(visitChildren(paragraph))</p>\n"
        }
        
    }
    mutating func visitChildren(_ markup: Markup) -> String {

        childLevel += 1
        let result = markup.children.map { child -> String in
          
            return visit(child)
        }.joined()
        childLevel -= 1
        return result
    }
    
    func getTabs() -> String{
        return (0..<childLevel).map {_ in "\t"}.joined()
    }
    
    typealias Result = String
    
    
}
let source = URL(fileURLWithPath: "/Volumes/Macintosh HD/Users/mikespears/rep/samesimilar.github.io/md/nordonpi.md")

let document = try! Document(parsing: source)
var formatter = HTMLFormatter()

print(formatter.visit(document))

//print(document.debugDescription())
