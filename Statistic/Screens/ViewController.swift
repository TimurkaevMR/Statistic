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
                let arr: Statistics = try await service.fetchData(.statistics)
                
                dump(arr.statistics.first!)
            } catch let error as ServiceError {
                print(error)
            } catch let error as NSError {
                print(error)
            }
        }
    }
}
