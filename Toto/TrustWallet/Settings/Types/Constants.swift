// Copyright SIX DAY LLC. All rights reserved.

import Foundation

public struct Constants {
    public static let coinbaseWidgetCode = "88d6141a-ff60-536c-841c-8f830adaacfd"
    public static let shapeShiftPublicKey = "c4097b033e02163da6114fbbc1bf15155e759ddfd8352c88c55e7fef162e901a800e7eaecf836062a0c075b2b881054e0b9aa2324be7bc3694578493faf59af4"
    public static let changellyRefferalID = "968d4f0f0bf9"
    //
    public static let keychainKeyPrefix = "trustwallet"

    // social
    public static let website = "https://globaltourist.io/"
    public static let twitterUsername = "tourist_global"
    public static let telegramUsername = "globaltouristgroup"
    public static let facebookUsername = "globaltouristtoken"

    public static let appStoreDeepLink = "itms-apps://itunes.apple.com/app/id1412601957"
    public static let appStoreHttpLink = "https://itunes.apple.com/us/app/toto-wallet/id1412601957?ls=1&mt=8"

    // support
    public static let supportEmail = "support@globaltourist.io"
    public static let donationAddress = "0x7a60d33544Ac9848b6E366BBA66Cf4750696Af17"

    public static let dappsBrowserURL = "https://dapps.trustwalletapp.com/"
    public static let dappsOpenSea = "https://opensea.io"

    public static let images = "https://trustwalletapp.com/images"

    public static let trustAPI = URL(string: "https://public.trustwalletapp.com")!
}

public struct UnitConfiguration {
    public static let gasPriceUnit: EthereumUnit = .gwei
    public static let gasFeeUnit: EthereumUnit = .ether
}

public struct URLSchemes {
    public static let trust = "trust://"
    public static let browser = trust + "browser"
}
