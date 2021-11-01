//
//  AuteurDetailViewController.swift
//  AuteursUseSnapkit
//
//  Created by todoc on 2021/10/29.
//

import UIKit
import SnapKit
class AuteurDetailViewController: UIViewController {
    var selectedAuteur: Auteur?
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 320
        tv.contentInsetAdjustmentBehavior = .never
        tv.backgroundColor = UIColor.init(named: "AuteursBackground")
        AuteurDetailTableViewCell.register(tableView: tv)
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedAuteur?.name
        addViews()
        setAutolayout()
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    func addViews() {
        view.addSubview(tableView)
    }
    
    func setAutolayout() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.bottom.trailing.leading.equalToSuperview()
        }
    }
}

extension AuteurDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedAuteur?.films.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AuteurDetailTableViewCell.dequeueReusableCell(tableView: tableView)
        if let film = selectedAuteur?.films[indexPath.row] {
            cell.configure(
                title: film.title,
                info: film.plot,
                image: film.poster,
                isExpended: film.isExtended)
        }
        return cell
    }
}

extension AuteurDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? AuteurDetailTableViewCell,
            var film = selectedAuteur?.films[indexPath.row]
        else {
            return
        }
        
        film.isExtended.toggle()
        selectedAuteur?.films[indexPath.row] = film
//        tableView.beginUpdates()
        cell.configure(title: film.title,
                       info: film.plot,
                       image: film.poster,
                       isExpended: film.isExtended)
//        tableView.endUpdates()
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
