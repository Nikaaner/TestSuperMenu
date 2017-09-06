//
//  AddressAnnotation.swift
//  TestSuperMenu
//
//  Created by Andriy Herasymyuk on 05.09.17.
//  Copyright © 2017 AndriyHerasymyuk. All rights reserved.
//

class AddressAnnotation: NSObject, YMKAnnotation {
    
    // MARK: - Properties
    
    private let theCoordinate: YMKMapCoordinate
    private let theSubtitle: String?
    
    // MARK: - Initializers
    
    init(coordinate: YMKMapCoordinate, title: String?) {
        self.theCoordinate = coordinate
        self.theSubtitle = title
    }
    
    convenience init?(_ address: Address) {
        guard let latitude = address.latitude, let longitude = address.longitude else {
            return nil
        }
        self.init(coordinate: YMKMapCoordinate(latitude: latitude, longitude: longitude), title: address.name)
    }
    
    // MARK: - YMKAnnotation
    
    func coordinate() -> YMKMapCoordinate {
        return theCoordinate
    }
    
    func subtitle() -> String? {
        return theSubtitle
    }
    
}
