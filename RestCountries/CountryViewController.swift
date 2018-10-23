//
//  ViewController.swift
//  RestCountries
//
//  Created by Hoang Son on 10/22/18.
//  Copyright © 2018 Hoang Son. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tbCountry: UITableView!
    var countries = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://restcountries.eu/rest/v2/all"
        Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (reponse ) in
            if ((reponse.result.value) != nil) {
                let jsonValue = JSON(reponse.value)
                if let json = jsonValue[].arrayObject {
                    self.countries = json as [AnyObject]
                    self.tbCountry.reloadData()
                   }
                }
            }
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryTableViewCell
        let km = countries[indexPath.row]
        cell.lbCountry.text = km["name"] as? String
        return cell

    }
}

