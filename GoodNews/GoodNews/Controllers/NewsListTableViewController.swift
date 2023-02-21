//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by Kostiantyn Kaniuka on 21.02.2023.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setub()
    }
    
    private func setub() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-01-21&sortBy=publishedAt&apiKey=98897ff25fd64d239da35d42b10dd12f")!
        WebServise().getArticles(url: url) { articles in
            if let articles = articles {
                self.articleListVM = ArticleListViewModel(articles: articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSection
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as?  ArticleTableViewCell else { return UITableViewCell() }
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        cell.descriptionLabel.text = articleVM.title
        cell.titleLabel.text = articleVM.title
        return cell
    }
}

