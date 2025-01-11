import StoreKit
import SwiftUI

/// A manager class that handles app review prompts based on user engagement points
@Observable public class ReviewManager {
    /// The current engagement points accumulated by the user
    private(set) var engagementPoints: Int
    
    /// The thresholds at which review prompts will be triggered
    private let thresholds: [Int]
    
    /// UserDefaults keys
    private enum Keys {
        static let highestThresholdReached = "highestThresholdReached"
        static let currentPoints = "currentPoints"
    }
    
    /// UserDefaults instance
    private let defaults: UserDefaults
    
    /// Initialize the ReviewManager with custom thresholds
    init(thresholds: [Int] = [10, 50, 100], defaults: UserDefaults = .standard) {
        self.thresholds = thresholds.sorted()
        self.defaults = defaults
        self.engagementPoints = defaults.integer(forKey: Keys.currentPoints)
    }
    
    /// Add engagement points and check if a review should be requested
    /// - Parameter points: The number of points to add
    /// - Returns: True if a review prompt should be shown
    @MainActor
    public func add(engagementPoints points: Int) -> Bool {
        engagementPoints += points
        defaults.set(engagementPoints, forKey: Keys.currentPoints)
        
        let highestThresholdReached = defaults.integer(forKey: Keys.highestThresholdReached)
        
        // Check if we should show a review prompt
        if let nextThreshold = thresholds.first(where: { $0 > highestThresholdReached }),
           engagementPoints >= nextThreshold {
            
            defaults.set(nextThreshold, forKey: Keys.highestThresholdReached)
            return true
        }
        
        return false
    }
    
    /// Reset the engagement points and review history
    public func reset() {
        engagementPoints = 0
        defaults.set(0, forKey: Keys.currentPoints)
        defaults.set(0, forKey: Keys.highestThresholdReached)
    }
}


extension EnvironmentValues {
    @Entry public var reviewManager = ReviewManager(thresholds: [1, 10, 30], defaults: .standard)
}
