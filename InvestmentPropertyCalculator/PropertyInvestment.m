//
//  PropertyInvestment.m
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PropertyInvestment.h"

@implementation PropertyInvestment

static const double STRAIGHTLINE_DEPRECIATION_YEARS = 27.5;
static const double LAND_TO_PROPERTY_RATIO = .5;

@synthesize mortgage;
@synthesize expenses;
@synthesize grossIncome;

@synthesize taxBracket;

-(int) getNetOperatingIncome {
    return grossIncome - mortgage.getMonthlyPayment * 12 - expenses.getMonthlyExpenses * 12;
}

-(double) getCapitalizationRate {
    return (double)self.getNetOperatingIncome / (double)mortgage.salesPrice;
}

-(double) getCashOnCashReturn {
    return (double) self.getNetOperatingIncome / (double) mortgage.getDownpaymentAmount;
}

-(double) getValue:(double)value afterYears:(int)years withInflationRate:(double)rate {
    return value * pow(1.0 + rate, years);
}

-(double) getTaxDeductibleExpenseAmountForYear:(int)year withInflationRate:(double)rate {
    double expensesWithoutInflation = [expenses getMonthlyExpenses] * 12.0 + [self getPropertyDepreciatonForYear:year];
    return [self getValue:expensesWithoutInflation afterYears: year withInflationRate:rate];
}

-(double) getPropertyDepreciatonForYear:(int)year {
    double depreciationPerYear =  (mortgage.salesPrice * LAND_TO_PROPERTY_RATIO) / STRAIGHTLINE_DEPRECIATION_YEARS;
    if (year > STRAIGHTLINE_DEPRECIATION_YEARS) {
        return 0.00;
    } else {
        return depreciationPerYear;
    }
}


@end
