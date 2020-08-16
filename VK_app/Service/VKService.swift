//
//  VKService.swift
//  VK_app
//
//  Created by Алексей Муренцев on 31.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class VKService {

    let session = Session.instance
    
    enum VKMethod {
        case friends
        case photos
        case groups
        case groupSearch
    }
    
    func getData<T: Decodable>(_ method: VKMethod, id: Int = 0, groupSearch: String = " ", completion: @escaping ([T]) -> Void) {
        
        var vkm = ""
        var urlPath: String {
            "https://api.vk.com/method/" + vkm
        }
        var parameters: Parameters = [
            "access_token": session.token,
            "v": "5.122"
        ]
        
        switch method {
        case .friends:
            vkm = "friends.get"
            parameters["fields"] = "city, online, photo_200_orig"
        case .photos:
            vkm = "photos.getAll"
            parameters["owner_id"] = id
        case .groups:
            vkm = "groups.get"
            parameters["extended"] = 1
        case .groupSearch:
            vkm = "groups.search"
            parameters["q"] = groupSearch //значение строки поиска
        }
        
        AF.request(urlPath, parameters: parameters).responseData { [weak self] (response) in
            print(response.value ?? "No json")
            guard let data = response.value else { return }
            do {
                let items = try JSONDecoder().decode(VKResponse<T>.self, from: data).response.items
                if method != .groupSearch {
                    if method == .photos {
                        items
                            .map{ $0 as? VKPhoto }
                            .forEach { $0?.userId = id    
                        }
                    }
                    if let items = items as? [Object] {
                       self?.saveData(items)
                    }
                    
                }
                completion(items)
            } catch {
                    print(error)
                completion([])
            }
        }
    }

    func saveData<T: Object>(_ items: [T]) {
       do {
            let realm = try Realm()
            try realm.write {
                realm.add(items, update: .modified)
            }
        } catch {
            print(error)
        }
    }
}
