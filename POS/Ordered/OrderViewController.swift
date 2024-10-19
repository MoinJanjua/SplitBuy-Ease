//
//  OrderViewController.swift
//  POS
//
//  Created by Maaz on 09/10/2024.
//

import UIKit

class OrderViewController: UIViewController, UITextFieldDelegate {
    
  //  , UIImagePickerControllerDelegate, UINavigationControllerDelegate
    
    @IBOutlet weak var MianView: UIView!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var UserTF: DropDown!
    @IBOutlet weak var ProductTF: DropDown!
    @IBOutlet weak var PaymentTF: DropDown!
    @IBOutlet weak var DateofOrder: UITextField!
    @IBOutlet weak var AmountTF: UITextField!
    @IBOutlet weak var AdvancePayTF: UITextField!
    @IBOutlet weak var CashView: UIView!
    @IBOutlet weak var InstallmentView: UIView!
    @IBOutlet weak var FirstInstallmentTF: UITextField!
    @IBOutlet weak var NowAmountTF: UITextField!
    
  //  var isFirstTimeTapped = true // Flag to track the first tap



    var pickedImage = UIImage()
    var Users_Detail: [User] = [] // Array of User model objects
    var products_Detail: [Products] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        applyCornerRadiusToBottomCorners(view: MianView, cornerRadius: 35)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture2.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture2)
        
        setupDatePicker(for: DateofOrder, target: self, doneAction: #selector(donePressed))
        
        // Set circular style for image
//        makeImageViewCircular(imageView: Image)
        
        // PaymentTF Dropdown
        PaymentTF.optionArray = ["Cash", "Installments"]
        PaymentTF.didSelect { (selectedText, index, id) in
            self.PaymentTF.text = selectedText
            
            // Show or hide views based on selection
            if index == 0 { // Cash selected
                self.CashView.isHidden = false
                self.InstallmentView.isHidden = true
            } else if index == 1 { // Installments selected
                self.CashView.isHidden = true
                self.InstallmentView.isHidden = false
            }
        }
        PaymentTF.delegate = self

        // Handle UserTF delegate if needed
        UserTF.delegate = self
        ProductTF.delegate = self
        
        
     //  NowAmountTF.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Load data from UserDefaults for Users_Detail
        if let savedData = UserDefaults.standard.array(forKey: "UserDetails") as? [Data] {
            let decoder = JSONDecoder()
            Users_Detail = savedData.compactMap { data in
                do {
                    let user = try decoder.decode(User.self, from: data)
                    return user
                } catch {
                    print("Error decoding user: \(error.localizedDescription)")
                    return nil
                }
            }
        }
        
        // Set up the dropdown options for UserTF
        setUpUserDropdown()
        
        // Load data from UserDefaults for Users_Detail
        if let savedData = UserDefaults.standard.array(forKey: "ProductDetails") as? [Data] {
            let decoder = JSONDecoder()
            products_Detail = savedData.compactMap { data in
                do {
                    let user = try decoder.decode(Products.self, from: data)
                    return user
                } catch {
                    print("Error decoding user: \(error.localizedDescription)")
                    return nil
                }
            }
        }
        // Set up the dropdown options for UserTF
        setUpProductsDropdown()
        
     // NowAmountTF.delegate = self
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    @objc func donePressed() {
        // Get the date from the picker and set it to the text field
        if let datePicker = DateofOrder.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy" // Same format as in convertStringToDate
            DateofOrder.text = dateFormatter.string(from: datePicker.date)
        }
        // Dismiss the keyboard
        DateofOrder.resignFirstResponder()
    }

    func makeImageViewCircular(imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
    }

    func clearTextFields() {
        UserTF.text = ""
        ProductTF.text = ""
        PaymentTF.text = ""
        DateofOrder.text = ""
        AmountTF.text = ""
        AdvancePayTF.text = ""
        FirstInstallmentTF.text = ""
        NowAmountTF.text = ""
    }
    // UITextFieldDelegate method to handle when text field editing begins
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == NowAmountTF {
            // Show an alert when NowAmountTF is tapped
            showAlert(title: "Notice", message: "Please Add Amount after implementing the installments charges")
            // Optionally, prevent the text field from becoming editable
            textField.resignFirstResponder() // This will dismiss the keyboard
        }
    }
    // Set up User dropdown options from Users_Detail array
    func setUpUserDropdown() {
        // Check if Users_Detail array is empty
        if Users_Detail.isEmpty {
            // If no users are available, set the text field to "No user available"
            UserTF.text = "No user available please first add the user"
            UserTF.isUserInteractionEnabled = false // Disable interaction if no users are available
        } else {
            // Extract names from the Users_Detail array
            let userNames = Users_Detail.map { $0.name }
            
            // Assign names to the dropdown
            UserTF.optionArray = userNames
            
            // Enable interaction if users are available
            UserTF.isUserInteractionEnabled = true
            
            // Handle selection from dropdown
            UserTF.didSelect { (selectedText, index, id) in
                self.UserTF.text = selectedText
                print("Selected user: \(self.Users_Detail[index])") // Optional: Handle selected user
            }
        }
    }
    // Set up User dropdown options from Users_Detail array
    func setUpProductsDropdown() {
        // Check if Users_Detail array is empty
        if products_Detail.isEmpty {
            // If no users are available, set the text field to "No user available"
            ProductTF.text = "No product available please first add the product"
            ProductTF.isUserInteractionEnabled = false // Disable interaction if no users are available
        } else {
            // Extract names from the Users_Detail array
            let userNames = products_Detail.map { $0.name }
            
            // Assign names to the dropdown
            ProductTF.optionArray = userNames
            
            // Enable interaction if users are available
            ProductTF.isUserInteractionEnabled = true
            
            // Handle selection from dropdown
            ProductTF.didSelect { (selectedText, index, id) in
                self.ProductTF.text = selectedText
                print("Selected user: \(self.products_Detail[index])") // Optional: Handle selected user
            }
        }
    }
    // UITextFieldDelegate method to handle when the text field editing should begin
