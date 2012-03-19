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

static NSString* MORTGAGE_KEY = @"mortgage";
static NSString* EXPENSES_KEY = @"expenses";
static NSString* GROSS_INCOME_KEY = @"grossIncome";
static NSString* TAX_BRACKET_KEY = @"taxBracket";

-(id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.mortgage = [decoder decodeObjectForKey:MORTGAGE_KEY];
        self.expenses = [decoder decodeObjectForKey:EXPENSES_KEY];
        self.grossIncome = [decoder decodeIntForKey:GROSS_INCOME_KEY];
        self.taxBracket = [decoder decodeDoubleForKey:TAX_BRACKET_KEY];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:mortgage forKey:MORTGAGE_KEY];
    [coder encodeObject:expenses forKey:EXPENSES_KEY];
    [coder encodeInteger:grossIncome forKey:GROSS_INCOME_KEY];
    [coder encodeDouble:taxBracket forKey:TAX_BRACKET_KEY];
}

-(int) getNetOperatingIncome {
    return grossIncome - (mortgage.getMonthlyPayment * 12) - (expenses.getMonthlyExpenses * 12);
}

-(double) getCapitalizationRate {
    return (double)self.getNetOperatingIncome / (double)mortgage.salesPrice;
}

-(double) getCashOnCashReturn {
    return (double) self.getNetOperatingIncome / (double) mortgage.getDownpaymentAmount;
}

-(double) getVacancyLoss {
    return self.grossIncome * (expenses.vacancyRate/100);
}

-(int) getAfterTaxCashFlow {
    int taxableIncome = self.grossIncome - [self getTaxDeductibleExpenseAmountForYear:1 withInflationRate:0.0] - [mortgage getInterestPaidInYear:1];
    double taxRate = taxBracket/100;
    return self.getNetOperatingIncome - (taxableIncome * taxRate);
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
