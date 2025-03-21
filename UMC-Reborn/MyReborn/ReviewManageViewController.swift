//
//  ReviewManageViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/18.
//

import UIKit

class ReviewManageViewController: UIViewController {
    
    let userReview = UserDefaults.standard.integer(forKey: "userIndex")
    
    var reviewDatas: [ReviewManageModelResponse] = []
    
    // 이미지 사이즈 지정
    let imageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.contentMode = .scaleAspectFill
        aImageView.layer.cornerRadius = 16
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        return aImageView
    }()
    //
    
    var imageArray = [UIImage(named: "bread1"), UIImage(named: "bread2"),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "리뷰 관리"
        

        
        ReviewManageService.shared.getUserReview{ result in
            switch result {
            case .success(let response):
                print("리뷰 이미지 불러오기 성공")
//                dump(response)
                guard let response = response as? ReviewManageModel else {
                    print("실패")
                    break
                }
                self.reviewDatas = response.result
                
            default:
                break
            }
        }
    }
}

extension ReviewManageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewImageCollectionViewCell", for: indexPath) as! ReviewImageCollectionViewCell
        
        cell.reviewImage.image = imageArray[indexPath.row]
        
        cell.reviewImage.layer.cornerRadius  = 16
        return cell
    }
    
}
