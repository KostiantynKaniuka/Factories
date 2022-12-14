//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Kostiantyn Kaniuka on 02.11.2022.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    //Request Models
    var profile: Profile?
    var account: [Account] = []
    
    //View Models
    var headerViewModel =
    AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())

    var accountsCellViewModells: [AccountSummaryCell.ViewModel] = []
    var tableView = UITableView()
    let headerView = AccountSummaryHeaderView(frame: .zero)
    
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
}

extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        setupTableHeaderView()
    //    fetchAccounts()
        fetchDataAndLoadViews()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
}

extension AccountSummaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountsCellViewModells.isEmpty else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let accountsCellViewModells = accountsCellViewModells[indexPath.row]
        cell.configure(with: accountsCellViewModells)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountsCellViewModells.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}



// MARK: Actions
extension AccountSummaryViewController {
    
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}

// MARK: - Networking
extension AccountSummaryViewController {
    
    private func fetchDataAndLoadViews() {
        fetchProfile(forUserId: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        fetchAccounts(forUserId: "1") { result in
            switch result {
            case .success(let accounts):
                self.account = accounts
                self.configureTableCells(with: accounts)
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureTableHeaderView(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
                                                    name: profile.firstName,
                                                    date: Date())
        headerView.configure(viewModel: vm)
    }
    
    private func configureTableCells(with accounts: [Account]) {
        accountsCellViewModells = accounts.map{AccountSummaryCell.ViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)}
    }
}
