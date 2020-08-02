//
//  VKService.swift
//  VK_app
//
//  Created by Алексей Муренцев on 31.07.2020.
//  Copyright © 2020 Алексей Муренцев. All rights reserved.
//

import Foundation
import Alamofire


class VKService {

    let session = Session.instance
    
    enum VKMethod {
        case friends
        case photos
        case groups
        case groupSearch
    }
    
    func getData(_ method: VKMethod, id: Int = 0, groupSearch: String = " ", completion: @escaping ([Any]) -> Void) {
        
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
            AF.request(urlPath, parameters: parameters).responseData { (response) in
                print(response.value ?? "No json")
                guard let data = response.value else { return }
                do {
                    let items = try JSONDecoder().decode(VKUsersResponse.self, from: data).response?.items
                    completion(items!)
                } catch {
                        print(error)
                    completion([])
                }
            }
        case .photos:
            vkm = "photos.getAll"
            parameters["owner_id"] = id
            AF.request(urlPath, parameters: parameters).responseData { (response) in
                print(response.value ?? "No json")
                guard let data = response.value else { return }
                do {
                    guard let items = try JSONDecoder().decode(VKPhotoResponse.self, from: data).response?.items
                        else { return }
                    completion(items)
                } catch {
                        print(error)
                    completion([])
                }
            }
        case .groups:
            vkm = "groups.get"
            parameters["extended"] = 1
            AF.request(urlPath, parameters: parameters).responseData { (response) in
                print(response.value ?? "No json")
                guard let data = response.value else { return }
                do {
                    let items = try JSONDecoder().decode(VKGroupsResponse.self, from: data).response?.items
                   
                    completion(items!)
                } catch {
                        print(error)
                    completion([])
                }
            }
        case .groupSearch:
            vkm = "groups.search"
            
            parameters["q"] = groupSearch //значение строки поиска
            AF.request(urlPath, parameters: parameters).responseData { (response) in
                print(response.value ?? "No json")
                guard let data = response.value else { return }
                do {
                    let items = try JSONDecoder().decode(VKGroupsResponse.self, from: data).response?.items
                    completion(items!)
                } catch {
                        print(error)
                    completion([])
                }
            }
        }
    }
}
