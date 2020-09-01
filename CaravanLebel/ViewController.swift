//
//  ViewController.swift
//  CaravanLebel
//
//  Created by ChoiYongHo on 2020/08/31.
//  Copyright © 2020 Thinkup. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var circleView: UIImageView!
    @IBOutlet weak var horView: UIImageView!
    @IBOutlet weak var verView: UIImageView!
    
    private var cBubble : Bubble!
    private var hBubble : Bubble!
    private var vBubble : Bubble!
    
    var motionManager = CMMotionManager()
    
    var currentMaxAccelX : Double = 0.0
    var currentMaxAccelY : Double = 0.0
    var currentMaxAccelZ : Double = 0.0
    
    var currentMaxRotX : Double = 0.0
    var currentMaxRotY : Double = 0.0
    var currentMaxRotZ : Double = 0.0
    
    var viewInset : CGFloat = 20.0
    var acceptableDistance : CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initBackgroundView()
        initbubble()
        
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.gyroUpdateInterval = 0.2
        
        motionManager.startGyroUpdates()
        motionManager.startMagnetometerUpdates()
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: {
            (accelermeterData: CMAccelerometerData!, error: Error!) -> Void in
            self.outputAccelerationData(accelermeterData.acceleration)
            if(error != nil) {
                print("\(String(describing: error))")
            }
        })
        
//        motionManager.startGyroUpdates(to: OperationQueue.current!, withHandler: {
//            (gyroData: CMGyroData!, error: Error!) -> Void in
//            self.outputRotationData(gyroData.rotationRate)
//            if(error != nil) {
//                print("\(String(describing: error))")
//            }
//        })
        
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {
            (deviceMotion: CMDeviceMotion!, error: Error!) -> Void in
            self.outputAttitude(deviceMotion.attitude)
            if(error != nil) {
                print("\(String(describing: error))")
            }
        })
        
        print("Circle Frame  X:\(self.circleView.frame.origin.x), Y:\(self.circleView.frame.origin.y)")        
        print("Circle center X:\(self.circleView.center.x), Y:\(self.circleView.center.y)")
      
    }
    
    func outputAccelerationData(_ acceleration: CMAcceleration) {
//        print("X: \(acceleration.x).2fg")
        
        if fabs(acceleration.x) > fabs(currentMaxAccelX) {
            currentMaxAccelX = acceleration.x
        }
        
//        print("Y: \(acceleration.y).2fg")
        
        if fabs(acceleration.y) > fabs(currentMaxAccelY) {
            currentMaxAccelY = acceleration.y
        }
        
//        print("Z: \(acceleration.z).2fg")
        
        if fabs(acceleration.z) > fabs(currentMaxAccelZ) {
            currentMaxAccelZ = acceleration.z
        }
        
//        print("ACC CUR X:\(String(describing: acceleration.x)), Y:\(String(describing: acceleration.y)), Z:\(String(describing: acceleration.z))")
//        print("ACC MAX X:\(String(describing: currentMaxAccelX)), Y:\(String(describing: currentMaxAccelY)), Z:\(String(describing: currentMaxAccelZ))")
        
    }
    
    func outputRotationData(_ rotation: CMRotationRate) {
//        print("X: \(rotation.x).2fg")
        
        if fabs(rotation.x) > fabs(currentMaxRotX) {
            currentMaxRotX = rotation.x
        }
        
//        print("Y: \(rotation.y).2fg")
        
        if fabs(rotation.y) > fabs(currentMaxRotY) {
            currentMaxRotY = rotation.y
        }
        
//        print("Z: \(rotation.z).2fg")
        
        if fabs(rotation.z) > fabs(currentMaxRotZ) {
            currentMaxRotZ = rotation.z
        }
        
        print("ROT CUR X:\(String(describing: rotation.x)), Y:\(String(describing: rotation.y)), Z:\(String(describing: rotation.z))")
        print("ROT MAX X:\(String(describing: currentMaxRotX)), Y:\(String(describing: currentMaxRotY)), Z:\(String(describing: currentMaxRotZ))")
        
    }
    
    func outputAttitude(_ attitude: CMAttitude) {
//        print("Yaw:\(attitude.yaw), Pitch:\(attitude.pitch), Roll:\(attitude.roll)")
        
        let ratio = 120.0 / 25.0
        
//        var point = CGPoint(x: attitude.roll * ratio, y: attitude.pitch * ratio)
        var point = CGPoint(x: attitude.roll * ratio, y: attitude.pitch * ratio)
        let halfOfWidth : CGFloat = self.circleView.frame.origin.x
        
       // Covert range of point from [-PI, PI] to [0, frame.width]
        point.x = (point.x + .pi) / (2 * .pi) * self.circleView.frame.size.width
        point.y = (point.y + .pi) / (2 * .pi) * self.circleView.frame.size.width
        
        let maxDistance : CGFloat = halfOfWidth - viewInset
        let distance : CGFloat = CGFloat(sqrtf(powf(Float(point.x - halfOfWidth), 2) + powf(Float(point.y - halfOfWidth),2)))
        
        if( distance > maxDistance ) {
            let pointInCartesianCoordSystem : CGPoint = self.circleView.frame.origin
            let angle : CGFloat = atan2(pointInCartesianCoordSystem.y, pointInCartesianCoordSystem.x);
            
            point = CGPoint(x: cos(angle) * maxDistance, y: CGFloat(sinf(Float(angle))) * maxDistance)
        }
        
//        if( distance < acceptableDistance) {
//            self.circleView.backgroundColor = .green
//        }else {
//            self.circleView.backgroundColor = .red
//        }
        
        point = CGPoint(x: self.circleView.frame.size.width - point.x, y: self.circleView.frame.size.height - point.y)
        
        self.cBubble.center = point
//        print("X:\(point.x), Y:\(point.y)")
    }
    
    
    
    func initBackgroundView(){
        let circleview = CircleView(frame: circleView.frame)
        circleview.backgroundColor = .clear
        self.view.addSubview(circleview)
        
        let hroundBoxView = HRoundBox(frame: horView.frame)
        hroundBoxView.backgroundColor = .clear
        self.view.addSubview(hroundBoxView)
        
        let vroundBoxView = VRoundBox(frame: verView.frame)
        vroundBoxView.backgroundColor = .clear
        self.view.addSubview(vroundBoxView)
    }
    
    func initbubble() {
        cBubble = Bubble(frame: circleView.frame)
        cBubble.backgroundColor = .clear
        self.view.addSubview(cBubble)

        hBubble = Bubble(frame: horView.frame)
        hBubble.backgroundColor = .clear
        self.view.addSubview(hBubble)

        vBubble = Bubble(frame: verView.frame)
        vBubble.backgroundColor = .clear
        self.view.addSubview(vBubble)
    }


    @IBAction func btn_move1(_ sender: UIButton) {
        
    }
    @IBAction func btn_move2(_ sender: UIButton) {
    }
}

