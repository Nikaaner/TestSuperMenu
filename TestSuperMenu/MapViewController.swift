//
//  MapViewController.swift
//  TestSuperMenu
//
//  Created by Andriy Herasymyuk on 05.09.17.
//  Copyright © 2017 AndriyHerasymyuk. All rights reserved.
//

final class MapViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet fileprivate var mapView: YMKMapView!
    
    fileprivate var searchController: UISearchController!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }

}

// MARK: - Private

private extension MapViewController {
    
    func initialSetUp() {
        let resultsViewController: ResultsViewController = UIStoryboard(.Main).instantiateViewController()
        resultsViewController.delegate = self
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController.searchResultsUpdater = resultsViewController
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
    
}

// MARK: - ResultsViewControllerDelegate

extension MapViewController: ResultsViewControllerDelegate {
    
    func sender(_ sender: ResultsViewController, didSelectAddress address: Address) {
        searchController.isActive = false
        print(address)
    }
    
}
