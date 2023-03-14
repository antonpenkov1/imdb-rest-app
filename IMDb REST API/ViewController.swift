//
//  ViewController.swift
//  IMDb REST API
//
//  Created by Антон Пеньков on 13.03.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let cellWithHeader = "cellWithHeader"
    var searchBar: UISearchBar = UISearchBar()
    var searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    var searchResponse: SearchResponse? = nil
    let networkDataFetcher = NetworkDataFetcher()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 100
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .white
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSearchBar()
        setupTableView()
        setupView()
        setupConstraintsForTableView()
    }

    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.hidesNavigationBarDuringPresentation = false
        searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barTintColor = .white
    }
    
    private func setupTableView() {
        tableView.register(CellWithHeader.self, forCellReuseIdentifier: "cellWithHeader")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }
    
    private func setupConstraintsForTableView() {
        tableView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(searchBar.snp.bottom)
            maker.bottom.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.top.equalToSuperview().offset(60)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.results.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellWithHeader) as? CellWithHeader
        let viewModel = searchResponse!.results[indexPath.row]
        cell?.configure(viewModel)
        return cell ?? UITableViewCell()
    }
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let urlString = "https://imdb-api.com/API/Search/k_dfthuvvp/\(searchText)"

        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchTitles(urlString: urlString) { (searchResponse) in
                guard let searchResponse = searchResponse else { return }
                self.searchResponse = searchResponse
                self.tableView.reloadData()
            }
        })
    }
}

