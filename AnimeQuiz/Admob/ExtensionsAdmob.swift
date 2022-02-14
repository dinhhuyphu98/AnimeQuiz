//
//  Extensions.swift
//  Idol
//

import UIKit
import Foundation
import Toast_Swift
import MBProgressHUD

extension NSObject {

    func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
    var className: String {
        
        return String(describing: type(of: self))
    }
    
    class var className: String {
        
        return String(describing: self)
    }

}

extension String {
    
    func nibWithNameiPad()->String{
        var str = self
        if IS_IPAD{
            str = str + "_iPad"
        }
        return str
    }
}
extension UIViewController {
    func isModal() -> Bool {
        if self.presentingViewController != nil {
            return true
        } else if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        } else if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
    
    func showLoading(){
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hideLoading(){
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    func showError(message: String){
        var str = message
        if message.count == 0{
            str = "Can't get information of this manga."
        }
        var style = ToastStyle()
        style.backgroundColor = UIColor.red.withAlphaComponent(1)
        currentView().view.makeToast(str, duration: 3.0, position: .top, style: style)
    }
    
    func showSuccess(message: String){
        var style = ToastStyle()
        style.backgroundColor = UIColor.green.withAlphaComponent(1)
        currentView().view.makeToast(message, duration: 3.0, position: .top, style: style)
    }
    
    func currentView() -> UIViewController{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return (UIApplication.shared.keyWindow?.rootViewController)!
    }
}

extension UITextField {
    func padding() {
        self.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    }
    func isEmpty() -> Bool {
        return (self.text?.isEmpty)!
    }
        
    func modifyTextField(placeholder: String, font: UIFont){
        var myMutableStringTitle = NSMutableAttributedString()
        myMutableStringTitle = NSMutableAttributedString(string:placeholder, attributes: [NSAttributedString.Key.font:font])
        myMutableStringTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range:NSRange(location:0,length:placeholder.count))
        self.attributedPlaceholder = myMutableStringTitle
        self.font = font
    }
}

extension UIButton {
    func centerVertically() {
        let kDefaultPadding: CGFloat = 6.0
        self.centerVertically(padding: kDefaultPadding)
    }
    
    func centerVertically(padding: CGFloat) {
        let imageSize = self.imageView!.frame.size
        let titleSize = self.titleLabel!.frame.size
        
        let totalHeight = imageSize.height + titleSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(top: -(totalHeight - imageSize.height),
                                            left: 0.0,
                                            bottom: 0.0, right: -titleSize.width);
        
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0,
                                            left: -imageSize.width,
                                            bottom: -(totalHeight - titleSize.height),
                                            right: 0.0);
    }
}

extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        
        guard let view = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as? T else {
            return T()
        }
        
        return view
    }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func layerGradient(colors: [CGColor]) {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint.init(x: 0, y: 0)
        layer.colors = colors
        self.layer.insertSublayer(layer, at: 0)
    }
    
    class func loadFromNibNamed(nibNamed: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    func round(color: UIColor, cornerRadius: CGFloat) -> Void {
        self.round(color: color, borderWidth: 1.0, radius: cornerRadius)
    }
    
    func round(color: UIColor) -> Void {
        self.round(color: color, borderWidth: 1.0, radius: self.frame.height / 2.0)
    }
    
    func round(color: UIColor,borderWidth:CGFloat) -> Void {
        self.round(color: color, borderWidth: borderWidth, radius: self.frame.height / 2.0)
    }
    
    func round(color: UIColor,borderWidth:CGFloat, radius: CGFloat) -> Void {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }
    func round() -> Void {
        self.round(color: UIColor.clear)
    }
    
    func addTapGesture(callBack: Selector) -> Void {
        let tap = UITapGestureRecognizer.init(target: self, action: callBack)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    func addTapGesture(callBack: Selector,parent:AnyObject?) -> Void {
        let tap = UITapGestureRecognizer.init(target: parent, action: callBack)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    func addTapGesture(callBack: Selector,parent:AnyObject?,delegate:UIGestureRecognizerDelegate) -> Void {
        let tap = UITapGestureRecognizer.init(target: parent, action: callBack)
        tap.delegate = delegate
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    func addTapGesture(callBack: Selector,viewController:UIViewController) -> Void {
        let tap = UITapGestureRecognizer.init(target: viewController, action: callBack)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}


extension UIImage {
    static func imageFromColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

extension UIFont {
    class func applicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Nunito-Regular", size: size)!
    }
    class func boldApplicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Nunito-Bold", size: size)!
    }
    class func lightApplicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Light", size: size)!
    }
    
    class func italicApplicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica-Italic", size: size)!
    }
}

extension UIFont {
    
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        
        // create a new font descriptor with the given traits
        if let fd = fontDescriptor.withSymbolicTraits(traits) {
            // return a new font with the created font descriptor
            return UIFont(descriptor: fd, size: pointSize)
        }
        
        // the given traits couldn't be applied, return self
        return self
    }
    
    func italics() -> UIFont {
        return withTraits(.traitItalic)
    }
    
    func bold() -> UIFont {
        return withTraits(.traitBold)
    }
    
    func boldItalics() -> UIFont {
        return withTraits([ .traitBold, .traitItalic ])
    }
}


