import Foundation

public func exampleOf(description: String, action: () -> ()) {
    print("\n--- Example of:", description, "---")
    action()
}
