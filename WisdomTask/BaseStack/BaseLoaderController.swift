//
//  BaseLoaderController.swift
//  WisdomTask
//
//  Created by  Keerthana G on 18/01/23.
//

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        // View Configuration
        //view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blurEffectView.frame = self.view.bounds
        view.insertSubview(blurEffectView, at: 0)
        loadingActivityIndicator.center = CGPoint(x: view.bounds.midX,
                                                  y: view.bounds.midY)
        view.addSubview(loadingActivityIndicator)
    }
    
    var loadingActivityIndicator: UIActivityIndicatorView = {
        // UIActivityIndicatorView Configuration
        let indicator = UIActivityIndicatorView()
            indicator.style = .medium
            indicator.color = .systemGray
            indicator.startAnimating()
            indicator.autoresizingMask = [
                .flexibleLeftMargin, .flexibleRightMargin,
                .flexibleTopMargin, .flexibleBottomMargin
            ]
        return indicator
    }()
    
    var blurEffectView: UIVisualEffectView = {
        // UIVisualEffectView Configuration
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [
                .flexibleWidth, .flexibleHeight
            ]
        return blurEffectView
    }()
//    func removeSpinner() {
//            //DispatchQueue.main.async {
//                self.loadingActivityIndicator.stopAnimating()
//                self.blurEffectView.removeFromSuperview()
//                self.dismiss(animated: true)
//            //}
//        }
//    func removeSpinner() {
//            DispatchQueue.main.async {
//                self.loadingActivityIndicator.stopAnimating()
//                self.loadingActivityIndicator.isHidden = true
//                self.blurEffectView.removeFromSuperview()
//                self.blurEffectView.isHidden = true
//                self.dismiss(animated: true)
//            }
//        }
}
