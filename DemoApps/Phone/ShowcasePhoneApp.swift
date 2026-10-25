import SwiftUI

@main
internal struct ShowcasePhoneApp: App {
    var body: some Scene {
        WindowGroup {
            ShowcaseRoot(catalog: Catalog(platformPages: []))
        }
    }
}
