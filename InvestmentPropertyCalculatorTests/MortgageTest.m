//
//  MortgageCalculatorTest.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MortgageTest.h"
#import "Mortgage.h"
@implementation MortgageTest

-(void)setUp {
    testMortgage = [[Mortgage alloc] initWithSalesPrice:100000 downpayment:25.0 interestRate:4.25 years:30];
}

- (void) testGetDownpaymentAmount {    
    STAssertEquals(25000.00, [testMortgage getDownpaymentAmount], @"Downpayment not equal");
}

- (void) testGetInitialPrincipal {
    STAssertEquals(75000.0, [testMortgage getInitialPrincipal], @"Principal not equal");
}

- (void)testGetMonthlyPayment {
    STAssertEqualsWithAccuracy(368.95, [testMortgage getMonthlyPayment], .01, @"Payments not equal");
    
    Mortgage* emptyMortgage = [[Mortgage alloc] initWithSalesPrice:0 downpayment:0 interestRate:0 years:0];
    
    STAssertEqualsWithAccuracy(0.0, [emptyMortgage getMonthlyPayment], .01, @"Payments not equal");

}

@end
