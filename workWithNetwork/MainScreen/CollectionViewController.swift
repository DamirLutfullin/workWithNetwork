//
//  CollectionViewController.swift
//  workWithNetwork
//
//  Created by Damir Lutfullin on 04.11.2020.
//

import UIKit

enum UserActions: String, CaseIterable {
    case getImage
    case getRequest
    case postRequest
    case getCourses
    case uploadImage
}

struct Answer {
    var id : Int
    var userId : Int
    var title: String
    var body : String
}

private let urlForUploadImage = "https://api.imgur.com/3/image"
class CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Control"
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 25, right: 0)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserActions.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = 10
        cell.userAction.text = UserActions.allCases[indexPath.row].rawValue
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let userAction = UserActions.allCases[indexPath.row]
        switch userAction {
        case .getImage:
            performSegue(withIdentifier: userAction.rawValue, sender: nil)
        case .getRequest:
            NetworkManager.getRequest()
        case .postRequest:
            NetworkManager.postRequest()
        case .getCourses: performSegue(withIdentifier: userAction.rawValue, sender: nil)
        case .uploadImage:
            NetworkManager.uploadImage(url: urlForUploadImage)
        }
        
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 30,
                      height: (UIScreen.main.bounds.size.width - 30)/3)
    }
}