//     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//         if textField == NowAmountTF {
//             // Show the alert only the first time the text field is tapped
//             if isFirstTimeTapped {
//                 showAmountAlert() // Show the alert
//                 return false // Prevent editing the text field until the alert is handled
//             }
//         }
//         return true // Allow editing if the text field is enabled
//     }
//     
//     // Function to show the alert
//     func showAmountAlert() {
//         let alert = UIAlertController(title: "Notice", message: "Please Add Amount after implementing the installments charges.", preferredStyle: .alert)
//         
//         let okAction = UIAlertAction(title: "OK", style: .default) { _ in
//             // Allow editing the text field after dismissing the alert
//             self.isFirstTimeTapped = false // Set the flag to false after the alert is shown
//             self.NowAmountTF.isEnabled = true
//             self.NowAmountTF.becomeFirstResponder() // Automatically focus on the text field
//         }
//         
//         alert.addAction(okAction)
//         present(alert, animated: true, completion: nil)
//     }



    func saveOrderData(_ sender: Any) {
        // Check if all mandatory fields are filled
        guard let user = UserTF.text, !user.isEmpty,
              let product = ProductTF.text, !product.isEmpty,
              let DateOr = DateofOrder.text, !DateOr.isEmpty,
              let payment = PaymentTF.text, !payment.isEmpty
        else {
            showAlert(title: "Error", message: "Please fill in all fields.")
            return
        }

        // Declare variables to hold payment details
        var amounts: String? = nil
        var advancePayments: String? = nil
        var firstInstallments: String? = nil
        var nowAmounts: String? = nil

        // Handle payment type
        if payment == "Cash" {
            // Check if AmountTF is filled
            if let cashAmount = AmountTF.text, !cashAmount.isEmpty {
                amounts = cashAmount
            } else {
                showAlert(title: "Error", message: "Please fill in the Amount field.")
                return
            }
        } else if payment == "Installments" {
            // Check if installment fields are filled
            if let advance = AdvancePayTF.text, !advance.isEmpty,
               let nowAmount = NowAmountTF.text, !nowAmount.isEmpty,
               let firstInstallment = FirstInstallmentTF.text {
                advancePayments = advance
                nowAmounts = nowAmount
                firstInstallments = firstInstallment /*?? "N/A"*/
            } else {
                showAlert(title: "Error", message: "Please enter all payment details.")
                return
            }
        }

        // Generate random character for order number
        let randomCharacter = generateOrderNumber()
        let CustomerId = generateCustomerId()

        // Create new order detail safely
        let newOrderDetail = Ordered(
            orderNo: "\(randomCharacter)", customerId: "\(CustomerId)",
            user: user,
            product: product,
            DateOfOrder: convertStringToDate(DateOr) ?? Date(),
            paymentType: payment,
            amount: amounts ?? "N/A", // Use a default value if nil
            advancePaymemt: advancePayments ?? "N/A",
            firstInstallment: firstInstallments ?? "N/A",
            nowAmount: nowAmounts ?? "N/A"
        )
        
        // Save the order detail
        saveOrderDetail(newOrderDetail)
    }


    func convertStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" // Corrected year format
        return dateFormatter.date(from: dateString)
    }
    
    func saveOrderDetail(_ order: Ordered) {
        var orders = UserDefaults.standard.object(forKey: "OrderDetails") as? [Data] ?? []
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(order)
            orders.append(data)
            UserDefaults.standard.set(orders, forKey: "OrderDetails")
            clearTextFields()
           
        } catch {
            print("Error encoding medication: \(error.localizedDescription)")
        }
        showAlert(title: "Done", message: "Order Detail has been Saved successfully.")
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        saveOrderData(sender)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

}
