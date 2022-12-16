//
//  HomeVC.swift
//  CountryApp
//
//  Created by Fikrat on 12.12.22.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchStack: UIStackView!
    @IBOutlet weak var navStack: UIStackView!
    var countryModel = [CountryListElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "\(CountryCell.self)", bundle: nil), forCellReuseIdentifier: "\(CountryCell.self)")
        getCountryList()

    }
    
    
    func getCountryList() {
        var request = URLRequest(url: URL(string: "https://restcountries.com/v3.1/all")!)
        request.httpMethod = "GET"
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let lists = try JSONDecoder().decode([CountryListElement].self, from: data)
                    DispatchQueue.main.async {
                        self.countryModel = lists
                        self.tableView?.reloadData()
                    }
                }catch{
                    print(error)
                }
            }else {
                print("invalid data")
            }
        }.resume()
    }
    
    @IBAction func searchAction(_ sender: Any) {
        UIView.animate(withDuration: 0.1) {
            self.navStack.isHidden = true
            self.searchStack.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func settingsAction(_ sender: Any) {
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        UIView.animate(withDuration: 0.1) {
            self.navStack.isHidden = false
            self.searchStack.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryModel.count
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


