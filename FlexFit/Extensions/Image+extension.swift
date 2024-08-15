import UIKit

extension UIImage {
    static func from(data: Data?) -> UIImage? {
        guard let data = data else { return nil }
        return UIImage(data: data)
    }
}
