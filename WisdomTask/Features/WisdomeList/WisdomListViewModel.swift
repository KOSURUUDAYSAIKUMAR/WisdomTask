//
//  WisdomListViewModel.swift
//  WisdomTask
//
//  Created by Raghava Dokala on 09/05/23.
//

import Foundation
import UIKit

class WisdomListViewModel : BaseViewModel{
    
    var title = "List"
    var tableViewHeight = UITableView.automaticDimension
    
    var wisdomResponder : WisdomResponder
    let tableViewCellViewModel = Dynamic<[WisdomeListCellViewModelBase]>(value: [])
    init(wisdomResponder: WisdomResponder){
        self.wisdomResponder = wisdomResponder
        super.init()
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
    //    func titleHeader(for section: Int) -> String {
    //        return tableViewCellViewModel.value[section].sectionTitle ?? ""
    //    }
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
    func getCurrentWorkingCellViewModel(for section:Int, row: Int) -> WisdomeListCellViewModel? {
        let sectionModel = tableViewCellViewModel.value[section] as? WisdomeListCellViewModel
        return sectionModel
    }
    
}

extension WisdomListViewModel {
    func fetchWisdomList(){
        viewStatus.value = .loading(loadStyle: .covering,title: "")
        WisdomListHandler().fetchTemps { model, error in
            if let err = error {
                print(":- \(err.localizedDescription)")
            }else{
                if let wisdome = model{
                    self.buildCellViewModels(items: wisdome) { }
                }
            }
            self.viewStatus.value = .loaded
        }
    }
    private func buildCellViewModels(items : [WisdomeModel?], completion: @escaping () -> Void) {
        var sectionTable = [WisdomeListCellViewModelBase]()
        var whoIsWorkingRow = [WisdomeListCellRow]()
        for item in items {
            item?.url = randomString()
            let row = WisdomeListCellRow(rowType: .currentWorkingTemps, item: item)
            whoIsWorkingRow.append(row)
        }
        let whoIsWorkingSection = WisdomeListCellViewModel(items: whoIsWorkingRow, sectionTitle: "", type: .whoIsWorking)
        sectionTable.append(whoIsWorkingSection)
        self.tableViewCellViewModel.value = sectionTable
        completion()
    }
}
