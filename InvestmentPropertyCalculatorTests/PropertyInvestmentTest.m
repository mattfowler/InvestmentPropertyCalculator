//
//  PropertyInvestmentTest.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PropertyInvestmentTest.h"
#import "DollarValueForInterval.h"

@implementation PropertyInvestmentTest

static const int YEARLY_TAXES = 1000;
static const int YEARLY_UTILITIES = 500;
static const int EXPENSES_FIRST_YEAR = YEARLY_TAXES + YEARLY_UTILITIES;
static const double DEPRECIATION_YEARS = 27.5;

DollarValue *PROPERTY_COST = nil;

+(void)initialize {
    if(!PROPERTY_COST) {
        PROPERTY_COST = [DollarValue createValue:100000];
    }
}

-(void)setUp {
    testMortgage = [[Mortgage alloc] initWithSalesPrice:PROPERTY_COST downpayment:25.0 interestRate:4.25 years:30];
    propertyInvestment = [[PropertyInvestment alloc] init];
    propertyExpenses = [[PropertyExpenses alloc] init];
    propertyExpenses.taxes = [DollarValueForInterval createValue:YEARLY_TAXES forTimeInterval:Year];
    propertyExpenses.utilities = [DollarValueForInterval createValue:YEARLY_UTILITIES forTimeInterval:Year];
    [propertyInvestment setMortgage:testMortgage];
    [propertyInvestment setExpenses:propertyExpenses];
}

-(void)testGetNetOperatingIncome {
    propertyInvestment.grossIncome = [DollarValueForInterval createValue:50000 forTimeInterval:Year];
    
    double expectedNetIncome = 50000 - (testMortgage.getMonthlyPayment.doubleValue * 12) - EXPENSES_FIRST_YEAR;
    
    STAssertEquals(expectedNetIncome, propertyInvestment.getNetOperatingIncome.doubleValue, @"Net income not equal, should be 22427.");
    
}

-(void) testGetCapRate {
    propertyInvestment.grossIncome =  [DollarValueForInterval createValue:50000 forTimeInterval:Year];
    
    double expectedNetIncome = 50000 - (testMortgage.getMonthlyPayment.doubleValue * 12) - EXPENSES_FIRST_YEAR;
    
    double expectedCapRate = (expectedNetIncome / PROPERTY_COST.doubleValue);
     
    STAssertEqualsWithAccuracy(expectedCapRate, [propertyInvestment getCapitalizationRate], .1, @"Cap rate not equal."); 
}

-(void) testGetCashOnCashReturn {
    propertyInvestment.grossIncome = [DollarValueForInterval createValue:50000 forTimeInterval:Year];
    
    double expectedNetIncome = 50000 - (testMortgage.getMonthlyPayment.doubleValue * 12) - EXPENSES_FIRST_YEAR;
    
    double expectedReturn =  expectedNetIncome / 25000.0;
    
    STAssertEqualsWithAccuracy(expectedReturn, [propertyInvestment getCashOnCashReturn], .1, @"Cash returns not equal"); 

}

-(void) testGetPropertyDepreciatonForYear {
    double landFactor = .5;    
    double expectedDepreciation = (PROPERTY_COST.doubleValue * landFactor) / DEPRECIATION_YEARS;
    
    STAssertEqualsWithAccuracy(expectedDepreciation, [propertyInvestment getPropertyDepreciationForYear:5].doubleValue, .01, @"Depreciation within 27.5 years not equal");
    
    STAssertEqualsWithAccuracy(0.00, [propertyInvestment getPropertyDepreciationForYear:50].doubleValue, .01, @"Depreciation after 27.5 years should be equal");
}

-(void) testGetTaxDeductibleExpensesForYear {
    double landFactor = .5;
    double expectedDepreciationFirstYear = (PROPERTY_COST.doubleValue * landFactor) / DEPRECIATION_YEARS;
    
    double expectedTaxDeductibleExpensesFirstYear = EXPENSES_FIRST_YEAR + expectedDepreciationFirstYear;
    
    STAssertEqualsWithAccuracy(expectedTaxDeductibleExpensesFirstYear, [propertyInvestment getTaxDeductibleExpenseAmountForYear:1 withAppreciationRate:0.00].doubleValue, .01, @"Tax deductible amounts for year one not equal.");
    
    double inflationRate = .05;
    int yearsInFuture = 10;
    double expectedExpensesTenthYear = expectedTaxDeductibleExpensesFirstYear * pow(1.0 + inflationRate, yearsInFuture);
    
    STAssertEqualsWithAccuracy(expectedExpensesTenthYear, [propertyInvestment getTaxDeductibleExpenseAmountForYear:yearsInFuture withAppreciationRate:inflationRate].doubleValue, .01, @"Tax deductible amounts for ten years with an inflation rate not equal");
}

