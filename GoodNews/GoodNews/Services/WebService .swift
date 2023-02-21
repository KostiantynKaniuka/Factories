//
//  WebService .swift
//  GoodNews
//
//  Created by Kostiantyn Kaniuka on 21.02.2023.
//

import Foundation

class WebServise {
    
    func getArticles(url: URL, completion: @escaping ([Article]?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                
                if let articleList = articleList {
                    completion(articleList.articles)
                }
            }
        }.resume()
    }
}
