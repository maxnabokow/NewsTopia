import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        return UserDefaults.init(suiteName: "group.mnabokow.trustme")!
    }
}
