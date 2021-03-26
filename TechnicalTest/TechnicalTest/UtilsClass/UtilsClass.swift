//
//  UtilsClass.swift
//  TechnicalTest


import Foundation
import UIKit

class UtilsClass {
    
    //MARK: - Shared Instance
    static let sharedInstance : UtilsClass = {
        let instance = UtilsClass()
        return instance
    }()
    
    //MARK: - Get/Set UserDefaults
    func setMyUserDefaults(value:Any, key:String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    func getMyUserDefaults(key:String)->Any{
        return UserDefaults.standard.value(forKey: key) ?? []
    }
}

//WerServices
struct WebURL {
    
    static var getDevies = "http://storage42.com/modulotest/devices.json"
}

struct MyUserDefaultsKey {
    
    static var saveFilter = "saveFilter"
}


//UITableView Extension
extension UITableView {
    
    func register<T>(_ cellClass: T.Type) where T: UITableViewCell {
        register(T.self, forCellReuseIdentifier: NSStringFromClass(T.self))
    }
    
    func dequeueReusableCell<T>(_ cellClass: T.Type, indexPath: IndexPath)  -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: NSStringFromClass(T.self), for: indexPath) as! T
    }
    
    func registerFooter<T>(_ cellClass: T.Type) where T: UITableViewHeaderFooterView {
        register(T.self, forHeaderFooterViewReuseIdentifier: NSStringFromClass(T.self))
    }
}

extension UIViewController {
    
    func showMessageAlert(title: String, message: String, cancelButton: Bool = false, completion: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cancelButton {
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .destructive, handler: { action in completion() }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        } else  {
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { action in completion() }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessageWithCancelButtonAlert(title: String, message: String, cancelButton: Bool = false, completion: @escaping (Int) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .cancel, handler: { action in completion(0) }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { action in completion(1) }))
        self.present(alert, animated: true, completion: nil)
    }
}


