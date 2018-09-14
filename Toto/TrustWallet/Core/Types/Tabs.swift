// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import TrustCore

enum WalletAction {
    case none
    case addToken(Address)
}

enum Tabs {
    case browser(openURL: URL?)
    case transactions
    case wallet(WalletAction)
    case settings

    var index: Int {
        switch self {
        case .browser: return 0
        case .wallet: return 2
        case .transactions: return 3
        case .settings: return 4
        }
    }
}

extension Tabs: Equatable {
    static func == (lhs: Tabs, rhs: Tabs) -> Bool {
        switch (lhs, rhs) {
        case (let .browser(lhs), let .browser(rhs)):
            return lhs == rhs
        case (.transactions, .transactions),
             (.wallet, .wallet),
             (.settings, .settings):
            return true
        case (_, .browser),
             (_, .transactions),
             (_, .wallet),
             (_, .settings):
            return false
        }
    }
}
