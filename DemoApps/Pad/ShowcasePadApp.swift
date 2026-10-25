import SwiftUI

@main
internal struct ShowcasePadApp: App {
    var body: some Scene {
        WindowGroup {
            ShowcaseRoot(catalog: Catalog())
        }
    }
}
