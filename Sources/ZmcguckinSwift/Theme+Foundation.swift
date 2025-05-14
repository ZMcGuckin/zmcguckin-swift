//
//  Theme+Foundation.swift
//  
//
//  Created by Zach McGuckin on 7/7/21
//
import Publish
import Plot
import Foundation

public extension Theme {
    static var sexy: Self {
        Theme(
            htmlFactory: SexyHTMLFactory(),
            resourcePaths: ["Resources/SexyTheme/styles.css"]
        )
    }
}

private struct SexyHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .setupAnalytics(),
                .homePage(for: context)
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .header(for: context, selectedSection: section.id),
                .wrapper(
                    .h1(.text(section.title)),
                    .itemList(for: section.items, on: context.site)
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .wrapper(
                    .article(
                        .div(
                            .class("content"),
                            .contentBody(item.body)
                        ),
                        .span("Tagged with: "),
                        .tagList(for: item, on: context.site)
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(.contentBody(page.body)),
                .footer(for: context.site)
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1("Browse all tags"),
                    .ul(
                        .class("all-tags"),
                        .forEach(page.tags.sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1(
                        "Tagged with ",
                        .span(.class("tag"), .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Browse all tags"),
                        .href(context.site.tagListPath)
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }

    static func header<T: Website>(for context: PublishingContext<T>, selectedSection: T.SectionID?) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
            .wrapper(
                .a(.class("site-name"), .href("/"), .text(context.site.name)),
                .if(sectionIDs.count > 1,
                    .nav(
                        .ul(.forEach(sectionIDs) { section in
                            .li(.a(
                                .class(section == selectedSection ? "selected" : ""),
                                .href(context.sections[section].path),
                                .text(context.sections[section].title)
                            ))
                        })
                    )
                )
            )
        )
    }
    
    static func homePage<T: Website>(for context: PublishingContext<T>) -> Node {
        let sectionIDs = T.SectionID.allCases
        let socials: [(name: String, link: String, image: String)] = [
            (name: "facebook", link: "http://facebook.com/zachmcguckin", image: "images/fb.png"),
            (name: "instagram", link: "http://instagram.com/zmcguckin", image: "images/ig.png"),
            (name: "twitter", link: "http://twitter.com/zmcguckin", image: "images/twitter.png"),
            (name: "spotify", link: "http://open.spotify.com/user/zmcguckin2", image: "images/spotify.png"),
            (name: "linkedIn", link: "http://linkedin.com/in/zmcguckin", image: "images/linkedin.png"),
            (name: "github", link: "http://github.com/zmcguckin", image: "images/github.png")
        ]
        return .div(
            .class("landing"),
            .h1(
                .class("gradient-text"),
                .text("Zach McGuckin")
            ),
            .p(
                .forEach(sectionIDs) { section in
                    .a(
                        .class("gradient-text"),
                        .href(context.sections[section].path),
                        .text(context.sections[section].title),
                        .onclick("return trackClick('\(context.sections[section].title)')")
                    )
                }
            ),
            .div(
                .class("social-icons"),
                .forEach(socials) { social in
                    .a(
                        .href(social.link),
                        .img(
                            .src(social.image)
                        ),
                        .onclick("return trackClick('\(social.name)')"),
                        .target(.blank)
                    )
                }
            )
        )
    }

    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                    )),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                ))
            }
        )
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }

    static func footer<T: Website>(for site: T) -> Node {
        .footer(
            .p(
                .text("Created by Zach McGuckin, \(Calendar.current.component(.year, from: Date()))")
            ),
            .p(
                .text("Written in Swift and Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish"),
                    .target(.blank)
                )
            )
        )
    }
    
    static func setupAnalytics() -> Node {
        .group(
            .script(.src("https://www.gstatic.com/firebasejs/8.2.9/firebase-app.js")),
            .script(.src("https://www.gstatic.com/firebasejs/8.2.9/firebase-analytics.js")),
            .script(.raw("var firebaseConfig = { apiKey: \"AIzaSyBl8STlkqZaDCztHrz1vU21VnyLln3p6vE\", authDomain: \"zmcguckin-website.firebaseapp.com\", databaseURL: \"https://zmcguckin-website.firebaseio.com\", projectId: \"zmcguckin-website\", storageBucket: \"zmcguckin-website.appspot.com\", messagingSenderId: \"822202433451\", appId: \"1:822202433451:web:ddbe6c5082a1a2a5a45cee\", measurementId: \"G-L8MVTLL7XE\" };")),
            .script(.raw("firebase.initializeApp(firebaseConfig);")),
            .script(.raw("firebase.analytics();")),
            .script(.raw("function trackClick(site) { firebase.analytics().logEvent(site +' clicked'); }"))
        )
    }
}

