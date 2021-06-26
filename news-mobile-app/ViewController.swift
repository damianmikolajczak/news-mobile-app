//
//  ViewController.swift
//  news-mobile-app
//
//  Created by Damian Mikołajczak on 26/06/2021.
//

import UIKit

class ViewController: UIViewController {

    let APIURL:String = "https://newsapi.org/v2/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "\(APIURL)everything?q=Apple")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request){data, response, error in
            guard let data = data else { return }
            
            do {
                let news = try JSONDecoder().decode(Result.self, from: data)
                print(news.articles[1])
            } catch {
                print(error)
                
            }
        }
        
        task.resume()
        
    }


}

