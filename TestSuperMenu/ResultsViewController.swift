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

final class ResultsViewController: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate: ResultsViewControllerDelegate?
    
    fileprivate var addresses: [Address]? {
        didSet {
            tableView.reloadData()
        }
    }

}

// MARK: - Private

private extension ResultsViewController {
    
    @objc func loadAddresses(by query: String) {
        Address.addresses(by: query) { [weak self] (addresses) in
            self?.addresses = addresses
            print(addresses)
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
        perform(#selector(loadAddresses(by:)), with: query, afterDelay: 0.5)
    }
    
}

// MARK: - UITableViewDataSource

extension ResultsViewController {
    
    private enum CellIdentifier {
        static let basicCell = "BasicCell"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let address = addresses![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.basicCell, for: indexPath)
        cell.textLabel?.text = address.name! + address.name!
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension ResultsViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = addresses![indexPath.row]
        delegate?.sender(self, didSelectAddress: address)
    }
    
}
