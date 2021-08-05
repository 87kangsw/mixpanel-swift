//
//  Greenfinch.swift
//  Mixpanel
//
//  Created by Kanz on 2021/07/31.
//  Copyright © 2021 Mixpanel. All rights reserved.
//

import Foundation
#if !os(OSX)
import UIKit
#endif // os(OSX)

/// The primary class for integrating Mixpanel with your app.
open class Greenfinch {

    #if !os(OSX) && !os(watchOS)
    /**
     Initializes an instance of the API with the given project token.

     Returns a new Mixpanel instance API object. This allows you to create more than one instance
     of the API object, which is convenient if you'd like to send data to more than
     one Mixpanel project from a single app.

     - parameter token:                     your project token
     - parameter launchOptions:             Optional. App delegate launchOptions
     - parameter flushInterval:             Optional. Interval to run background flushing
     - parameter instanceName:              Optional. The name you want to call this instance
     - parameter automaticPushTracking      whether or not to automatically track pushes sent from Mixpanel
     - parameter optOutTrackingByDefault:   Optional. Whether or not to be opted out from tracking by default

     - important: If you have more than one Mixpanel instance, it is beneficial to initialize
     the instances with an instanceName. Then they can be reached by calling getInstance with name.

     - returns: returns a mixpanel instance if needed to keep throughout the project.
     You can always get the instance by calling getInstance(name)
     */
    @discardableResult
    open class func initialize(token apiToken: String,
                               serviceName: String,
                               isDebugMode: Bool,
                               launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil,
                               flushInterval: Double = 60,
                               instanceName: String = UUID().uuidString,
                               automaticPushTracking: Bool = true,
                               optOutTrackingByDefault: Bool = false) -> MixpanelInstance {
        return MixpanelManager.sharedInstance.initialize(token: apiToken,
                                                         serviceName: serviceName,
                                                         isDebugMode: isDebugMode,
                                                         launchOptions: launchOptions,
                                                         flushInterval: flushInterval,
                                                         instanceName: instanceName,
                                                         automaticPushTracking: automaticPushTracking,
                                                         optOutTrackingByDefault: optOutTrackingByDefault)
    }
    #else
    /**
     Initializes an instance of the API with the given project token (MAC OS ONLY).

     Returns a new Mixpanel instance API object. This allows you to create more than one instance
     of the API object, which is convenient if you'd like to send data to more than
     one Mixpanel project from a single app.

     - parameter token:                     your project token
     - parameter flushInterval:             Optional. Interval to run background flushing
     - parameter instanceName:              Optional. The name you want to call this instance
     - parameter optOutTrackingByDefault:   Optional. Whether or not to be opted out from tracking by default

     - important: If you have more than one Mixpanel instance, it is beneficial to initialize
     the instances with an instanceName. Then they can be reached by calling getInstance with name.

     - returns: returns a mixpanel instance if needed to keep throughout the project.
     You can always get the instance by calling getInstance(name)
     */

    @discardableResult
    open class func initialize(token apiToken: String,
                               flushInterval: Double = 60,
                               instanceName: String = UUID().uuidString,
                               optOutTrackingByDefault: Bool = false) -> MixpanelInstance {
        return MixpanelManager.sharedInstance.initialize(token: apiToken,
                                                         flushInterval: flushInterval,
                                                         instanceName: instanceName,
                                                         optOutTrackingByDefault: optOutTrackingByDefault)
    }
    #endif // os(OSX)

    /**
     Gets the mixpanel instance with the given name

     - parameter name: the instance name

     - returns: returns the mixpanel instance
     */
    open class func getInstance(name: String) -> MixpanelInstance? {
        return MixpanelManager.sharedInstance.getInstance(name: name)
    }

    /**
     Returns the main instance that was initialized.

     If not specified explicitly, the main instance is always the last instance added

     - returns: returns the main Mixpanel instance
     */
    open class func mainInstance() -> MixpanelInstance {
        if let instance = MixpanelManager.sharedInstance.getMainInstance() {
            return instance
        } else {
            assert(false, "You have to call initialize(token:) before calling the main instance, " +
                "or define a new main instance if removing the main one")
            return Greenfinch.initialize(token: "", serviceName: "", isDebugMode: true)
        }
    }

    /**
     Sets the main instance based on the instance name

     - parameter name: the instance name
     */
    open class func setMainInstance(name: String) {
        MixpanelManager.sharedInstance.setMainInstance(name: name)
    }

    /**
     Removes an unneeded Mixpanel instance based on its name

     - parameter name: the instance name
     */
    open class func removeInstance(name: String) {
        MixpanelManager.sharedInstance.removeInstance(name: name)
    }
}
