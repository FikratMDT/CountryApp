//
//  HomeVC.swift
//  CountryApp
//
//  Created by Fikrat on 12.12.22.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.countryModel = lists
                        self.tableView.reloadData()
                    }
                    
                    self.tableView.reloadData()
                }catch{
                    print(error)
                }
            }else {
                print("invalid data")
            }
        }.resume()
    }
    
    @IBAction func searchAction(_ sender: Any) {
    }
    
    @IBAction func settingsAction(_ sender: Any) {
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CountryCell.self)", for: indexPath) as! CountryCell
        cell.countryLabel.text = countryModel[indexPath.row].name?.common
        let imageUrl =
        cell.countryImage.image = UIImage(named: countryModel[indexPath.row].flag ?? "")
        return cell
    }
}


