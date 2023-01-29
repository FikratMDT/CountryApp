//
//  HomeVC.swift
//  CountryApp
//
//  Created by Fikrat on 12.12.22.
//

import UIKit
import Alamofire

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchStack: UIStackView!
    @IBOutlet weak var navStack: UIStackView!
    @IBOutlet weak var searchText: UITextField!
    
    var text = String()
    
    var countryModel = [CountryElement]()
    var searchedArray = [CountryElement]()
    var countryName = [Name]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "\(CountryCell.self)", bundle: nil), forCellReuseIdentifier: "\(CountryCell.self)")
        getCountryLists()


    }
    
    func getCountrySearch(text: String) {
         var request = URLRequest(url: URL(string: "https://restcountries.com/v3.1/name/\(text)")!)
        request.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let lists = try JSONDecoder().decode([CountryElement].self, from: data)
                    DispatchQueue.main.async {
                        self.countryModel = lists
                        self.tableView.reloadData()
                    }
                }catch{
                    print(error)
                }
            }else {
                print("invalid data")
            }
        }.resume()
    }
    
//    func getCountryLists(text: String, type: T.Type) {
//        guard let url = URL(string: "https://restcountries.com/v3.1/name/\(text)") else {}
//        AF.request(url, method: .get).responseData { response in
//            <#code#>
//        }
//    }
    
//    func getCountryList() {
//        var request = URLRequest(url: URL(string: "https://restcountries.com/v3.1/all")!)
//        request.httpMethod = "GET"
//        let session = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let data = data {
//                do {
//                    let lists = try JSONDecoder().decode([CountryListElement].self, from: data)
//                    let image = UIImage(data: data)
//                    DispatchQueue.main.async {
//                        self.countryModel = lists
//                        self.tableView.reloadData()
//                    }
//                }catch{
//                    print(error)
//                }
//            }else {
//                print("invalid data")
//            }
//        }.resume()
//    }

//    func getCountrySearch(text: String) {
//        guard let url = URL(string: "https://restcountries.com/v3.1/name/\(text)") else {return}
//                    AF.request(url, method:.get).responseData { response in
//                         do {
//                             let lists = try JSONDecoder().decode([CountryListElement].self, from: response.data ?? Data())
//                             self.countryModel = lists
//                             self.tableView?.reloadData()
//                         }catch{
//                             print(error.localizedDescription)
//                         }
//                         self.tableView?.reloadData()
//                     }
//        }
//    }
    
    func getCountryLists() {
                guard let url = URL(string:  "https://restcountries.com/v3.1/all") else { return }
        AF.request(url, method:.get).responseData { response in
                     do {
                         let lists = try JSONDecoder().decode([CountryElement].self, from: response.data ?? Data())
                         self.countryModel = lists
                         self.tableView?.reloadData()
                     }catch{
                         print(error.localizedDescription)
                     }
                     self.tableView?.reloadData()
                 }
    }

    
//    AF.request(url, method:.get).responseData { response in
//    //            do {
//    //                let lists = try JSONDecoder().decode([CountryListElement].self, from: response.data ?? Data())
//    //                self.countryModel = lists
//    //                self.myTable?.reloadData()
//    //            }catch{
//    //                print(error.localizedDescription)
//    //            }
//    //            self.myTable?.reloadData()
//    //        }
    
    @IBAction func searchAction(_ sender: Any) {
        UIView.animate(withDuration: 0.4){
        self.navStack.isHidden = true
        self.searchStack.isHidden = false
        }
    }
    
    @IBAction func settingsAction(_ sender: Any) {
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3){
        self.navStack.isHidden = false
        self.searchStack.isHidden = true
        }
    }    
    
    @IBAction func searchText(_ sender: UITextField) {
        getCountrySearch(text: sender.text ?? "")
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryModel.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "\(DetailVC.self)") as! DetailVC
        show(controller, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CountryCell.self)", for: indexPath) as! CountryCell
        cell.countryLabel.text = countryModel[indexPath.row].name?.common
        cell.countryImage.loadFrom(URLAddress: countryModel[indexPath.row].flags?.png ?? "")
        return cell
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

extension HomeVC: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.text = text
//        return true
//    }
    

}



