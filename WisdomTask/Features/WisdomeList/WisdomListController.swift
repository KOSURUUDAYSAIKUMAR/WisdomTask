//
//  ViewController.swift
//  WisdomTask
//
//  Created by Raghava Dokala on 09/05/23.
//

import UIKit

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
        viewModel?.fetchWisdomList()
//        tableView.delegate = self
//        tableView.dataSource = self

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
            case .whoIsWorking:
                let cell : WisdomeListCell? = tableView.dequeueReusableCell(withIdentifier: "WisdomeListCell", for: indexPath) as? WisdomeListCell
            if let cellViewModel = viewModel?.getCellViewModel(for: indexPath.section, row: indexPath.row) as? WisdomeListCellRow {
                cell?.cellViewModel = cellViewModel
            }
            return cell!
        default:
            return UITableViewCell()
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
}
