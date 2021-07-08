import Foundation
import Publish
import Plot

struct ZmcguckinSwift: Website {
    enum SectionID: String, WebsiteSectionID {
        case blog
        case projects
        case extras
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    var url = URL(string: "https://zmcguckin.com")!
    var name = "Zach McGuckin"
    var description = "Software Engineer"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

extension PublishingStep where Site == ZmcguckinSwift {
    static func addDefaultSectionTitles() -> Self {
        .step(named: "Default section titles") { context in
            context.mutateAllSections { section in
                guard section.title.isEmpty else { return }

                switch section.id {
                case .blog:
                    section.title = "Blog"
                case .projects:
                    section.title = "Projects"
                case .extras:
                    section.title = "Extras"
                }
            }
        }
    }
}

try ZmcguckinSwift().publish(withTheme: .sexy)
