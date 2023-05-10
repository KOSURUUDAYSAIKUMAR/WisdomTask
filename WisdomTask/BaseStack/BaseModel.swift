//
//  BaseModel.swift
//  WorkerlyAgent(MVVM)
//
//  Created by  Keerthana G on 07/12/22.
//

import Foundation
import UIKit

protocol noInternetProtocal{
    func networkAvailable()
    func networkNotAvailable()
}
class BaseViewModel: RequestLoaderViewStatus {
    
    let viewStatus = Dynamic<ViewStatus>(value: .idel)
    let alertModel: Dynamic<AlertModel?> = Dynamic<AlertModel?>(value: nil)
    let alertPresentation = Dynamic<AlertPresentation?>(value: nil)
    var noInternetDelegate : noInternetProtocal?
    
    init() {
        bindAlertPresentation()
    }
    //MARK :- Refresh
    lazy var topRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemGray
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refreshControl.sizeToFit()
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        
        return refreshControl
    }()
    
//    @objc func doRefresh(){
        
  //  }
    @objc func pullToRefresh(_ refreshControl: UIRefreshControl) {
        didPullToRefresh()
    }
    func didPullToRefresh() {
        
    }
    func addPullToRefreshControl(to tableView: UITableView) {
            tableView.refreshControl?.endRefreshing()
            tableView.refreshControl = topRefreshControl
            tableView.addSubview(topRefreshControl)
    }
    //MARK :- Alert Handling
    
    func bindAlertPresentation() {
        alertPresentation.bind { [weak self] indexBasedAlertPresentation in
            guard let indexBasedAlertPresentation = indexBasedAlertPresentation else { return }
            self?.alertAction(with: indexBasedAlertPresentation)
        }
    }
    func alertAction(with alertPresentation: AlertPresentation) {
        print("alertPresentation\(alertPresentation)")
    }
}
