import UIKit

extension CALayer {

    @IBInspectable var LayerBorderUIColor: UIColor? {
        set(color) {
            self.borderColor = color?.cgColor
        }
        get {
            return UIColor(cgColor: borderColor!)
        }
    }
//    func setBorderUIColor(_ color: UIColor) {
//        self.borderColor = color.cgColor
//    }
}

extension UIView {
    @IBInspectable var UIViewBorderUIColor: UIColor? {
        set(color) {
            self.layer.borderColor = color?.cgColor
        }
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
    }
}
