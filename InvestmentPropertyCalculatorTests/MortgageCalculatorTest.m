//
//  MortgageCalculatorTest.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MortgageCalculatorTest.h"
#import "MortgageCalculator.h"

@implementation MortgageCalculatorTest

- (void)testGetMonthlyPayment {
    double payment = [MortgageCalculator getMonthlyPaymentFromPrincipal:75000
                                                           interestRate:4.25 
                                                                  years:30];
    
    STAssertEqualsWithAccuracy(368.95, payment, .01, @"Payments not equal");
    
    payment = [MortgageCalculator getMonthlyPaymentFromPrincipal:0 
                                                    interestRate:0.0 
                                                           years:0];
    
    STAssertEqualsWithAccuracy(0.0, payment, .01, @"Payments not equal");

}

@end
