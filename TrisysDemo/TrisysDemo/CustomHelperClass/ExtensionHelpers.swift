//
//  ExtensionHelpers.swift
//  TrisysDemo
//
//  Created by Anil Gupta on 06/06/21.
//

import Foundation
import UIKit

public typealias UIButtonTargetClosure = (UIButton) -> ()

public extension UIView{
    func removeAllSubviews(){
        for subview  in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func removeAllSubviewsWithTag(_ tag : Int){
        for subview  in self.subviews {
            if subview.tag == tag{
                subview.removeFromSuperview()
            }
        }
    }
}

// MARK:- Adding Target Closure
public extension UIButton {
    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }
    
    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addTargetClosure(closure: @escaping UIButtonTargetClosure) {
        targetClosure = closure
        removeTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
        addTarget(self, action: #selector(UIButton.closureAction), for: .touchUpInside)
    }
    
    @objc func closureAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure(self)
    }
    
    func addMinimumFontScale() {
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.baselineAdjustment = .alignCenters
        self.titleLabel?.minimumScaleFactor = 10/(self.titleLabel?.font.pointSize)!
    }
}

public class ClosureWrapper: NSObject {
    let closure: UIButtonTargetClosure
    init(_ closure: @escaping UIButtonTargetClosure) {
        self.closure = closure
    }
}

public extension UITextField {
    
    func validate() -> Bool {
        guard let text = self.text,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }
    
}

public extension UITextView {

    func validate() -> Bool{
        guard let text = self.text,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
            return false
        }
        return true
    }

}


extension UIImageView {
    func setImage(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        self.image = placeholder
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        DispatchQueue.main.async {
            let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-100, width: 300, height:50))
            toastLabel.numberOfLines = 2
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.font = font
            toastLabel.textAlignment = .center;
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
                 toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
    }
    
    func getString(_ keyString : String) -> String {
        return NSLocalizedString(keyString, comment: "")
    }
    
    
    func addFetchingView() {
        
        let requestStateView = UIView.init()
        requestStateView.tag = 7001
        requestStateView.translatesAutoresizingMaskIntoConstraints = false
        self.view?.addSubview(requestStateView)
        requestStateView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:0).isActive = true
        requestStateView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:0).isActive = true
        requestStateView.topAnchor.constraint(equalTo:self.view.topAnchor, constant:0).isActive = true
        requestStateView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:0).isActive = true
        
        let requestStateImage = UIImageView.init()
        requestStateImage.image = UIImage(named:"fetchingImage")
        requestStateImage.translatesAutoresizingMaskIntoConstraints = false
        requestStateView.addSubview(requestStateImage)
        requestStateImage.centerXAnchor.constraint(equalTo:requestStateView.centerXAnchor, constant:0).isActive = true
        requestStateImage.topAnchor.constraint(equalTo:requestStateView.topAnchor, constant:200).isActive = true
        requestStateImage.widthAnchor.constraint(equalToConstant:120).isActive = true
        requestStateImage.heightAnchor.constraint(equalToConstant:120).isActive = true

        
        let requestStateTitle = UILabel.init()
        requestStateTitle.numberOfLines = 2
        requestStateTitle.textAlignment = .center
        requestStateTitle.attributedText = NSAttributedString(string:self.getString("requestState_fetching"), attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font:UIFont(name:fontString.avenirHeavy.rawValue, size: 16)!])
        requestStateTitle.translatesAutoresizingMaskIntoConstraints = false
        requestStateView.addSubview(requestStateTitle)
        requestStateTitle.topAnchor.constraint(equalTo:requestStateImage.bottomAnchor, constant:10).isActive = true
        requestStateTitle.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:20).isActive = true
        requestStateTitle.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant:-20).isActive = true
        
    }
    
    func removeFetchingView() {
        DispatchQueue.main.async {
            if self.view?.viewWithTag(7001) != nil{
                if let bgView = self.view?.viewWithTag(7001)  {
                    bgView.removeFromSuperview()
                }
            }
        }
    }
}
