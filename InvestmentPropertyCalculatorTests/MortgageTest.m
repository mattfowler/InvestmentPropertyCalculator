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

- (void) testGetMonthlyPayment {
    STAssertEqualsWithAccuracy(368.95, [testMortgage getMonthlyPayment], .01, @"Payments not equal");
    
    Mortgage* emptyMortgage = [[Mortgage alloc] initWithSalesPrice:0 downpayment:0 interestRate:0 years:0];
    
    STAssertEqualsWithAccuracy(0.0, [emptyMortgage getMonthlyPayment], .01, @"Payments not equal");
}

- (void) testGetTotalInterestPaid {
    double totalPayments = [testMortgage getMonthlyPayment] * 360;
    
    STAssertEqualsWithAccuracy(totalPayments - 75000.0, [testMortgage getTotalInterestPaid], .01, @"Total interest not equal");
}

- (void) testGetInterestPaidInYear {
    double expectedInterest = 3163.06;
    double expectedInterestYearThirty = 100.26;
    double expectedInterestYearFourty = 0.0;
    STAssertEqualsWithAccuracy(expectedInterest, [testMortgage getInterestPaidInYear:1], .01, @"Interests not equal for first year");
    STAssertEqualsWithAccuracy(expectedInterestYearThirty, [testMortgage getInterestPaidInYear:30], .01, @"Interest not equal for last year");
    STAssertEqualsWithAccuracy(expectedInterestYearFourty, [testMortgage getInterestPaidInYear:40], .01, @"Interest not equal after mortgage paid");
}

- (void) testGetPrincipalPaidInYear {
    double expectedPrincipal = 1264.4;
    double expectedPrincipalYearThirty = 4327.2;
    double expectedPrincipalYearFourty = 0.0;

    STAssertEqualsWithAccuracy(expectedPrincipal, [testMortgage getPrincipalPaidInYear:1], .01, @"Principal not equal for first year");
    STAssertEqualsWithAccuracy(expectedPrincipalYearThirty, [testMortgage getPrincipalPaidInYear:30], .01, @"Interest not equal for last year");
    STAssertEqualsWithAccuracy(expectedPrincipalYearFourty, [testMortgage getPrincipalPaidInYear:40], .01, @"Interest not equal for last year");
}

@end
