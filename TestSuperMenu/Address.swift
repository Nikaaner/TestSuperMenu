//
//  Address.swift
//  TestSuperMenu
//
//  Created by Andriy Herasymyuk on 05.09.17.
//  Copyright © 2017 AndriyHerasymyuk. All rights reserved.
//

import ObjectMapper
import Alamofire
import AlamofireObjectMapper

struct Address: Mappable {
    
    typealias AddressesCompletion = (_ addresses: [Address]) -> ()
    typealias AddressCompletion = (_ addresses: Address?) -> ()
    
    fileprivate enum Path {
        static let address = "https://api-dev.supermenu.kz/address"
        static let clientSearch = address + "/clientSearch"
        static let clientGeocode = address + "/clientGeocode"
    }
    
    // MARK: - Properties
    
    var identifier: Int?
    var latitude: Float?
    var longitude: Float?
    var name: String?
    
    // MARK: - Mappable
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        identifier <- map["id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        name <- map["name"]
    }
    
}

// MARK: - Public

extension Address {
    
    static func addresses(by query: String, completion: @escaping AddressesCompletion) {
        let url = URL(string: Path.clientSearch)!
        let parameters: Parameters = ["query": query]
        Alamofire.request(url, parameters: parameters).responseArray(keyPath: "data") { (response: DataResponse<[Address]>) in
            completion(response.value ?? [])
        }
    }
    
    static func addresses(by coordinate: CLLocationCoordinate2D, completion: @escaping AddressesCompletion) {
        let url = URL(string: Path.clientSearch)!
        let parameters: Parameters = ["latitude": coordinate.latitude, "longitude": coordinate.longitude]
        Alamofire.request(url, parameters: parameters).responseArray(keyPath: "data") { (response: DataResponse<[Address]>) in
            completion(response.value ?? [])
        }
    }
    
    static func address(by coordinate: CLLocationCoordinate2D, completion: @escaping AddressCompletion) {
        let url = URL(string: Path.clientGeocode)!
        let parameters: Parameters = ["latitude": coordinate.latitude, "longitude": coordinate.longitude]
        Alamofire.request(url, parameters: parameters).responseObject(keyPath: "data") { (response: DataResponse<Address>) in
            completion(response.value ?? nil)
        }
    }
    
}
