//
//  main.swift
//  firstSwiftProgram
//
//  Created by Peihong Guo on 10/16/16.
//  Copyright © 2016 Peihong Guo. All rights reserved.
//

import Foundation

enum ArithmeticExpression {
    case Number(Int)
    indirect case Add(ArithmeticExpression, ArithmeticExpression)
    indirect case Mul(ArithmeticExpression, ArithmeticExpression)
    indirect case Sub(ArithmeticExpression, ArithmeticExpression)
    indirect case Div(ArithmeticExpression, ArithmeticExpression)
}

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .Number(value):
        return value
    case let .Add(left, right):
        return evaluate(left) + evaluate(right)
    case let .Sub(left, right):
        return evaluate(left) - evaluate(right)
    case let .Mul(left, right):
        return evaluate(left) * evaluate(right)
    case let .Div(left, right):
        return evaluate(left) / evaluate(right)
    }
}

let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let fourPlusFive = ArithmeticExpression.Add(five, four)

print(evaluate(fourPlusFive))
print(evaluate(ArithmeticExpression.Div(four, five)))



enum Operator {
    case Add
    case Sub
    case Mul
    case Div
}

class Expression {
    var value : Double?
    var left : Expression?
    var op : Operator?
    var right : Expression?
    
    init(_ value : Double?) {
        self.value = value
        self.left = nil
        self.op = nil
        self.right = nil
    }
    
    init(leftExpr left : Expression,
         operator op : Operator?,
         rightExpr right : Expression?) {
        self.value = nil
        self.left = left
        self.op = op
        self.right = right
    }
    
    func evaluate() -> Double {
        if value == nil {
            assert(left != nil && op != nil && right != nil, "Invalid expression!")
            switch op! {
            case .Add:
                value = left!.evaluate() + right!.evaluate()
            case .Sub:
                value = left!.evaluate() - right!.evaluate()
            case .Mul:
                value = left!.evaluate() * right!.evaluate()
            case .Div:
                value = left!.evaluate() / right!.evaluate()
            default:
                assert(false, "Unsupported operation.")
            }
        }
        
        return value!
    }
}

class Number : Expression {
    init(_ value : Double) {
        super.init(value)
    }
    override func evaluate() -> Double {
        assert(value != nil, "Invalid integer value!")
        return value!
    }
}

print(Number(5).evaluate())
print(Expression(leftExpr: Number(5), operator: .Add, rightExpr: Number(4)).evaluate())
print(Expression(leftExpr: Number(5), operator: .Mul, rightExpr: Number(4)).evaluate())
print(Expression(leftExpr: Number(5), operator: .Sub, rightExpr: Number(4)).evaluate())
print(Expression(leftExpr: Number(5), operator: .Div, rightExpr: Number(4)).evaluate())
