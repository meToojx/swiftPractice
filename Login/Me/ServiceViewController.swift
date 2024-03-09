//
//  ServiceViewController.swift
//  Login
//
//  Created by 金成四 on 2024/03/09.
//

import UIKit

class ServiceViewController: UIViewController {
    @IBOutlet weak var topLbel: UILabel!
    
    @IBOutlet weak var topPickerview: UIPickerView!
    
    @IBOutlet weak var onView: UIView!

    @IBOutlet weak var presentWebViewButton: UIButton!
    
    @IBOutlet weak var inputTextField: UITextField!
    var cities = ["東京", "大阪", "福岡"]
    var locations = [["歌舞伎町","吉原","川崎"],["飞田新地","南方"],["中州"]]
    var money = ["1000円", "2000円", "5000円", "10000円"]
    var citynum = 0
    var selected:(city:String,location:String) = ("city","location")
    let textFieldPickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func presemtAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "ShowWeb", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "ShowWeb") as! ShowWebViewController
        self.present(viewController, animated: true)
    }
    
    
    func setUI() {
        // 设置pickerview的方法
        topPickerview.dataSource = self
        topPickerview.delegate = self
        textFieldPickerView.dataSource = self
        textFieldPickerView.delegate = self
        inputTextField.inputView = textFieldPickerView
        topLbel.layer.borderWidth = 1
        topLbel.layer.borderColor = UIColor.black.cgColor
        topLbel.layer.cornerRadius = 10
        topLbel.layer.masksToBounds = true
        topLbel.text = "请滑动选项"
        topLbel.backgroundColor = .yellow
        topLbel.numberOfLines = 0
        let action = UITapGestureRecognizer(target: self, action: #selector(labelAction))
        topLbel.isUserInteractionEnabled = true
        topLbel.addGestureRecognizer(action)
        topPickerview.isHidden = true
        topPickerview.backgroundColor = .yellow
        let hideAction = UITapGestureRecognizer(target: self, action: #selector(hideLabelAction))
        self.view.addGestureRecognizer(hideAction)
        presentWebViewButton.backgroundColor = .blue
        presentWebViewButton.setTitle("無料案内", for: .normal)
        presentWebViewButton.tintColor = .yellow
    }
    @objc func labelAction() {
        print("picker is touched")
        topPickerview.isHidden = false
    }
    @objc func hideLabelAction() {
        print("view is touched")
        topPickerview.isHidden = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension ServiceViewController: UIPickerViewDataSource ,UIPickerViewDelegate {
    //设置pickerview有多少列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == topPickerview {
            return 2
        } else {
            return 1
        }
      }
      //设置pickerview上每一列分别有多少行
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == topPickerview {
            if component == 0 {
                return cities.count
            }else {
                return locations[citynum].count
            }
        } else {
            return money.count
        }
        
       
      }
    //设置pickerview上每一列的每一行分别显示什么
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == topPickerview {
            if component == 0 {
                return cities[row]
            }else {
                return locations[citynum][row]
            }
        }else {
            return "\(money[row])"
        }
    }
    //设置pickerview上选中某一行的处理
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == topPickerview {
            //让label显示被选中的语言
            if component == 0 {
                //选择城市
                citynum = row
                pickerView.reloadComponent(1)//重新加载
                //改城市（第0列）的时候 让地点回归到（第1列）第一行
                pickerView.selectRow(0, inComponent: 1, animated: true)
            }
            //第一列城市被选中的行数
            let cityindex = pickerView.selectedRow(inComponent: 0)
            //第二列被选中的行数
            let locationindex = pickerView.selectedRow(inComponent: 1)
            selected = (cities[cityindex], locations[cityindex][locationindex])
            topLbel.text = "我们下次去 \n" + selected.city + selected.location
        } else {
            inputTextField.text = "\(money[row])"
        }
      

    }
}
