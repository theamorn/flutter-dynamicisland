//
//  PizzaDeliveryWidgets.swift
//  widgetExtension
//
//  Created by Amorn Apichattanakul on 21/9/2565 BE.
//

import SwiftUI

@main
struct PizzaDeliveryWidgets: WidgetBundle {
    var body: some Widget {
        PizzaDeliveryActivityWidget()
        // Not working, it will crash your app or LiveActivity won't work
//        widget()
    }
}
