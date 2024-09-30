//
//  ViewController+Ext.swift
//  testapp
//
//  Created by Avaz on 22/09/24.
//

import UIKit

// nothing can access to this variable unless this file
fileprivate var containerView: UIView!

extension UIViewController {
    
    // you can't create variables inside extensions
    
    func presentGFAlertOnMainThread(title: String?, message: String?, buttonTitle: String?) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let circularProgressIndicator = UIActivityIndicatorView(style: .large)
        
        containerView.addSubview(circularProgressIndicator)
        
        circularProgressIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circularProgressIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circularProgressIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        circularProgressIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
}
