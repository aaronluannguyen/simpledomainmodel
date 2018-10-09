//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  private let usd: String = "USD"
  private let gbp: String = "GBP"
  private let eur: String = "EUR"
  private let can: String = "CAN"
  
  public func convert(_ to: String) -> Money {
    return convertHelper(self, to)
  }
  
  public func add(_ to: Money) -> Money {
    if self.currency != to.currency {
      let newSelf = self.convert(to.currency)
      return Money(amount: newSelf.amount + to.amount, currency: to.currency)
    }
    return Money(amount: self.amount + to.amount, currency: to.currency)
  }
  public func subtract(_ from: Money) -> Money {
    if self.currency != from.currency {
      let newSelf = self.convert(from.currency)
      return Money(amount: from.amount - newSelf.amount, currency: from.currency)
    }
    return Money(amount: from.amount - self.amount, currency: from.currency)
  }
    
  private func convertHelper(_ current: Money, _ to: String) -> Money {
    switch current.currency {
    case usd:
      let newAmount = convertHelperTo(current.amount, to)
      return Money(amount: newAmount, currency: to)
      
    case gbp:
      let newAmount = convertHelperTo(current.amount * 2, to)
      return Money(amount: newAmount, currency: to)
      
    case eur:
      let newAmount = convertHelperTo(current.amount * 2 / 3, to)
      return Money(amount: newAmount, currency: to)
      
    case can:
      let newAmount = convertHelperTo(current.amount * 4 / 5, to)
      return Money(amount: newAmount, currency: to)
      
    default:
      return Money(amount: 0, currency: usd)
    }
  }
  
  private func convertHelperTo(_ currentAmount: Int, _ to: String) -> Int {
    switch to {
    case gbp:
      return currentAmount / 2
      
    case eur:
      return currentAmount * 3 / 2
      
    case can:
      return currentAmount * 5 / 4
      
    default:
      return currentAmount
    }
  }
}

////////////////////////////////////
// Job
//
//open class Job {
//  fileprivate var title : String
//  fileprivate var type : JobType
//
//  public enum JobType {
//    case Hourly(Double)
//    case Salary(Int)
//  }
//  
//  public init(title : String, type : JobType) {
//  }
//  
//  open func calculateIncome(_ hours: Int) -> Int {
//  }
//  
//  open func raise(_ amt : Double) {
//  }
//}

////////////////////////////////////
// Person
//
//open class Person {
//  open var firstName : String = ""
//  open var lastName : String = ""
//  open var age : Int = 0
//
//  fileprivate var _job : Job? = nil
//  open var job : Job? {
//    get { }
//    set(value) {
//    }
//  }
//
//  fileprivate var _spouse : Person? = nil
//  open var spouse : Person? {
//    get { }
//    set(value) {
//    }
//  }
//
//  public init(firstName : String, lastName: String, age : Int) {
//    self.firstName = firstName
//    self.lastName = lastName
//    self.age = age
//  }
//
//  open func toString() -> String {
//  }
//}

////////////////////////////////////
// Family
//
//open class Family {
//  fileprivate var members : [Person] = []
//
//  public init(spouse1: Person, spouse2: Person) {
//  }
//
//  open func haveChild(_ child: Person) -> Bool {
//  }
//
//  open func householdIncome() -> Int {
//  }
//}
