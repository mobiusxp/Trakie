//
//  Parser.swift
//  Trakie
//
//  Created by Khoa Nguyen on 11/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

protocol Parser{
    // Protocol for parsers, parse is for single tracking numbers
    func parse(input:String) -> Package;
}