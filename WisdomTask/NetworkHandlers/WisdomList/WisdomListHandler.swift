//
//  WisdomListHandler.swift
//  WisdomTask
//
//  Created by KOSURU UDAY SAIKUMAR on 09/05/23.
//

import Foundation
import UIKit

class WisdomListHandler {
    func fetchWisdomeList(page:Int, perPage:Int,completion: @escaping (WisdomList?, APIError?) ->Void){
        let wisdomeListRouter = WisdomeApiRouter.list(page: "\(page)")
        NetworkHandler().makeAPICall(router: wisdomeListRouter, decodingType: WisdomList.self) { (result) in
            switch result {
            case .success(let model):
                completion(model as? WisdomList, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    func fetchImage(url:String, id:String, completion: @escaping (UIImage?, APIError?) ->Void){
        NetworkHandler().downlodDirect(urlString: url,id: id) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let image = UIImage(data: data){
                        completion(image, nil)
                    }
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
