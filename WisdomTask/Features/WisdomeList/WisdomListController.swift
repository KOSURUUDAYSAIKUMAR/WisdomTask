//
//  ViewController.swift
//  WisdomTask
//
//  Created by KOSURU UDAY SAIKUMAR on 09/05/23.
//

import UIKit
import SDWebImage

class WisdomListController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : WisdomListViewModel? {
        didSet {
            configureView(with: viewModel)
            bindViewModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = viewModel?.title
        viewModel?.fetch()
        bindTableViewRefreshContollers()
        setFieldValues()
    }
}

extension WisdomListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(for: section) ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel?.getSectionType(for: indexPath.section)
        switch type{
            case .wisdomeSection:
                let cell : WisdomeListCell? = tableView.dequeueReusableCell(withIdentifier: "WisdomeListCell", for: indexPath) as? WisdomeListCell
            if let cellViewModel = viewModel?.getCellViewModel(for: indexPath.section, row: indexPath.row) as? WisdomeListCellRow {
                cell?.cellViewModel = cellViewModel
                if let url = cellViewModel.item?.download_url {
                    SDWebImageManager.shared.loadImage(with: URL(string: url),options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                        DispatchQueue.main.async {
                            cell?._imageView.image = image
                        }
                    }
                }
            }
            return cell!
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing{
            viewModel?.didSelectEditRow(at: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel?.comitEditRow(at: indexPath)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
extension WisdomListController{
    fileprivate func addBarButtons() {
        rightBarButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(righBarButtonAction(_:)))
        self.navigationItem.rightBarButtonItem  = rightBarButton
    }
    fileprivate func setFieldValues() {
        addBarButtons()
        if (self.tableView.isEditing){
            self.tableView.setEditing(false, animated: true)
        }
    }
    @objc func righBarButtonAction(_ sender:UIBarButtonItem) {
        if sender.title == "Edit" {
            self.tableView.setEditing(true, animated: true)
            sender.title = "Done"
        }else{
            self.tableView.setEditing(false, animated: true)
            sender.title = "Edit"
        }
    }
}
extension WisdomListController {
    private func bindViewModel(){
        viewModel?.tableViewCellViewModel.bind({ [weak self] (sectionModel) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    private func bindTableViewRefreshContollers(){
        viewModel?.addPullToRefreshControl(to: self.tableView)
        viewModel?.addPaginateRefreshControl(to: self.tableView)
    }
}
