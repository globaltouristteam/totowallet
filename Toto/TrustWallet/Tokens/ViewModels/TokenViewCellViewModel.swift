// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import UIKit
import BigInt

struct TokenViewCellViewModel {

    private let shortFormatter = EtherNumberFormatter.short

    let token: TokenObject
    let ticker: CoinTicker?
    let config: Config?

    init(
        token: TokenObject,
        ticker: CoinTicker?,
        config: Config? = nil
    ) {
        self.token = token
        self.ticker = ticker
        self.config = config
    }

    var title: String {
        return token.title
    }

    var titleFont: UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    var titleTextColor: UIColor {
        return Colors.black
    }

    var amount: String {
        return shortFormatter.string(from: BigInt(token.value) ?? BigInt(), decimals: token.decimals)
    }

    var currencyAmount: String? {
        return TokensLayout.cell.totalFiatAmount(for: ticker, token: token)
    }

    var amountFont: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .medium)
    }

    var currencyAmountFont: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .regular)
    }

    var backgroundColor: UIColor {
        return .white
    }

    var amountTextColor: UIColor {
        return Colors.black
    }

    var currencyAmountTextColor: UIColor {
        return Colors.lightGray
    }

    var percentChange: String? {
        guard let _ = currencyAmount else {
            return .none
        }
        return TokensLayout.cell.percentChange(for: ticker)
    }

    var percentChangeColor: UIColor {
        return TokensLayout.cell.percentChangeColor(for: ticker)
    }

    var percentChangeFont: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .light)
    }

    var placeholderImage: UIImage? {
        return R.image.ethereum_logo_256()
    }

    var imageUrl: URL? {
        return URL(string: token.imagePath)
    }
    
    // MARK: Contract
    var contractTextColor: UIColor {
        return UIColor.darkGray
    }
    
    var contractFont: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .medium)
    }

    private var isAvailableForChange: Bool {
        guard let config = config else { return true }
        // One version had an option to disable ETH token. Adding functionality to enable it back.
        if token.contract == TokensDataStore.etherToken(for: config).contract && token.isDisabled == true {
            return false
        }
        return token.contract == TokensDataStore.etherToken(for: config).contract ? true : false
    }
    
    var contractText: String? {
        if !isAvailableForChange {
            return token.contract
        }
        return .none
    }
}
