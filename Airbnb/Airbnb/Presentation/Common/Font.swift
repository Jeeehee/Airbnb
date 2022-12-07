import Foundation

enum NotoSans: String {
    case black
    case bold
    case medium
    case regular
    case thin
    
    var name: String {
        switch self {
        case .black:
            return "NotoSansKR-Black"
        case .bold:
            return "NotoSansKR-Bold"
        case .medium:
            return "NotoSansKR-Medium"
        case .regular:
            return "NotoSansKR-Regular"
        case .thin:
            return "NotoSansKR-Thin"
        }
    }
}

enum Roboto: String {
    case black
    case bold
    case medium
    case regular
    case light
    case thin
    
    var `type`: String {
        switch self {
        case .black:
            return "Roboto-Black"
        case .bold:
            return "Roboto-Bold"
        case .medium:
            return "Roboto-Medium"
        case .regular:
            return "Roboto-Regular"
        case .light:
            return "Roboto-Light"
        case .thin:
            return "Roboto-Thin"
        }
    }
}
