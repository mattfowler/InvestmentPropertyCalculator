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
    DollarValue *salesPrice = [DollarValue createValue:100000];
    testMortgage = [[Mortgage alloc] initWithSalesPrice:salesPrice downpayment:25.0 interestRate:4.25 years:30];
}

- (void) testGetDownpaymentAmount {    
    STAssertEquals(25000.00, testMortgage.getDownpaymentAmount.doubleValue, @"Downpayment not equal");
}

- (void) testGetMonthlyPayment {
    STAssertEqualsWithAccuracy(368.95, [[testMortgage getMonthlyPayment] doubleValue], .01, @"Payments not equal");
    
    Mortgage* emptyMortgage = [[Mortgage alloc] initWithSalesPrice:0 downpayment:0 interestRate:0 years:0];
    
    STAssertEqualsWithAccuracy(0.0, emptyMortgage.getMonthlyPayment.doubleValue, .01, @"Payments not equal");
}

- (void) testGetTotalInterestPaid {
    double totalPayments = testMortgage.getMonthlyPayment.doubleValue * 360;
    
    STAssertEqualsWithAccuracy(totalPayments - 75000.0, testMortgage.getTotalInterestPaid.doubleValue, .01, @"Total interest not equal");
}

- (void) testGetInterestPaidInYear {
    double expectedInterest = 3163.06;
    double expectedInterestYearThirty = 100.26;
    double expectedInterestYearFourty = 0.0;
    STAssertEqualsWithAccuracy(expectedInterest, [testMortgage getInterestPaidInYear:1].doubleValue, .01, @"Interests not equal for first year");
    STAssertEqualsWithAccuracy(expectedInterestYearThirty, [testMortgage getInterestPaidInYear:30].doubleValue, .01, @"Interest not equal for last year");
    STAssertEqualsWithAccuracy(expectedInterestYearFourty, [testMortgage getInterestPaidInYear:40].doubleValue, .01, @"Interest not equal after mortgage paid");
}

- (void) testGetPrincipalPaidInYear {
    double expectedPrincipalZeroYear = 0.0;
    double expectedPrincipal = 1264.4;
    double expectedPrincipalYearThirty = 4327.2;
    double expectedPrincipalYearFourty = 0.0;
    
    STAssertEqualsWithAccuracy(expectedPrincipalZeroYear, [testMortgage getPrincipalPaidInYear:0].doubleValue, .01, @"Principal not equal for first year");
    STAssertEqualsWithAccuracy(expectedPrincipal, [testMortgage getPrincipalPaidInYear:1].doubleValue, .01, @"Principal not equal for first year");
    STAssertEqualsWithAccuracy(expectedPrincipalYearThirty, [testMortgage getPrincipalPaidInYear:30].doubleValue, .01, @"Interest not equal for last year");
    STAssertEqualsWithAccuracy(expectedPrincipalYearFourty, [testMortgage getPrincipalPaidInYear:40].doubleValue, .01, @"Interest not equal for last year");
}

@end
