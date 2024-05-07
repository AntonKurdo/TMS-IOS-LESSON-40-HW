import UIKit

extension UIButton {
    convenience init(title: String, backgroundColor: UIColor = .systemBlue) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
}



