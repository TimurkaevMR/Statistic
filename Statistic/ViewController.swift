//
//  ViewController.swift
//  Statistic
//
//  Created by Malik Timurkaev on 24.05.2025.
//

import UIKit

class ViewController: UIViewController {
    let service = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                let arr: UserList = try await service.fetchData(.users)
                dump(arr)
            } catch let error as ServiceError {
                print(error)
            } catch let error as NSError {
                print(error)
            }
        }
    }
}
