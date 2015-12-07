//
//  Parser.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

protocol Parser{
    
    var dm:DataManager? {get set}
    // Protocol for parsers, parse is for single tracking numbers
    func parse(package:Package, input:String) throws -> Package;
}