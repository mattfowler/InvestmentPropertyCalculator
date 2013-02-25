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

-(DollarValue*) getNetOperatingIncome {
    return [DollarValue createValue:[self.grossIncome getDollarValueForTimeInterval:Year].doubleValue - (mortgage.getMonthlyPayment.doubleValue * 12) - expenses.getYearlyExpenses.doubleValue - self.getVacancyLoss.doubleValue];
}

-(DollarValue *) getNetOperatingIncomeForYear:(int) year withAppreciationRate:(double) rate {
    double operatingIncome = self.getNetOperatingIncome.doubleValue;
    return [DollarValue createValue:[self getValue:operatingIncome afterYears:year withAppreciationRate:rate]];
}

-(Percent *) getCapitalizationRate {
    return [Percent create:self.getNetOperatingIncome.doubleValue / mortgage.salesPrice.doubleValue];
}

-(double) getCashOnCashReturn {
    return self.getNetOperatingIncome.doubleValue / mortgage.getDownpaymentAmount.doubleValue;
}

-(DollarValue *) getVacancyLoss {
    double vacancyLoss = [self.grossIncome getDollarValueForTimeInterval:Year].doubleValue * (expenses.vacancyRate/100);
    return [DollarValue createValue:-1.0 * vacancyLoss];
}

-(DollarValue *) getAfterTaxCashFlow {
    double taxableIncome = [self.grossIncome getDollarValueForTimeInterval:Year].doubleValue - [self getTaxDeductibleExpenseAmountForYear:1 withAppreciationRate:0.0].doubleValue - [mortgage getInterestPaidInYear:1].doubleValue;
    double taxRate = taxBracket/100;
    return [DollarValue createValue:self.getNetOperatingIncome.doubleValue - (taxableIncome * taxRate)];
}

-(double) getValue:(double)value afterYears:(int)years withAppreciationRate:(double)rate {
    return value * pow(1.0 + rate, years);
}

-(DollarValue *) getTaxDeductibleExpenseAmountForYear:(int)year withAppreciationRate:(double)rate {
    double expensesWithoutInflation = expenses.getYearlyExpenses.doubleValue + [self getPropertyDepreciationForYear:year].doubleValue;
    return [DollarValue createValue:[self getValue:expensesWithoutInflation afterYears:year withAppreciationRate:rate]];
}

-(DollarValue *)getPropertyDepreciationForYear:(int)year {
    if (year > STRAIGHTLINE_DEPRECIATION_YEARS) {
        return [DollarValue createValue:0.0];
    } else {
        double buildingValue = (mortgage.salesPrice.doubleValue * LAND_TO_PROPERTY_RATIO);
        return [DollarValue createValue: buildingValue / STRAIGHTLINE_DEPRECIATION_YEARS];
    }
}

-(DollarValue *) getPropertyAppreciationForYear:(int)year withAppreciationRate:(double)rate {
    double appreciatedValue = [self getValue:mortgage.salesPrice.doubleValue afterYears:year withAppreciationRate:rate];
    return [DollarValue createValue:appreciatedValue - mortgage.salesPrice.doubleValue];
}

-(DollarValue *) getAdditionToNetWorthAfterYear:(int)year withRentIncrease:(double)rentIncrease andPropertyAppreciationRate:(double)propertyAppreciationRate {
    double propertyAppreciation = [self getPropertyAppreciationForYear:year withAppreciationRate:propertyAppreciationRate].doubleValue;
    double totalPrincipalPaid = 0.0;
    
    for(int i = 1; i <= year; i++) {
        totalPrincipalPaid += [mortgage getPrincipalPaidInYear:i].doubleValue;
    }
    
    double totalCashFlow = 0.00;
    
    for(int i = 0; i < year; i++) {
        totalCashFlow += [self getNetOperatingIncomeForYear:i withAppreciationRate:rentIncrease].doubleValue;
    }
    
    return [DollarValue createValue:propertyAppreciation + totalPrincipalPaid + totalCashFlow];
    
}


@end
