//
//  SearchVC.swift
//  IGDemo
//
//  Created by Alexander Ha on 3/8/21.
//

import UIKit

class SearchVC: UITableViewController {
    
    //MARK: - UIComponents
    
    //MARK: - Properties
    
    private var users = [User]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    private func configureTableView() {
        view.backgroundColor = .white
        tableView.rowHeight  = 82
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.reuseID)
    }
    
    //MARK: - Selectors
    
}

//MARK: - UITableViewDelegate & Datasource

extension SearchVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reuseID, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
    
}
