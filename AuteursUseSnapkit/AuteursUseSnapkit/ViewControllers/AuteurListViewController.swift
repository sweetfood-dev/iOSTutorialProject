//
//  ViewController.swift
//  AuteursUseSnapkit
//
//  Created by todoc on 2021/10/28.
//

import UIKit
import SnapKit


class AuteurListViewController: UIViewController {
    let auteurs = Auteur.auteursFromBundle()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.backgroundColor = UIColor.init(named: "AuteursBackground")
        AuteurTableViewCell.register(tableView: tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .opaqueSeparator
        tableView.separatorInsetReference = .fromAutomaticInsets
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?
            .navigationBar
            .largeTitleTextAttributes =
        [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34, weight: .bold)]
        navigationItem.largeTitleDisplayMode = .automatic
        title = "Auteurs"
        
        self.view.addSubview(tableView)
        
        setupUI()
        setDelegate()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func setupUI() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

extension AuteurListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return auteurs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "\(AuteurDetailViewController.self)") as! AuteurDetailViewController
        vc.selectedAuteur = auteurs[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension AuteurListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AuteurTableViewCell.dequeueReusableCell(tableView: tableView)
        
        let auteur = auteurs[indexPath.row]
        return cell.configure(name: auteur.name,
                               bio: auteur.bio,
                               source: auteur.source,
                               imageName: auteur.image)
    }
    
    
}
