import UIKit

extension UITextField {
    convenience init(placeholder: String) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.5
        self.placeholder = placeholder
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        leftView = UIView(frame: CGRectMake(0, 0, 12, 0))
        leftViewMode = .always
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.5
        animation.values = [-10.0, 10.0, -10.0, 10.0, -5.0, 5.0, -2.0, 2.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
