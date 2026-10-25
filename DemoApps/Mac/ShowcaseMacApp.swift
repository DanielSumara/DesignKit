import SwiftUI

@main
internal struct ShowcaseMacApp: App {
    var body: some Scene {
        Window("Showcase", id: "showcase") {
            ShowcaseRoot(catalog: Catalog(platformPages: []))
        }
    }
}
