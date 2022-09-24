import UIKit
import ActivityKit
import SwiftUI
import Flutter

@available(iOS 16.1, *)
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var deliveryActivity: Activity<PizzaDeliveryAttributes>?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        if let controller = window?.rootViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(
                name: "com.theamorn.widgetKit",
                binaryMessenger: controller.binaryMessenger)
            
            channel.setMethodCallHandler({ [weak self] (
                call: FlutterMethodCall,
                result: @escaping FlutterResult) -> Void in
                switch call.method {
                case "startLiveActivity":
                    self?.startLiveActivity()
                case "updateLiveActivity":
                    self?.updateLiveActivity()
                case "stopLiveActivity":
                    self?.stopLiveActivity()
                case "showAll":
                    self?.showAllLiveActivity()
                default:
                    result(FlutterMethodNotImplemented)
                }
            })
        }
        
        GeneratedPluginRegistrant.register(with: self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func startLiveActivity() {
        var future = Calendar.current.date(byAdding: .minute, value: (Int(3)), to: Date())!
        future = Calendar.current.date(byAdding: .second, value: (Int(0)), to: future)!
        let date = Date.now...future
        let initialContentState = PizzaDeliveryAttributes.ContentState(driverName: "Bill James", deliveryTimer:date)
        let activityAttributes = PizzaDeliveryAttributes(numberOfPizzas: 3, totalAmount: "$42.00", orderNumber: "12345")
        
        do {
            deliveryActivity = try Activity.request(attributes: activityAttributes, contentState: initialContentState)
            print("Requested a pizza delivery Live Activity \(deliveryActivity?.id ?? "N/A")).")
        } catch (let error) {
            print("Error requesting pizza delivery Live Activity \(error.localizedDescription).")
        }
    }
    
    func updateLiveActivity() {
        var future = Calendar.current.date(byAdding: .minute, value: Int(1), to: Date())!
        future = Calendar.current.date(byAdding: .second, value: Int(0), to: future)!
        let date = Date.now...future
        let updatedDeliveryStatus = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: "Anne Johnson", deliveryTimer: date)
        
        let alertConfiguration = AlertConfiguration(title: "Delivery Update", body: "Your pizza order will arrive in 25 minutes.", sound: .default)
        Task {
            await deliveryActivity?.update(using: updatedDeliveryStatus, alertConfiguration: alertConfiguration)
        }
    }
    
    func stopLiveActivity() {
        let finalDeliveryStatus = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: "Anne Johnson", deliveryTimer: Date.now...Date())
        
        Task {
            await deliveryActivity?.end(using:finalDeliveryStatus, dismissalPolicy: .default)
        }
        
    }
    
    func showAllLiveActivity() {
        Task {
            for await activity in Activity<PizzaDeliveryAttributes>.activityUpdates {
                print("Pizza delivery details: \(activity.attributes)")
            }
        }
    }
}
