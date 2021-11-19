//
//  CitiesDataSource.swift
//  NavigationTutorial
//
//  Created by todoc on 2021/11/19.
//

import UIKit

class CitiesDataSource: NSObject, UITableViewDataSource {
    
    fileprivate var cities: [String] = []
    
    override init() {
        super.init()
        
        let citiesJSONURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Cities", ofType: "json")!)
        do {
            let citiesJSONData = try Data(contentsOf: citiesJSONURL)
            cities = try JSONDecoder().decode([String].self, from: citiesJSONData)
        }catch {
            DetailLog.Log(error.localizedDescription)
        }
    }
    
    @objc func city(index: Int) -> String { return cities[index] }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flavoe = cities[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default,
                                                                                            reuseIdentifier: "Cell")
        cell.textLabel?.text = flavoe
        return cell
    }
}
