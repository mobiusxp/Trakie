//
//  TrakieErrors.swift
//  Trakie
//
//  Created by Khoa Nguyen on 12/4/15.
//  Copyright © 2015 Khoa Nguyen. All rights reserved.
//

import Foundation

// Possible Errors in Parsing or Retrieving Data
// should throw exceptions and have them handled.
enum TrakieError: ErrorType{
    case ParserError;
    case RetrieverError;
}