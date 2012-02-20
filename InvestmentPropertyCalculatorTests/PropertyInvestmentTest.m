//
//  PropertyInvestmentTest.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PropertyInvestmentTest.h"

@implementation PropertyInvestmentTest

static const int MONTHLY_TAXES = 1000;
static const int MONTHLY_UTILITIES = 500;
static const int PROPERTY_COST = 100000;

-(void)setUp {
    testMortgage = [[Mortgage alloc] initWithSalesPrice:PROPERTY_COST downpayment:25.0 interestRate:4.25 years:30];
    propertyInvestment = [[PropertyInvestment alloc] init];
    propertyExpenses = [[PropertyExpenses alloc] init];
    propertyExpenses.taxes = MONTHLY_TAXES;
    propertyExpenses.utilities = MONTHLY_UTILITIES;
    [propertyInvestment setMortgage:testMortgage];
    [propertyInvestment setExpenses:propertyExpenses];
}

-(void)testGetNetOperatingIncome {
    propertyInvestment.grossIncome = 50000;
    
    int expectedNetIncome = 50000 - (testMortgage.getMonthlyPayment * 12) - (MONTHLY_TAXES + MONTHLY_UTILITIES) * 12;
    
    STAssertEquals(expectedNetIncome, [propertyInvestment getNetOperatingIncome], @"Net income not equal, should be 22427."); 
    
}

-(void) testGetCapRate {
    propertyInvestment.grossIncome = 50000;
    
    double expectedNetIncome = 50000 - (testMortgage.getMonthlyPayment * 12) - (MONTHLY_TAXES + MONTHLY_UTILITIES) * 12;
    
    double expectedCapRate = (expectedNetIncome / (double) PROPERTY_COST) * 100;
     
    STAssertEqualsWithAccuracy(expectedCapRate, [propertyInvestment getCapitalizationRate], .1, @"Cap rate not equal."); 
}


@end
