//
//  AppDelegate.swift
//  GoustoProducts
//
//  Created by Iovanna Mishanina on 07/11/2019.
//  Copyright © 2019 Iovanna Mishanina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let dataStore: PlistDataStore
    private let networkClient: NetworkClient
    private let controller: Controller
    private let router: Router
    var window: UIWindow?

    override init() {
        dataStore = PlistDataStore()
        controller = Controller(store: dataStore)
        dataStore.observer = controller
        networkClient = NetworkClient(dataStore: dataStore)
        router = Router(controller: controller)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window =  UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = router.navigationController
        window?.makeKeyAndVisible()
        networkClient.refresh()
        return true
    }

}

