import UIKit

struct Suggest: Hashable, Identifiable {
    typealias Identifier = Int

    let id: Identifier
    let image: UIImage
    let description: String
}
