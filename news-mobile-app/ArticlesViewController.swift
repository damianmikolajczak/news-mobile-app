//
//  ViewController.swift
//  news-mobile-app
//
//  Created by Damian Mikołajczak on 26/06/2021.
//

import UIKit

class ArticlesViewController: UIViewController {

    @IBOutlet weak var articlesTable: UITableView!
    let APIURL:String = "https://newsapi.org/v2/"
    let token: String = ""
    
    var articles = Array<News>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articlesTable.dataSource = self
        articlesTable.delegate = self
        //articlesTable.rowHeight = 460
        //articlesTable.estimatedRowHeight = 250
        downloadArticles()
    }
    
    func downloadArticles() {
        let url = URL(string: "\(APIURL)everything?q=Apple")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request){data, response, error in
            guard let data = data else { return }
            do {
                let news = try JSONDecoder().decode(Result.self, from: data)
                self.articles = news.articles
                DispatchQueue.main.async {
                    self.articlesTable.reloadData()
                }
            } catch { print(error) }
        }
        task.resume()
    }
}

extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        let article = articles[indexPath.row]
        let imageUrl = URL(string: article.urlToImage)
        var request = URLRequest(url: imageUrl!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, respond, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                cell.articleImage.image = UIImage(data: data)
                cell.source.text = article.source.name
                cell.title.text = article.title
                cell.subtitle.text = article.description
                cell.author.text = article.author
                let dateString = String(article.publishedAt.prefix(10))
                cell.publishDate.text = dateString
            }
        }
        task.resume()
        
        return cell
    }
}

extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nc = storyboard?.instantiateViewController(withIdentifier: "WebArticleNavigationController") as! ArticleWebNavigationController
        
        guard let vc = nc.viewControllers.first as? ArticleWebViewController else {
            print("Something went wrong")
            return
        }
        vc.articleURL = articles[indexPath.row].url
        print("So far so good")
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true, completion: nil)
    }
    
}
