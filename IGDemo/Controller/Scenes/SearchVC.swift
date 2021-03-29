//
//  SearchVC.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/8/21.
//

import UIKit

class SearchVC: UITableViewController {
    
    //MARK: - Properties
    
    private var users            = [User]()
    private var filteredUsers    = [User]()
    private let searchController = UISearchController()
    
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        configureTableView()
        fetchUsers()
    }
    
    //MARK: - API
    
    private func fetchUsers() {
        UserService.fetchUsers { [weak self] users in
            guard let self = self else { return }
            self.users     = users
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    //MARK: - Helpers
    
    private func configureSearchController() {
        searchController.searchResultsUpdater                 = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder                = "Search"
        navigationItem.searchController                       = searchController
        definesPresentationContext                            = false
    }
    
    
    private func configureTableView() {
        view.backgroundColor = .white
        tableView.rowHeight  = 82
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseID)
    }
    
    //MARK: - Selectors
    
}

//MARK: - UITableViewDatasource & Delegate

extension SearchVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredUsers.count : users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell       = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseID, for: indexPath) as! UserCell
        let user       = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user   = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        let destVC = ProfileVC(user: user)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
}

//MARK: - UISearchResultsUpdating

extension SearchVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        filteredUsers = users.filter({ $0.username.lowercased().contains(searchText) || $0.fullname.lowercased().contains(searchText) })
        tableView.reloadData()
    }
    
}
