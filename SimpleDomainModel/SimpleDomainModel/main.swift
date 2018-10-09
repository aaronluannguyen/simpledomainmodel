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
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch self.type {
    case .Hourly(let hourlyRate):
      return Int(Double(hours) * hourlyRate)
      
    case .Salary(let yearlyRate):
      return yearlyRate
    }
  }
  
  open func raise(_ amt : Double) {
    switch self.type {
    case .Hourly(let hourlyRate):
      self.type = .Hourly(hourlyRate + amt)

    case .Salary(let yearlyRate):
      self.type = .Salary(yearlyRate + Int(amt))
    }
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get {
      if self.age < 16 {
        return nil
      }
      return _job
    }
    set(value) {
      if self.age < 16 {
        _job = nil
      }
      _job = value
    }
  }

  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get {
      if self.age < 16 {
        return nil
      }
      return _spouse
    }
    set(value) {
      if self.age < 16 {
        _spouse = nil
      }
      _spouse = value
    }
  }

  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }

  open func toString() -> String {
    return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job?.type) spouse:\(spouse?.firstName)]"
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []

  public init(spouse1: Person, spouse2: Person) {
    if (spouse1.spouse == nil && spouse2.spouse == nil) {
      spouse1.spouse = spouse2
      spouse2.spouse = spouse1
      self.members.append(spouse1)
      self.members.append(spouse2)
    }
  }

  open func haveChild(_ child: Person) -> Bool {
    var personOver21 = false
    for i in 0..<self.members.count {
      if self.members[i].age > 21 {
        personOver21 = true
      }
    }
    if personOver21 == true {
      self.members.append(child)
      return true
    }
    return false
  }

  open func householdIncome() -> Int {
    var total = 0
    for i in 0..<self.members.count {
      if self.members[i].job?.calculateIncome(2000) != nil {
        total += self.members[i].job!.calculateIncome(2000)
      }
    }
    return total
  }
}
