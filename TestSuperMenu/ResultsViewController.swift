//
//  ResultsViewController.swift
//  TestSuperMenu
//
//  Created by Andriy Herasymyuk on 05.09.17.
//  Copyright © 2017 AndriyHerasymyuk. All rights reserved.
//

protocol ResultsViewControllerDelegate: class {
    
    func sender(_ sender: ResultsViewController, didSelectAddress address: Address)
    
}

final class ResultsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet fileprivate var tableView: UITableView!
    @IBOutlet fileprivate var navigationBar: UINavigationBar!
    
    weak var delegate: ResultsViewControllerDelegate?
    var coordinate: CLLocationCoordinate2D?
    
    var navigationBarIsHidden: Bool = true {
        didSet {
            guard navigationBar != nil else { return }
            updateNavigationBarVisiblity()
        }
    }
    
    fileprivate var addresses: [Address]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavigationBarVisiblity()
        
        if let coordinate = coordinate {
            loadAddresses(byСoordinate: coordinate)
        }
    }
    
    // MARK: - Actions

    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}

// MARK: - Private

private extension ResultsViewController {
    
    func updateNavigationBarVisiblity() {
        navigationBar.isHidden = navigationBarIsHidden
    }
    
    func loadAddresses(byСoordinate coordinate: CLLocationCoordinate2D) {
        tableView.showActivityIndicator()
        Address.addresses(by: coordinate) { [weak self] (addresses) in
            self?.tableView.hideActivityIndicator()
            self?.addresses = addresses
        }
    }
    
    @objc func loadAddresses(byQuery query: String) {
        tableView.showActivityIndicator()
        Address.addresses(by: query) { [weak self] (addresses) in
            self?.tableView.hideActivityIndicator()
            self?.addresses = addresses
        }
    }
    
}

// MARK: - UISearchResultsUpdating

extension ResultsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), !query.isEmpty else {
            addresses = nil
            return
        }
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        perform(#selector(loadAddresses(byQuery:)), with: query, afterDelay: 0.5)
    }
    
}

// MARK: - UITableViewDataSource

extension ResultsViewController: UITableViewDataSource {
    
    private enum CellIdentifier {
        static let basicCell = "BasicCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let address = addresses![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.basicCell, for: indexPath)
        cell.textLabel?.text = address.name
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension ResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = addresses![indexPath.row]
        delegate?.sender(self, didSelectAddress: address)
    }
    
}
