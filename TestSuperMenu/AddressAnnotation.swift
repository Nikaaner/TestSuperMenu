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
    private let theTitle: String?
    
    // MARK: - Initializers
    
    init(coordinate: YMKMapCoordinate, title: String?, subtitle: String?) {
        self.theCoordinate = coordinate
        self.theTitle = title
    }
    
    convenience init?(_ address: Address) {
        guard let latitude = address.latitude, let longitude = address.longitude else {
            return nil
        }
        self.init(coordinate: YMKMapCoordinate(latitude: latitude, longitude: longitude), title: address.name, subtitle: address.name)
    }
    
    // MARK: - YMKAnnotation
    
    func coordinate() -> YMKMapCoordinate {
        return theCoordinate
    }
    
    func title() -> String? {
        return theTitle
    }
    
}
