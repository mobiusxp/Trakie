//
//  Parser.swift
//  Trakie
//
//  Created by Khoa Nguyen on 12/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

protocol Parser{
    func parse() -> [Package];
}