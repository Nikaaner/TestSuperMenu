//
//  MapViewController.swift
//  TestSuperMenu
//
//  Created by Andriy Herasymyuk on 05.09.17.
//  Copyright © 2017 AndriyHerasymyuk. All rights reserved.
//

class MapViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet fileprivate var mapView: YMKMapView!
    
    var searchController: UISearchController!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }

}

// MARK: - Private

extension MapViewController {
    
    func initialSetUp() {
        let resultsViewController: ResultsViewController = UIStoryboard(.Main).instantiateViewController()
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController.searchResultsUpdater = resultsViewController
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
    
}
