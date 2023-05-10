//
//  WisdomeListCell.swift
//  WisdomTask
//
//  Created by Raghava Dokala on 09/05/23.
//

import Foundation
import UIKit

class WisdomeListCell : UITableViewCell {
    
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var subtitle : UILabel!
    @IBOutlet weak var _imageView: UIImageView!
    
    var cellViewModel : WisdomeListCellRow! {
        didSet {
            accessoryType = .none
            title.text = cellViewModel.item?.author
            subtitle.text = cellViewModel.item?.url
            if let url = cellViewModel.item?.download_url {
                DispatchQueue.main.async {
                    self._imageView.loadThumbnail(urlSting: url)
                }
            }
        }
    }
}
