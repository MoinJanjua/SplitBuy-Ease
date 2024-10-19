//
//  ProductViewController.swift
//  POS
//
//  Created by Maaz on 09/10/2024.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var MianView: UIView!
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var currencyBtn: UIButton!
    
    var products_Detail: [Products] = []
    
    var currency = String()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currency = UserDefaults.standard.value(forKey: "currencyISoCode") as? String ?? "$"
        
        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        
        applyCornerRadiusToBottomCorners(view: MianView, cornerRadius: 35)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currency = UserDefaults.standard.value(forKey: "currencyISoCode") as? String ?? "$"

        if let savedData = UserDefaults.standard.array(forKey: "ProductDetails") as? [Data] {
            let decoder = JSONDecoder()
            products_Detail = savedData.compactMap { data in
                do {
                    let productsData = try decoder.decode(Products.self, from: data)
                    return productsData
                } catch {
                    print("Error decoding product: \(error.localizedDescription)")
                    return nil
                }
            }
        }
        print(products_Detail)  // Check if data is loaded
        CollectionView.reloadData()
    }

    @IBAction func CurrencyBtn(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CurrencyViewController") as! CurrencyViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func AddProductButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddProuctsViewController") as! AddProuctsViewController
        newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
extension ProductViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products_Detail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productsCell", for: indexPath) as! productsCollectionViewCell
        
        let productsData = products_Detail[indexPath.item]
        cell.productNameLabel.text = productsData.name
        cell.productQunatityLabel.text = productsData.quantities
        cell.productPriceLabel.text = "\(currency) \(productsData.price)"         
 
        if let image = productsData.pic {
            cell.producImages.image = image
        } else {
            cell.producImages.image = UIImage(named: "") // Set a placeholder image if no image is available
        }
     //   cell.images.image? =  Imgs [indexPath.item]
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing: CGFloat = 10
        let availableWidth = collectionViewWidth - (spacing * 3)
        let width = availableWidth / 2
        return CGSize(width: width + 3, height: width + 25)
        // return CGSize(width: wallpaperCollectionView.frame.size.width , height: wallpaperCollectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Adjust as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5) // Adjust as needed
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        if indexPath.row == 0
//        {
            //                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //                let newViewController = storyBoard.instantiateViewController(withIdentifier: "ReligiousViewController") as! ReligiousViewController
            //                newViewController.isFromHomeName = titleList[indexPath.row]
            //                newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            //                newViewController.modalTransitionStyle = .crossDissolve
            //                self.present(newViewController, animated: true, completion: nil)
      //  }}
    }

