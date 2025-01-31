import Foundation
import StoreKit

public struct NonConsumableDiscount {
    public let originalPrice: Decimal
    public let currentPrice: Decimal
    
    public init(originalPrice: Decimal, currentPrice: Decimal) {
        self.originalPrice = originalPrice
        self.currentPrice = currentPrice
    }
    
    public var formattedPercent: String {
        let percentageOff = 1 - (currentPrice / originalPrice)
        return percentageOff.formatted(.percent.rounded(rule: .down, increment: 1))
    }
    
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    public func formattedOriginalPrice(for nonCounsumable: Product) -> String {
        let currency = originalPrice.formatted(nonCounsumable.priceFormatStyle)
        return "\(currency)"
    }
}