-(void) testGetAfterTaxCashFlow {
    propertyInvestment.taxBracket = 25.0;
    propertyInvestment.grossIncome = [DollarValueForInterval createValue:50000 forTimeInterval:Year];
    double landFactor = .5;
    double expectedDepreciationFirstYear = (PROPERTY_COST.doubleValue * landFactor) / DEPRECIATION_YEARS;
    double expectedTaxDeductibleExpensesFirstYear = EXPENSES_FIRST_YEAR + expectedDepreciationFirstYear;

    double expectedTaxDue = ([propertyInvestment.grossIncome getDollarValueForTimeInterval:Year].doubleValue - expectedTaxDeductibleExpensesFirstYear - [testMortgage getInterestPaidInYear:1]) * .25;
    double expectedCashFlow = propertyInvestment.getNetOperatingIncome.doubleValue - expectedTaxDue;
    STAssertEqualsWithAccuracy(expectedCashFlow, propertyInvestment.getAfterTaxCashFlow.doubleValue, .1, @"After tax cash flows not equal.");
}

-(void) testGetAfterTaxCashFlowWithTaxDeduction {
    propertyInvestment.taxBracket = 25.0;
    propertyInvestment.grossIncome = [DollarValueForInterval createValue:10000 forTimeInterval:Year];
    double landFactor = .5;
    double expectedDepreciationFirstYear = (PROPERTY_COST.doubleValue * landFactor) / DEPRECIATION_YEARS;
    double expectedTaxDeductibleExpensesFirstYear = EXPENSES_FIRST_YEAR + expectedDepreciationFirstYear + [testMortgage getInterestPaidInYear:1];
    double expectedDeduction = expectedTaxDeductibleExpensesFirstYear - [propertyInvestment.grossIncome getDollarValueForTimeInterval:Year].doubleValue;
    double expectedCashFlow = propertyInvestment.getNetOperatingIncome.doubleValue + (expectedDeduction *.25);
    STAssertEqualsWithAccuracy(expectedCashFlow, propertyInvestment.getAfterTaxCashFlow.doubleValue, .1, @"After tax cash flows not equal.");
}

-(void) testGetVacancyRateLoss {
    propertyInvestment.grossIncome = [DollarValueForInterval createValue:10000 forTimeInterval:Year];
    [propertyExpenses setVacancyRate:1.0];
    STAssertEqualsWithAccuracy(-10000.0 * .01, propertyInvestment.getVacancyLoss.doubleValue, .1, @"Vacancy losses not equal");
}

-(void) testPropertyAppreciation {
    double appreciationYearZero = [propertyInvestment getPropertyAppreciationForYear:0 withAppreciationRate:.05];
    double appreciationYearOne = [propertyInvestment getPropertyAppreciationForYear:1 withAppreciationRate:.05];
    double appreciationYearTen = [propertyInvestment getPropertyAppreciationForYear:10 withAppreciationRate:.05];
    
    STAssertEqualsWithAccuracy(0.0, appreciationYearZero, .1, @"Appreciation not equal");
    STAssertEqualsWithAccuracy(5000.0, appreciationYearOne, .1, @"Appreciation not equal");
    STAssertEqualsWithAccuracy(62889.46, appreciationYearTen, .1, @"Appreciation not equal");
}

-(void) testGetNetWorthAfterYears {
    double netWorthYearZero = [propertyInvestment getAdditionToNetWorthAfterYear:0 
                                                                withRentIncrease:.05 
                                                     andPropertyAppreciationRate:.05];
    
    STAssertEqualsWithAccuracy(0.0, netWorthYearZero, .1, @"net worth not equal");
    
    double netWorthYearOne = [propertyInvestment getAdditionToNetWorthAfterYear:1 
                                                               withRentIncrease:.05 
                                                    andPropertyAppreciationRate:.05];
    
    double appreciationYearOne = [propertyInvestment getPropertyAppreciationForYear:1 withAppreciationRate:.05];
    double netIncomeYearOne = [propertyInvestment getNetOperatingIncomeForYear:0 withAppreciationRate:.05];
    double principalPaidYearOne = [propertyInvestment.mortgage getPrincipalPaidInYear:1];
    
    STAssertEqualsWithAccuracy(principalPaidYearOne + netIncomeYearOne +  appreciationYearOne, netWorthYearOne, .1, @"net worth not equal");
    
    double netWorthYearTwo = [propertyInvestment getAdditionToNetWorthAfterYear:2 
                                                               withRentIncrease:.05 
                                                    andPropertyAppreciationRate:.05];
    
    double appreciationYearTwo = [propertyInvestment getPropertyAppreciationForYear:2 withAppreciationRate:.05];
    double netIncomeYearTwo = [propertyInvestment getNetOperatingIncomeForYear:0 withAppreciationRate:.05] + [propertyInvestment getNetOperatingIncomeForYear:1 withAppreciationRate:.05];
    double principalPaidYearTwo = [propertyInvestment.mortgage getPrincipalPaidInYear:1] + [propertyInvestment.mortgage getPrincipalPaidInYear:2];
    
    STAssertEqualsWithAccuracy(principalPaidYearTwo + netIncomeYearTwo +  appreciationYearTwo, netWorthYearTwo, .1, @"net worth not equal");
    
}

@end
