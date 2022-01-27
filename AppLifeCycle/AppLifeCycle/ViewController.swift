//
//  ViewController.swift
//  AppLifeCycle
//
//  Created by todoc on 2022/01/27.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var myView: MyView?
    
    init() {
        print("🟢 \(#function)")
        super.init(nibName: nil, bundle: nil)
        myView = MyView()
    }
    
    required init?(coder: NSCoder) {
        print("🟢 \(#function)")
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("🟢 \(#function)")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        print("🟢 \(#function) State: \(UIApplication.shared.applicationState.toString())")
        view = myView
    }
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        print("🟢 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🟢 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("🟢 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("🟢 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("🟢 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("🟢 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("🟢 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("🟢 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print("🟢 \(#function) State: \(UIApplication.shared.applicationState.toString())")
    }
    deinit {
        print("🟢 deinit")
    }
    


}

