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
    
    double expectedCapRate = (expectedNetIncome / (double) PROPERTY_COST);
     
    STAssertEqualsWithAccuracy(expectedCapRate, [propertyInvestment getCapitalizationRate], .1, @"Cap rate not equal."); 
}

-(void) testGetCashOnCashReturn {
    propertyInvestment.grossIncome = 50000;
    
    double expectedNetIncome = 50000 - (testMortgage.getMonthlyPayment * 12) - (MONTHLY_TAXES + MONTHLY_UTILITIES) * 12;
    
    double expectedReturn =  expectedNetIncome / 25000.0;
    
    STAssertEqualsWithAccuracy(expectedReturn, [propertyInvestment getCashOnCashReturn], .1, @"Cash returns not equal"); 

}

-(void) testGetPropertyDepreciatonForYear {
    double landFactor = .5;
    double depreciationYears = 27.5;
    
    double expectedDepreciation = ((double)PROPERTY_COST * landFactor) / depreciationYears;
    
    STAssertEqualsWithAccuracy(expectedDepreciation, [propertyInvestment getPropertyDepreciatonForYear:5], .01, @"Depreciation within 27.5 years not equal");
    
    STAssertEqualsWithAccuracy(0.00, [propertyInvestment getPropertyDepreciatonForYear:50], .01, @"Depreciation after 27.5 years should be equal");
}

-(void) testGetTaxDeductibleExpensesForYear {
    double expectedExpensesFirstYear = MONTHLY_TAXES * 12 + MONTHLY_UTILITIES * 12;
    double landFactor = .5;
    double depreciationYears = 27.5;
    double expectedDepreciationFirstYear = ((double)PROPERTY_COST * landFactor) / depreciationYears;
    
    double expectedTaxDeductibleExpensesFirstYear = expectedExpensesFirstYear + expectedDepreciationFirstYear;
    
    STAssertEqualsWithAccuracy(expectedTaxDeductibleExpensesFirstYear, [propertyInvestment getTaxDeductibleExpenseAmountForYear:1 withInflationRate:0.00], .01, @"Tax deductible amounts for year one not equal.");
    
    double inflationRate = .05;
    int yearsInFuture = 10;
    double expectedExpensesTenthYear = expectedTaxDeductibleExpensesFirstYear * pow(1.0 + inflationRate, yearsInFuture);
    
    STAssertEqualsWithAccuracy(expectedExpensesTenthYear, [propertyInvestment getTaxDeductibleExpenseAmountForYear:yearsInFuture 
                                                                              withInflationRate:inflationRate], 
                               .01, @"Tax deductible amounts for ten years with an inflation rate not equal");
    
}

@end
