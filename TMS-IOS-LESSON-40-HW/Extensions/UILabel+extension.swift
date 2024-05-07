import UIKit

extension UILabel {
    convenience init(label: String) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        self.text = label
    }
}
