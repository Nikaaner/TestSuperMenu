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
        mapView.zoomIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.showsUserLocation = true
        mapView.tracksUserLocation = true
    }
    
    // MARK: - Actions

    @IBAction func currentLocationAction(_ sender: UIButton) {
        goToLocation(at: mapView.userLocation.coordinate())
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
    
    func showAnnotation(_ annotation: YMKAnnotation, andSelect select: Bool = false) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        goToLocation(at: annotation.coordinate())
        
        if select {
            mapView.selectedAnnotation = annotation
        }
    }
    
    func showDumyAnntotation(at coordinate: CLLocationCoordinate2D) {
        var address = Address()
        address.latitude = coordinate.latitude
        address.longitude = coordinate.longitude
        guard let annotation = AddressAnnotation(address) else { return }
        showAnnotation(annotation)
    }
    
    func showTheNearestAddressAnnotation(at coordinate: CLLocationCoordinate2D) {
        Address.address(by: coordinate) { [weak self] (address) in
            guard let mapView = self?.mapView else { return }
            if let address = address, let annotation = AddressAnnotation(address) {
                self?.showAnnotation(annotation, andSelect: true)
            } else {
                mapView.removeAnnotations(mapView.annotations)
                self?.showAlert(with: NSLocalizedString("Failed to get response from the server.", comment: ""))
            }
        }
    }
    
    func goToLocation(at coordinate: YMKMapCoordinate) {
        guard coordinate.latitude != 0 && coordinate.longitude != 0 else { return }
        mapView.setCenter(coordinate, atZoomLevel: 16, animated: false)
    }
    
}

// MARK: - YMKMapViewDelegate

extension MapViewController: YMKMapViewDelegate {
    
    private enum Identifier {
        static let calloutIdentifier = "CalloutIdentifier"
    }
    
    func mapView(_ mapView: YMKMapView!, gotSingleTapAt coordinate: YMKMapCoordinate) {
        showDumyAnntotation(at: coordinate)
        showTheNearestAddressAnnotation(at: coordinate)
    }

    func mapView(_ view: YMKMapView!, calloutViewFor annotation: YMKAnnotation!) -> YMKCalloutView! {
        let reuseIdentifier = Identifier.calloutIdentifier
        if let calloutView = view.dequeueReusableCalloutView(withIdentifier: reuseIdentifier) {
            return calloutView
        }
        let calloutView = YMKDefaultCalloutView(reuseIdentifier: reuseIdentifier)
        calloutView?.annotation = annotation
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        rightButton.setImage(#imageLiteral(resourceName: "ic_list"), for: .normal)
        rightButton.tintColor = UIColor.flamingo
        calloutView?.rightView = rightButton
        return calloutView
    }
    
    func mapView(_ mapView: YMKMapView!, annotationViewCalloutTapped view: YMKAnnotationView!) {
        print("annotationViewCalloutTapped")
    }
    
    func mapView(_ mapView: YMKMapView!, annotationView view: YMKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        print("calloutAccessoryControlTapped")
    }
    
    func mapView(_ mapView: YMKMapView!, didUpdate userLocation: YMKUserLocation!) {
        goToLocation(at: userLocation.coordinate())
    }

}

// MARK: - ResultsViewControllerDelegate

extension MapViewController: ResultsViewControllerDelegate {
    
    func sender(_ sender: ResultsViewController, didSelectAddress address: Address) {
        searchController.isActive = false
        if let annotation = AddressAnnotation(address) {
            showAnnotation(annotation, andSelect: true)
        }
    }
    
}
