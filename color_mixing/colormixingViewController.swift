//
//  colormixingViewController.swift
//  color_mixing
//
//  Created by yousun on 2021/4/16.
//

import UIKit

class colormixingViewController: UIViewController {
    
    // 去背的 ImageView
    @IBOutlet weak var CarImage: UIImageView!
    
    // 漸層的 View
    @IBOutlet weak var gradientView: UIView!

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var gradientSlider: UISlider!
    
    @IBOutlet weak var radiusSlider: UISlider!
    

    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var alphaLabel: UILabel!
    
    
    @IBOutlet weak var redSwitch: UISwitch!
    @IBOutlet weak var greenSwitch: UISwitch!
    @IBOutlet weak var blueSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // RGBA silder 都拉在同一個 Action ，取 silder 的數值設定在 label
    @IBAction func ChangeSlider(_ sender: UISlider) {
        CarImage.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
        
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
        alphaLabel.text = String(format: "%.0f", alphaSlider.value * 100 ) + "%"
    }
    
    
    // RGB switch 開關 除了設定 silder 可不可以編輯也設定顏色
    @IBAction func switchRGB(_ sender: UISwitch) {
        
        if redSwitch.isOn{
            redSlider.isEnabled = true
            redSlider.minimumTrackTintColor = .red
            redSlider.thumbTintColor = .red
        }else{
            redSlider.isEnabled = false
            redSlider.minimumTrackTintColor = .gray
            redSlider.thumbTintColor = .gray
        }
        
        if greenSwitch.isOn{
            greenSlider.isEnabled = true
            greenSlider.minimumTrackTintColor = .green
            greenSlider.thumbTintColor = .green
        }else{
            greenSlider.isEnabled = false
            greenSlider.minimumTrackTintColor = .gray
            greenSlider.thumbTintColor = .gray
        }
        
        if blueSwitch.isOn{
            blueSlider.isEnabled = true
            blueSlider.minimumTrackTintColor = .blue
            blueSlider.thumbTintColor = .blue
        }else{
            blueSlider.isEnabled = false
            blueSlider.minimumTrackTintColor = .gray
            blueSlider.thumbTintColor = .gray
        }
        
    }
    
    
    // 隨機配色Button ，如果三個 switch 都打開才能按
    @IBAction func randomColor(_ sender: UIButton) {
        
        let randomRed = Float.random(in: 0.0...1.0)
        let randomGreen = Float.random(in: 0.0...1.0)
        let randomBlue = Float.random(in: 0.0...1.0)
        
        if redSwitch.isOn, greenSwitch.isOn, blueSwitch.isOn{
        
        redSlider.setValue(randomRed, animated: true)
        greenSlider.setValue(randomGreen, animated: true)
        blueSlider.setValue(randomBlue, animated: true)
    
        redLabel.text = String(format: "%.2f", redSlider.value)
        greenLabel.text = String(format: "%.2f", greenSlider.value)
        blueLabel.text = String(format: "%.2f", blueSlider.value)
    
        CarImage.backgroundColor = UIColor(red: CGFloat(randomRed), green: CGFloat(randomGreen), blue: CGFloat(randomBlue), alpha: 1)
        }
    }
    
    
    // 漸層 利用 CAGradientLayer() 最後加在 gradientView
    @IBAction func gradientSlider(_ sender: UISlider) {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = CarImage.bounds
        
        // 設定三種顏色
        gradientLayer.colors = [UIColor.blue.cgColor,UIColor.red.cgColor,UIColor.yellow.cgColor]
        
        // 有三種顏色，所以要寫三種數值，其中一個改成 silder 的數值
        gradientLayer.locations = [0.1, NSNumber(value: gradientSlider.value), 1]
        
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    
    // 圓角 
    @IBAction func radiusSlider(_ sender: UISlider) {
        CarImage.clipsToBounds = true
        CarImage.layer.cornerRadius = CGFloat(radiusSlider.value)
        gradientView.layer.cornerRadius = CGFloat(radiusSlider.value)
    }
    
    
    // 順時鐘轉 90 度
    @IBAction func Clockwise(_ sender: Any) {
        let oneDegree = CGFloat.pi/180
        CarImage.transform = CarImage.transform.rotated(by: oneDegree * 90)
        gradientView.transform = gradientView.transform.rotated(by: oneDegree * 90)
    }
    
    
    // 逆時鐘轉 90 度
    @IBAction func Counterclockwise(_ sender: Any) {
        let oneDegree = CGFloat.pi/180
        CarImage.transform = CarImage.transform.rotated(by: oneDegree * -90)
        gradientView.transform = gradientView.transform.rotated(by: oneDegree * -90)
    }
}

