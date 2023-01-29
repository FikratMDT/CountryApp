//
//  DetailVC.swift
//  CountryApp
//
//  Created by Fikrat on 24.01.23.
//

import UIKit
import Alamofire

class DetailVC: UIViewController {
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var timezoneLabel: UILabel!
    @IBOutlet weak var populatLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    var countryModel : CountryElement?
    var countryList = [CountryElement]()
    
    init (){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure(data: countryModel  ?? CountryElement())
        getCountryLists()
    }
    
    func configure (data: CountryElement) {
        countryName.text = data.name?.official
    }
    
    func getCountryLists() {
                guard let url = URL(string:  "https://restcountries.com/v3.1/all") else { return }
        AF.request(url, method:.get).responseData { response in
                     do {
                         let lists = try JSONDecoder().decode([CountryElement].self, from: response.data ?? Data())
                         self.countryList = lists
                     }catch{
                         print(error.localizedDescription)
                     }
                 }
    }
}
