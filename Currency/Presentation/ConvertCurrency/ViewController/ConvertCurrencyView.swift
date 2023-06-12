import UIKit

class ConvertCurrencyView: BaseView {

    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        return lbl
    }()

    lazy var fromTextField: PickerTextField = {
        let txt = PickerTextField()
        txt.placeholder = "From"
        return txt
    }()

    lazy var toTextField: PickerTextField = {
        let txt = PickerTextField()
        txt.placeholder = "To"
        return txt
    }()

    lazy var swapBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)
        return btn
    }()

    lazy var inputValueTextField: UITextField = {
        let txt = UITextField()
        txt.placeholder = "1"
        txt.inputAccessoryView = toolBar()
        return txt
    }()

    lazy var convertedValueTextField: UITextField = {
        let txt = UITextField()
        txt.text = ""
        return txt
    }()

    lazy var detailsBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Details", for: .normal)
        btn.titleLabel?.textColor = .black
        btn.backgroundColor = .blue
        return btn
    }()

    override func setupView() {
        super.setupView()

        addSubview(titleLbl)
        titleLbl.anchor(.leading(leadingAnchor, constant: 20),
                        .trailing(trailingAnchor, constant: 20),
                        .top(topAnchor, constant: 100),
                        .height(25))

        addSubview(fromTextField)
        fromTextField.anchor(.leading(titleLbl.leadingAnchor),
                             .height(45),
                             .top(titleLbl.bottomAnchor, constant: 30))

        addSubview(swapBtn)
        swapBtn.anchor(.leading(fromTextField.trailingAnchor, constant: 20),
                       .width(45),
                       .height(45),
                       .centerY(fromTextField.centerYAnchor),
                       .centerX(centerXAnchor))

        addSubview(toTextField)
        toTextField.anchor(.leading(swapBtn.trailingAnchor, constant: 20),
                           .centerY(swapBtn.centerYAnchor),
                           .height(45),
                           .trailing(trailingAnchor, constant: 20))

        addSubview(inputValueTextField)
        inputValueTextField.anchor(.top(fromTextField.bottomAnchor, constant: 30),
                                   .leading(fromTextField.leadingAnchor),
                                   .trailing(fromTextField.trailingAnchor),
                                   .height(45))

        addSubview(convertedValueTextField)
        convertedValueTextField.anchor(.top(toTextField.bottomAnchor, constant: 30),
                                       .leading(toTextField.leadingAnchor),
                                       .trailing(toTextField.trailingAnchor),
                                       .height(45))

        addSubview(detailsBtn)
        detailsBtn.anchor(.height(45),
                          .width(100),
                          .centerX(centerXAnchor),
                          .top(convertedValueTextField.bottomAnchor, constant: 30))
    }

    func toolBar() -> UIToolbar{
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        doneButton.tintColor = .white
        cancelButton.tintColor = .white
        toolBar.setItems([cancelButton, space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }

    @objc func doneButtonPressed(){
        self.inputValueTextField.endEditing(true)
    }

    @objc func cancelButtonPressed(){
        self.inputValueTextField.endEditing(true)
    }
}
