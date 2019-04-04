//
//  Alamofire.swift
//  MovieDBApiTask
//
//  Created by Sherif  Wagih on 4/4/19.
//  Copyright © 2019 Sherif  Wagih. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
