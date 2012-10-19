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

@synthesize propertyName;
@synthesize mortgage;
@synthesize expenses;
@synthesize grossIncome;
@synthesize taxBracket;

static NSString* PROPERTY_NAME_KEY = @"propertyName";
static NSString* MORTGAGE_KEY = @"mortgage";
static NSString* EXPENSES_KEY = @"expenses";
static NSString* GROSS_INCOME_KEY = @"grossIncome";
static NSString* TAX_BRACKET_KEY = @"taxBracket";

-(id) initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.propertyName = [decoder decodeObjectForKey:PROPERTY_NAME_KEY];
        self.mortgage = [decoder decodeObjectForKey:MORTGAGE_KEY];
        self.expenses = [decoder decodeObjectForKey:EXPENSES_KEY];
        self.grossIncome = [decoder decodeObjectForKey:GROSS_INCOME_KEY];
        self.taxBracket = [decoder decodeDoubleForKey:TAX_BRACKET_KEY];
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:propertyName forKey:PROPERTY_NAME_KEY];
    [coder encodeObject:mortgage forKey:MORTGAGE_KEY];
    [coder encodeObject:expenses forKey:EXPENSES_KEY];
    [coder encodeObject:grossIncome forKey:GROSS_INCOME_KEY];
    [coder encodeDouble:taxBracket forKey:TAX_BRACKET_KEY];
}

-(int) getNetOperatingIncome {
    return [self.grossIncome getValueForTimeInterval:Year] - (mortgage.getMonthlyPayment * 12) - expenses.getYearlyExpenses - self.getVacancyLoss;
}

-(int) getNetOperatingIncomeForYear:(int) year withAppreciationRate:(double) rate {
    int operatingIncome = self.getNetOperatingIncome;
    return [self getValue:operatingIncome afterYears:year withAppreciationRate:rate];
}

-(double) getCapitalizationRate {
    return (double)self.getNetOperatingIncome / (double)mortgage.salesPrice;
}

-(double) getCashOnCashReturn {
    return (double) self.getNetOperatingIncome / (double) mortgage.getDownpaymentAmount;
}

-(double) getVacancyLoss {
    return [self.grossIncome getValueForTimeInterval:Year] * (expenses.vacancyRate/100);
}

-(int) getAfterTaxCashFlow {
    int taxableIncome = [self.grossIncome getValueForTimeInterval:Year] - [self getTaxDeductibleExpenseAmountForYear:1 withAppreciationRate:0.0] - [mortgage getInterestPaidInYear:1];
    double taxRate = taxBracket/100;
    return self.getNetOperatingIncome - (taxableIncome * taxRate);
}

-(double) getValue:(double)value afterYears:(int)years withAppreciationRate:(double)rate {
    return value * pow(1.0 + rate, years);
}

-(double) getTaxDeductibleExpenseAmountForYear:(int)year withAppreciationRate:(double)rate {
    double expensesWithoutInflation = expenses.getYearlyExpenses + [self getPropertyDepreciatonForYear:year];
    return [self getValue:expensesWithoutInflation afterYears: year withAppreciationRate:rate];
}

-(double) getPropertyDepreciatonForYear:(int)year {
    double depreciationPerYear =  (mortgage.salesPrice * LAND_TO_PROPERTY_RATIO) / STRAIGHTLINE_DEPRECIATION_YEARS;
    if (year > STRAIGHTLINE_DEPRECIATION_YEARS) {
        return 0.00;
    } else {
        return depreciationPerYear;
    }
}

-(double) getPropertyAppreciationForYear:(int)year withAppreciationRate:(double)rate {
    double appreciatedValue = [self getValue:mortgage.salesPrice afterYears:year withAppreciationRate:rate];
    return appreciatedValue - (double)mortgage.salesPrice;
}

-(double) getAdditionToNetWorthAfterYear:(int)year withRentIncrease:(double)rentIncrease andPropertyAppreciationRate:(double)propertyAppreciationRate {
    double propertyAppreciation = [self getPropertyAppreciationForYear:year withAppreciationRate:propertyAppreciationRate];
    double totalPrincipalPaid = 0.0;
    
    for(int i = 1; i <= year; i++) {
        totalPrincipalPaid += [mortgage getPrincipalPaidInYear:i];
    }
    
    double totalCashFlow = 0.00;
    
    for(int i = 0; i < year; i++) {
        totalCashFlow += [self getNetOperatingIncomeForYear:i withAppreciationRate:rentIncrease];
    }
    
    return propertyAppreciation + totalPrincipalPaid + totalCashFlow;
    
}


@end
