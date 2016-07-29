//
//  Stencil+MathFilters.swift
//  Spelt
//
//  Created by Niels de Hoog on 23/02/16.
//  Copyright © 2016 Invisible Pixel. All rights reserved.
//

import Foundation

enum NumericVariableType {
    case IntegerType(Int)
    case DoubleType(Double)
    
    init?(_ value: Any?) {
        switch value {
        case let number as Double:
            self = .DoubleType(number)
        case let number as Int:
            self = .IntegerType(number)
        default:
            return nil
        }
    }
}

func /(left: NumericVariableType, right: NumericVariableType) -> Any {
    switch left {
    case .IntegerType(let left):
        switch right {
        case .IntegerType(let right):
            return Double(left) / Double(right)
        case .DoubleType(let right):
            return Double(left) / right
        }
    case .DoubleType(let left):
        switch right {
        case .IntegerType(let right):
            return left / Double(right)
        case .DoubleType(let right):
            return left / right
        }
    }
}

func dividedByFilter(value: Any?, arguments: [Any?]) throws -> Any? {
    guard arguments.count == 1 else {
        throw TemplateSyntaxError("'divided_by' filter expects exactly 1 argument, not \(arguments.count)")
    }
    
    guard let dividend = NumericVariableType(value) else {
        throw TemplateSyntaxError("'divided_by' filter expects numeric argument")
    }
    
    guard let divisor = NumericVariableType(arguments[0]) else {
        throw TemplateSyntaxError("'divided_by' filter expects numeric argument")
    }
    
    return dividend / divisor
}

func floorFilter(value: Any?) throws -> Any? {
    guard let doubleValue = value as? Double else {
        throw TemplateSyntaxError("'floor' filter expects floating point value")
    }
    
    return Int(floor(doubleValue))
}

func ceilFilter(value: Any?) throws -> Any? {
    guard let doubleValue = value as? Double else {
        throw TemplateSyntaxError("'ceil' filter expects floating point value")
    }
    
    return Int(ceil(doubleValue))
}