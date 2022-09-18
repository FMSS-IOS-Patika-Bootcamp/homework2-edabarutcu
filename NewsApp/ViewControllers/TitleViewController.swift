//
//  TitleViewController.swift
//  NewsApp
//
//  Created by detaysoft on 16.09.2022.
//

import UIKit
import Moya
import Kingfisher

class TitleViewController: UIViewController {
    private var newsListViewModel : NewsListViewModel?
    @IBOutlet weak var headlineTableView: UITableView!
    var newsArray : [NewsDetail]? = []
    let provider = MoyaProvider<MyService>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        provider.request(.getHeader, completion: getNewsType(result:))
        headlineTableView.dataSource = self
        headlineTableView.delegate = self
        self.headlineTableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = UIFont(name: "Georgia-Bold", size: 30)
        label.text = "Headline"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    
    func getNewsType(result: Result<Response, MoyaError>){
        switch result {
        case .success(let response):
            decodeAndShow(response)
        case .failure(let error):
                   print(error.localizedDescription)
               }
        }
    
    fileprivate func decodeAndShow(_ response: (Response)) {
            do {
                let decodedData = try response.map(News.self)
                self.newsListViewModel = NewsListViewModel(newsList: decodedData)
                DispatchQueue.main.async {
                    if let newsListViewModel = self.newsListViewModel {
                        for counter in 0..<newsListViewModel.numberOfRowsInSection(){
                            self.newsArray?.append(NewsDetail(category: newsListViewModel.newsList.news[counter].category, title: newsListViewModel.newsList.news[counter].title, spot: newsListViewModel.newsList.news[counter].spot, imageUrl: newsListViewModel.newsList.news[counter].imageUrl, videoUrl: newsListViewModel.newsList.news[counter].videoUrl, webUrl: newsListViewModel.newsList.news[counter].webUrl))
                        }
                    }
                    self.headlineTableView.reloadData()
                }
                
            }
            catch {
                print(error)
            }
        }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension TitleViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsArray?.count ?? 0
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tabBarController?.delegate = self
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TitleTableViewCell {
       
            if let title = self.newsArray?[indexPath.row].title {
                cell.titleLabel.text = title
            }
            
            if let urlString = URL(string: String(self.newsArray?[indexPath.row].imageUrl ?? "")){
                DispatchQueue.main.async {
                    cell.titleImageView.kf.setImage(with: urlString)
                }
            }
       
            return cell
        }
          
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "toDetailsVC") as! DetailsViewController
        detailVC.selectedNew = self.newsArray?[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.5
        
        UIView.animate(withDuration: 0.1){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
}


//MARK:  UITabBarControllerDelegate

extension TitleViewController :  UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
     
        let indexPath = IndexPath(row: 0, section: 0)
        headlineTableView.scrollToRow(at: indexPath, at: .top, animated: true)
      
    }
}

    



