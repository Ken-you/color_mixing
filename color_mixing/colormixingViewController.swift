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

    
    @IBOutlet weak var redSilder: UISlider!
    @IBOutlet weak var greenSilder: UISlider!
    @IBOutlet weak var blueSilder: UISlider!
    @IBOutlet weak var alphaSilder: UISlider!
    @IBOutlet weak var gradientSilder: UISlider!
    @IBOutlet weak var radiusSilder: UISlider!
    
    
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
    @IBAction func ChangeSilder(_ sender: UISlider) {
        CarImage.backgroundColor = UIColor(red: CGFloat(redSilder.value), green: CGFloat(greenSilder.value), blue: CGFloat(blueSilder.value), alpha: CGFloat(alphaSilder.value))
        
        redLabel.text = String(format: "%.2f", redSilder.value)
        greenLabel.text = String(format: "%.2f", greenSilder.value)
        blueLabel.text = String(format: "%.2f", blueSilder.value)
        alphaLabel.text = String(format: "%.0f", alphaSilder.value * 100 ) + "%"
    }
    
    
    // RGB switch 開關 除了設定 silder 可不可以編輯也設定顏色
    @IBAction func switchRGB(_ sender: UISwitch) {
        
        if redSwitch.isOn{
            redSilder.isEnabled = true
            redSilder.minimumTrackTintColor = .red
            redSilder.thumbTintColor = .red
        }else{
            redSilder.isEnabled = false
            redSilder.minimumTrackTintColor = .gray
            redSilder.thumbTintColor = .gray
        }
        
        if greenSwitch.isOn{
            greenSilder.isEnabled = true
            greenSilder.minimumTrackTintColor = .green
            greenSilder.thumbTintColor = .green
        }else{
            greenSilder.isEnabled = false
            greenSilder.minimumTrackTintColor = .gray
            greenSilder.thumbTintColor = .gray
        }
        
        if blueSwitch.isOn{
            blueSilder.isEnabled = true
            blueSilder.minimumTrackTintColor = .blue
            blueSilder.thumbTintColor = .blue
        }else{
            blueSilder.isEnabled = false
            blueSilder.minimumTrackTintColor = .gray
            blueSilder.thumbTintColor = .gray
        }
        
    }
    
    
    // 隨機配色Button ，如果三個 switch 都打開才能按
    @IBAction func randomColor(_ sender: UIButton) {
        
        let randomRed = Float.random(in: 0.0...1.0)
        let randomGreen = Float.random(in: 0.0...1.0)
        let randomBlue = Float.random(in: 0.0...1.0)
        
        if redSwitch.isOn, greenSwitch.isOn, blueSwitch.isOn{
        
        redSilder.setValue(randomRed, animated: true)
        greenSilder.setValue(randomGreen, animated: true)
        blueSilder.setValue(randomBlue, animated: true)
    
        redLabel.text = String(format: "%.2f", redSilder.value)
        greenLabel.text = String(format: "%.2f", greenSilder.value)
        blueLabel.text = String(format: "%.2f", blueSilder.value)
    
        CarImage.backgroundColor = UIColor(red: CGFloat(randomRed), green: CGFloat(randomGreen), blue: CGFloat(randomBlue), alpha: 1)
        }
    }
    
    
    // 漸層 利用 CAGradientLayer() 最後加在 gradientView
    @IBAction func gradientSilder(_ sender: UISlider) {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = CarImage.bounds
        
        // 設定三種顏色
        gradientLayer.colors = [UIColor.blue.cgColor,UIColor.red.cgColor,UIColor.yellow.cgColor]
        
        // 有三種顏色，所以要寫三種數值，其中一個改成 silder 的數值
        gradientLayer.locations = [0.1, NSNumber(value: gradientSilder.value), 1]
        
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    
    // 圓角 
    @IBAction func radiusSilder(_ sender: UISlider) {
        CarImage.clipsToBounds = true
        CarImage.layer.cornerRadius = CGFloat(radiusSilder.value)
        gradientView.layer.cornerRadius = CGFloat(radiusSilder.value)
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

