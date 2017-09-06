//
//  AddressAnnotation.swift
//  TestSuperMenu
//
//  Created by Andriy Herasymyuk on 05.09.17.
//  Copyright © 2017 AndriyHerasymyuk. All rights reserved.
//

class AddressAnnotation: NSObject, YMKAnnotation {
    
    typealias TextComponents = (title: String?, subtitle: String?)
    
    // MARK: - Properties
    
    private let theCoordinate: YMKMapCoordinate
    private let theTitle: String?
    private let theSubtitle: String?
    
    // MARK: - Initializers
    
    init(coordinate: YMKMapCoordinate, text: String?) {
        self.theCoordinate = coordinate
        
        var textComponents = TextComponents(nil, nil)
        if let text = text {
            textComponents = AddressAnnotation.getTextComponents(from: text)
        }
        self.theTitle = textComponents.title
        self.theSubtitle = textComponents.subtitle
    }
    
    convenience init?(_ address: Address) {
        guard let latitude = address.latitude, let longitude = address.longitude else {
            return nil
        }
        self.init(coordinate: YMKMapCoordinate(latitude: latitude, longitude: longitude), text: address.name)
    }
    
    // MARK: - YMKAnnotation
    
    func coordinate() -> YMKMapCoordinate {
        return theCoordinate
    }
    
    func title() -> String? {
        return theTitle
    }
    
    func subtitle() -> String? {
        return theSubtitle
    }
    
}

// MARK: - Private

private extension AddressAnnotation {
    
    static func getTextComponents(from text: String) -> TextComponents {
        let separator = ", "
        let components = text.components(separatedBy: separator)
       
        let limit = 3
        let title = components.prefix(limit).joined(separator: separator)
        
        var subtitle = ""
        if components.count > limit {
            subtitle = components.suffix(from: limit).joined(separator: separator)
        }

        let resultTitle: String? = title.isEmpty ? nil : title
        let resultSubtitle: String? = subtitle.isEmpty ? nil : subtitle
        return TextComponents(resultTitle, resultSubtitle)
    }
    
}
