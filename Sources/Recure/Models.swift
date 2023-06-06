public enum EventType: String {
    case login = "LOGIN"
    case signUp = "SIGN_UP"
    case page = "PAGE"
    case freeTrialStarted = "FREE_TRIAL_STARTED"
    case freeTrialEnded = "FREE_TRIAL_ENDED"
    case subscriptionStarted = "SUBSCRIPTION_STARTED"
    case subscriptionEnded = "SUBSCRIPTION_ENDED"
}

public enum DeviceType: String {
    case mobile
    case tablet
}

public struct UserOptions {
    public let userId: String
    public let userEmail: String
    public let userPhone: String?
    public let userName: String?

    public init(userId: String, userEmail: String, userPhone: String? = "", userName: String? = "") {
        self.userId = userId
        self.userEmail = userEmail
        self.userPhone = userPhone
        self.userName = userName
    }
}
