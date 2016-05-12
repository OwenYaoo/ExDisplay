//
//  WeatherView.swift
//  ExDisplay
//
//  Created by lihao on 16/4/22.
//  Copyright © 2016年 AppStudio. All rights reserved.
//

import UIKit

let WeatherViewWidth: CGFloat = 195.0
let WeatherViewHeight: CGFloat = 295.0

class WeatherView: UIView {
    
    lazy var locationImage: UIImageView = UIImageView.init(frame: CGRectZero)
    lazy var locationLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var tempLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var weatherImage: UIImageView = UIImageView.init(frame: CGRectZero)
    lazy var weatherLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var carWashIndexLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var carWashIndexZsLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var carWashIndexDesLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var PMLabel: UILabel = UILabel.init(frame: CGRectZero)
    lazy var PMNumLabel: UILabel = UILabel.init(frame: CGRectZero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(patternImage: UIImage(named: "homeWeather-backgroundImage2x")!)
        layoutWeather(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutWeather(frame: CGRect) {
        self.addSubview(locationImage)
        self.addSubview(locationLabel)
        self.addSubview(tempLabel)
        self.addSubview(weatherImage)
        self.addSubview(weatherLabel)
        self.addSubview(carWashIndexLabel)
        self.addSubview(carWashIndexZsLabel)
        self.addSubview(carWashIndexDesLabel)
        self.addSubview(PMLabel)
        self.addSubview(PMNumLabel)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        let locationLabelContrainCenterX: NSLayoutConstraint = NSLayoutConstraint.init(item: locationLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 10.0)
        let locationLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: locationLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 5.0)
        let locationLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: locationLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 20.0 / WeatherViewHeight, constant: 0.0)
        let locationLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: locationLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 100.0 / WeatherViewWidth, constant: 0.0)
        let locationLabelContrains: NSArray = [locationLabelContrainTop, locationLabelContrainWidth, locationLabelContrainHeight, locationLabelContrainCenterX]
        self.addConstraints(locationLabelContrains as! [NSLayoutConstraint])
        locationLabel.text = "定位中..."
        locationLabel.textColor = UIColor.whiteColor()
        locationLabel.textAlignment = .Center
        
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        let locationImageContrainTrailing: NSLayoutConstraint = NSLayoutConstraint.init(item: locationImage, attribute: .Trailing, relatedBy: .Equal, toItem: locationLabel, attribute: .Leading, multiplier: 1.0, constant: -5.0)
        let locationImageContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: locationImage, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 9.0)
        let locationImageContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: locationImage, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 13.0 / WeatherViewHeight, constant: 0.0)
        let locationImageContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: locationImage, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 10.0 / WeatherViewWidth, constant: 0.0)
        let locationImageContrains: NSArray = [locationImageContrainTop, locationImageContrainWidth, locationImageContrainHeight, locationImageContrainTrailing]
        self.addConstraints(locationImageContrains as! [NSLayoutConstraint])
        locationImage.image = UIImage(named: "homeWeather-location")
        
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        let tempLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: tempLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 20.0)
        let tempLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: tempLabel, attribute: .Top, relatedBy: .Equal, toItem: locationLabel, attribute: .Bottom, multiplier: 1.0, constant: 10.0)
        let tempLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: tempLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 80.0 / WeatherViewHeight, constant: 0.0)
        let tempLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: tempLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1.0, constant: -40.0)
        let tempLabelContrains: NSArray = [tempLabelContrainTop, tempLabelContrainWidth, tempLabelContrainHeight, tempLabelContrainLeading]
        self.addConstraints(tempLabelContrains as! [NSLayoutConstraint])
        tempLabel.text = "--"
        tempLabel.textAlignment = .Center
        tempLabel.textColor = UIColor.whiteColor()
        
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        let weatherLabelContrainTrailing: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherLabel, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: -15.0)
        let weatherLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherLabel, attribute: .Top, relatedBy: .Equal, toItem: tempLabel, attribute: .Bottom, multiplier: 1.0, constant: 10.0)
        let weatherLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 29.0 / WeatherViewHeight, constant: 0.0)
        let weatherLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 140.0 / WeatherViewWidth, constant: 0.0)
        let weatherLabelContrains: NSArray = [weatherLabelContrainTop, weatherLabelContrainWidth, weatherLabelContrainHeight, weatherLabelContrainTrailing]
        self.addConstraints(weatherLabelContrains as! [NSLayoutConstraint])
        weatherLabel.text = "--"
        weatherLabel.textColor = UIColor.whiteColor()
        weatherLabel.textAlignment = .Center
        
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        let weatherImageContrainTrailing: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherImage, attribute: .Trailing, relatedBy: .Equal, toItem: weatherLabel, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let weatherImageContrainCenterY: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherImage, attribute: .CenterY, relatedBy: .Equal, toItem: weatherLabel, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        let weatherImageContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherImage, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 15.0 / WeatherViewHeight, constant: 0.0)
        let weatherImageContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: weatherImage, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 22.0 / WeatherViewWidth, constant: 0.0)
        let weatherImageContrains: NSArray = [weatherImageContrainCenterY, weatherImageContrainWidth, weatherImageContrainHeight, weatherImageContrainTrailing]
        self.addConstraints(weatherImageContrains as! [NSLayoutConstraint])
        weatherImage.image = UIImage(named: "homeWeather-cloudy")
        
        PMLabel.translatesAutoresizingMaskIntoConstraints = false
        let PMLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: PMLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 20.0)
        let PMLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: PMLabel, attribute: .Top, relatedBy: .Equal, toItem: weatherLabel, attribute: .Bottom, multiplier: 1.0, constant: 10.0)
        let PMLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: PMLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 29.0 / WeatherViewHeight, constant: 0.0)
        let PMLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: PMLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 80.0 / WeatherViewWidth, constant: 0.0)
        let PMLabelContrains: NSArray = [PMLabelContrainTop, PMLabelContrainWidth, PMLabelContrainHeight, PMLabelContrainLeading]
        self.addConstraints(PMLabelContrains as! [NSLayoutConstraint])
        PMLabel.text = "PM2.5"
        PMLabel.textColor = UIColor.whiteColor()
        PMLabel.textAlignment = .Center
        
        PMNumLabel.translatesAutoresizingMaskIntoConstraints = false
        let PMNumLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: PMNumLabel, attribute: .Leading, relatedBy: .Equal, toItem: PMLabel, attribute: .Trailing, multiplier: 1.0, constant: 10.0)
        let PMNumLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: PMNumLabel, attribute: .Top, relatedBy: .Equal, toItem: weatherLabel, attribute: .Bottom, multiplier: 1.0, constant: 10.0)
        let PMNumLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: PMNumLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 29.0 / WeatherViewHeight, constant: 0.0)
        let PMNumLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: PMNumLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 80.0 / WeatherViewWidth, constant: 0.0)
        let PMNumLabelContrains: NSArray = [PMNumLabelContrainTop, PMNumLabelContrainWidth, PMNumLabelContrainHeight, PMNumLabelContrainLeading]
        self.addConstraints(PMNumLabelContrains as! [NSLayoutConstraint])
        PMNumLabel.font = UIFont.systemFontOfSize(25.0)
        PMNumLabel.text = "--"
        PMNumLabel.textColor = UIColor.whiteColor()
        PMNumLabel.textAlignment = .Center
        
        carWashIndexLabel.translatesAutoresizingMaskIntoConstraints = false
        let carWashIndexLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 20.0)
        let carWashIndexLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexLabel, attribute: .Top, relatedBy: .Equal, toItem: PMLabel, attribute: .Bottom, multiplier: 1.0, constant: 10.0)
        let carWashIndexLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 29.0 / WeatherViewHeight, constant: 0.0)
        let carWashIndexLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 80.0 / WeatherViewWidth, constant: 0.0)
        let carWashIndexLabelContrains: NSArray = [carWashIndexLabelContrainTop, carWashIndexLabelContrainWidth, carWashIndexLabelContrainHeight, carWashIndexLabelContrainLeading]
        self.addConstraints(carWashIndexLabelContrains as! [NSLayoutConstraint])
        carWashIndexLabel.text = "洗车指数："
        carWashIndexLabel.textColor = UIColor.whiteColor()
        carWashIndexLabel.textAlignment = .Center
        
        carWashIndexZsLabel.translatesAutoresizingMaskIntoConstraints = false
        let carWashIndexZsLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexZsLabel, attribute: .Leading, relatedBy: .Equal, toItem: carWashIndexLabel, attribute: .Trailing, multiplier: 1.0, constant: 10.0)
        let carWashIndexZsLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexZsLabel, attribute: .Top, relatedBy: .Equal, toItem: carWashIndexLabel, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let carWashIndexZsLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexZsLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 29.0 / WeatherViewHeight, constant: 0.0)
        let carWashIndexZsLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexZsLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 80.0 / WeatherViewWidth, constant: 0.0)
        let carWashIndexZsLabelContrains: NSArray = [carWashIndexZsLabelContrainTop, carWashIndexZsLabelContrainWidth, carWashIndexZsLabelContrainHeight, carWashIndexZsLabelContrainLeading]
        self.addConstraints(carWashIndexZsLabelContrains as! [NSLayoutConstraint])
        carWashIndexZsLabel.font = UIFont.systemFontOfSize(25.0)
        carWashIndexZsLabel.text = "--"
        carWashIndexZsLabel.textColor = UIColor.whiteColor()
        carWashIndexZsLabel.textAlignment = .Center
        
        carWashIndexDesLabel.translatesAutoresizingMaskIntoConstraints = false
        let carWashIndexDesLabelContrainLeading: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexDesLabel, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 13.0)
        let carWashIndexDesLabelContrainTop: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexDesLabel, attribute: .Top, relatedBy: .Equal, toItem: carWashIndexZsLabel, attribute: .Bottom, multiplier: 1.0, constant: 10.0)
        let carWashIndexDesLabelContrainHeight: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexDesLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 70.0 / WeatherViewHeight, constant: 0.0)
        let carWashIndexDesLabelContrainWidth: NSLayoutConstraint = NSLayoutConstraint.init(item: carWashIndexDesLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1.0, constant: -26.0)
        let carWashIndexDesLabelContrains: NSArray = [carWashIndexDesLabelContrainTop, carWashIndexDesLabelContrainWidth, carWashIndexDesLabelContrainHeight, carWashIndexDesLabelContrainLeading]
        self.addConstraints(carWashIndexDesLabelContrains as! [NSLayoutConstraint])
        carWashIndexDesLabel.numberOfLines = 0
        carWashIndexDesLabel.textColor = UIColor.whiteColor()
    }
}
