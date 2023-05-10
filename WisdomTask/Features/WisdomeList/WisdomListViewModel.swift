//
//  WisdomListViewModel.swift
//  WisdomTask
//
//  Created by KOSURU UDAY SAIKUMAR on 09/05/23.
//

import Foundation
import UIKit

class WisdomListViewModel : BaseViewModel{
    
    var title = "Wisdome List"
    var tableViewHeight = UITableView.automaticDimension
    
    var wisdomResponder : WisdomResponder
    let tableViewCellViewModel = Dynamic<[WisdomeListCellViewModelBase]>(value: [])
    var allItems = [WisdomeModel?]()
    var editStack: Set<WisdomeModel?> = Set()
    var paginationValues = (1, 20)
    
    init(wisdomResponder: WisdomResponder){
        self.wisdomResponder = wisdomResponder
        super.init()
    }
    override func didPullToRefresh() {
        pull()
    }
    override func didPaginate() {
        paginate()
    }
}

extension WisdomListViewModel {
    func numberOfSections() -> Int {
        self.tableViewCellViewModel.value.count
    }
    func numberOfRows(for section: Int) -> Int {
        return tableViewCellViewModel.value[section].rowCount
    }
    func rowHeight(for indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func titleHeader(for section: Int) -> String {
        return tableViewCellViewModel.value[section].sectionTitle ?? ""
    }
    func getSectionType(for section:Int) -> WisdomeTableSectionType{
        return tableViewCellViewModel.value[section].type
    }
    func getRowType(for section:Int, row:Int) -> WisdomeTableRowType {
        let rowType = (tableViewCellViewModel.value[section].items?[row].rowType)!
        return rowType
    }
    func getCellViewModel(for section:Int, row: Int) -> WisdomeListCellRow {
        let sectionModel = tableViewCellViewModel.value[section]
        let rowViewModel = sectionModel.items?[row]
        return rowViewModel!
    }
    func getModel(for section:Int, row: Int) -> WisdomeModel {
        let sectionModel = tableViewCellViewModel.value[section]
        let rowViewModel = sectionModel.items?[row].item
        return rowViewModel!
    }
    func getCurrentWorkingCellViewModel(for section:Int, row: Int) -> WisdomeListCellViewModel? {
        let sectionModel = tableViewCellViewModel.value[section] as? WisdomeListCellViewModel
        return sectionModel
    }
    
    func didSelectEditRow(at indexPath:IndexPath){
        let type = self.getSectionType(for: indexPath.section)
        switch type {
        case .wisdomeSection:
            editStack.insert(getModel(for: indexPath.section, row: indexPath.row))
            //deleteButtonTitle.value = DEFAULT.DELETE
        }
    }
    func didDeselectEditRow(at indexPath:IndexPath){
        let type = self.getSectionType(for: indexPath.section)
        switch type {
        case .wisdomeSection:
            editStack.remove(getModel(for: indexPath.section, row: indexPath.row))
        }
    }
    func comitEditRow(at indexPath:IndexPath){
        let type = self.getSectionType(for: indexPath.section)
        switch type {
        case .wisdomeSection:
            editStack.insert(getModel(for: indexPath.section, row: indexPath.row))
        }
    }
    
}

extension WisdomListViewModel {
    func fetch(){
        self.paginationValues = (1,20)
        viewStatus.value = .loading(loadStyle: .covering,title: "")
        fetchWisdomList(completion: {_ in
            self.viewStatus.value = .loaded
        })
    }
    func pull(){
        tableViewCellViewModel.value.removeAll()
        allItems.removeAll()
        editStack.removeAll()
        fetchWisdomList(completion: {_ in
            DispatchQueue.main.async {
                self.topRefreshControl.endRefreshing()
            }
        })
    }
    func paginate(){
        self.paginationValues = (self.paginationValues.0 + 1, self.paginationValues.1)
        fetchWisdomList(completion: {_ in
            DispatchQueue.main.async {
                self.bottomRefreshControl.endRefreshing()
            }
        })
    }
    func fetchWisdomList(completion: @escaping BoolCompletion) -> Void{
        WisdomListHandler().fetchWisdomeList(page: self.paginationValues.0, perPage: self.paginationValues.1) { model, error in
            if let err = error {
                print(":- \(err.localizedDescription)")
                completion(false)
            }else{
                if let wisdome = model{
                    self.buildCellViewModels(items: wisdome) {
                        completion(true)
                    }
                }
            }
        }
    }
    private func buildCellViewModels(items : [WisdomeModel?], completion: @escaping () -> Void) {
        var sectionTable = [WisdomeListCellViewModelBase]()
        var whoIsWorkingRow = [WisdomeListCellRow]()
        for item in items {
            allItems.append(item)
        }
        for item in allItems {
//            item?.url = randomString()
            let row = WisdomeListCellRow(rowType: .generalRow, item: item)
            whoIsWorkingRow.append(row)
        }
        let whoIsWorkingSection = WisdomeListCellViewModel(items: whoIsWorkingRow, sectionTitle: "", type: .wisdomeSection)
        sectionTable.append(whoIsWorkingSection)
        self.tableViewCellViewModel.value = sectionTable
        completion()
    }
}
