//
//  NetworkResponseProtocol.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/17/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol NetworkResponseProtocol {
    func onSuccess(response : JSON, option: Int?)
    func onFailure(error : String, option: Int?)
}
