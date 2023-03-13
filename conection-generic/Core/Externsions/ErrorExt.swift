//
//  ErrorExt.swift
//  conection-generic
//
//  Created by Jonn Alves on 13/03/23.
//

import Foundation
extension String {
    func toError(code:Int = -1) -> Error{
        return NSError(domain: self, code: code, userInfo: nil)
    }
}
