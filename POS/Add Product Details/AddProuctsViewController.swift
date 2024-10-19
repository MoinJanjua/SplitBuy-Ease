//
//  AddProuctsViewController.swift
//  POS
//
//  Created by Maaz on 10/10/2024.
//

import UIKit

class AddProuctsViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var MianView: UIView!

    @IBOutlet weak var productPriceTF: UITextField!
    @IBOutlet weak var productQuantityTF: UITextField!
    @IBOutlet weak var productNameTF: UITextField!
    @IBOutlet weak var Image: UIImageView!
    
    private var datePicker: UIDatePicker?
    var pickedImage = UIImage()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyCornerRadiusToBottomCorners(view: MianView, cornerRadius: 35)
       
        //    imagePiker Works
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        Image.isUserInteractionEnabled = true
        Image.addGestureRecognizer(tapGesture)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture2.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture2)
    }
    @objc func hideKeyboard()
      {
          view.endEditing(true)
      }
    func clearTextFields() {
        productPriceTF.text = ""
        productQuantityTF.text = ""
        productNameTF.text = ""
        Image.image = nil  // Clear the image
    }

    //ImagePicker Works
    @objc func imageViewTapped() {
        openGallery()
    }
    func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    func yourFunctionToTriggerImagePicker() {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let pickedImage = info[.originalImage] as? UIImage {
               picker.dismiss(animated: true) {
                   self.pickedImage = pickedImage
                   self.Image.image = pickedImage
               }
           }
       }
    
    func saveProductsData(_ sender: Any) {
        // Check if any of the text fields are empty
        guard let productName = productNameTF.text, !productName.isEmpty,
              let productQuantity = productQuantityTF.text, !productQuantity.isEmpty,
              let productPrice = productPriceTF.text, !productPrice.isEmpty
        else {
            showAlert(title: "Error", message: "Please fill in all fields.")
            return
        }
        
        // Check if an image is selected
        guard let pics = Image.image else {
            showAlert(title: "Error", message: "Please add a product picture.")
            return
        }
        
        guard let imageData = pics.jpegData(compressionQuality: 1.0) else {
            showAlert(title: "Error", message: "Error processing the image.")
            return
        }
        
        let randomCharacter = generateProductNumber()
        let newDetail = Products(
            id: "\(randomCharacter)",
            picData: imageData,
            name: productName,
            price: productPrice,
            quantities: productQuantity
        )
        saveProductDetail(newDetail)
    }

    
    func saveProductDetail(_ product: Products) {
        var products = UserDefaults.standard.object(forKey: "ProductDetails") as? [Data] ?? []
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(product)
            products.append(data)
            UserDefaults.standard.set(products, forKey: "ProductDetails")
            clearTextFields()
           
        } catch {
            print("Error encoding medication: \(error.localizedDescription)")
        }
        showAlert(title: "Done", message: "Product Detail has been Saved successfully.")
    }
    
    
    @IBAction func SaveButton(_ sender: Any) {
        saveProductsData(sender)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
