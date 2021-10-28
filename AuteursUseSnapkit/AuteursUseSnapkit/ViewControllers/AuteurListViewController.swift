//
//  ViewController.swift
//  AuteursUseSnapkit
//
//  Created by todoc on 2021/10/28.
//

import UIKit
import SnapKit


class AuteurListViewController: UIViewController {
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = UIColor.init(named: "AuteursBackground")
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?
          .navigationBar
          .largeTitleTextAttributes =
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34, weight: .bold)]
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Auteurs"
        setDelegate()
        setupUI()
    }
    
    func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension AuteurListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
}
extension AuteurListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "test"
        cell.textLabel?.textColor = .systemGray4
        cell.backgroundColor = UIColor(named: "AuteursBackground")
        return cell
    }
    
    
}

#if DEBUG
import SwiftUI
struct LandscapeModifier: ViewModifier {
    let height = UIScreen.main.bounds.width // 1
    let width = UIScreen.main.bounds.height // 2
    
    func body(content: Content) -> some View {
        content
            .previewLayout(.fixed(width: width, height: height)) // 3
            .environment(\.horizontalSizeClass, .compact)
            .environment(\.verticalSizeClass, .compact)
    }
}


extension View {
    func landscape() -> some View {
        self.modifier(LandscapeModifier())
    }
}

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    @available(iOS 13, *)
    func makeUIViewController(context: Context) -> UIViewController {
        AuteurListViewController()
    }
}

struct ViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
            .previewDisplayName("CloneCoding - Auteurs")
    }
}
#endif
