//
//  PropertyInvestment.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mortgage.h"
#import "PropertyExpenses.h"
#import "Percent.h"

@interface PropertyInvestment : NSObject <NSCoding>

@property (nonatomic, retain) NSString *propertyName;
@property (nonatomic, retain) Mortgage *mortgage;
@property (nonatomic, retain) PropertyExpenses *expenses;

@property (nonatomic, retain) DollarValueForInterval* grossIncome;
@property double taxBracket;

-(DollarValue *) getNetOperatingIncome;
-(DollarValue *) getNetOperatingIncomeForYear:(int) year withAppreciationRate:(double) rate;

-(Percent *) getCapitalizationRate;
-(Percent *) getCashOnCashReturn;
-(DollarValue *) getVacancyLoss;

-(DollarValue *) getAfterTaxCashFlow;
-(DollarValue *) getTaxDeductibleExpenseAmountForYear:(int)year withAppreciationRate:(double)rate;
-(DollarValue *) getPropertyDepreciationForYear:(int)year;
-(DollarValue *) getPropertyAppreciationForYear:(int)year withAppreciationRate:(double)rate;
-(DollarValue *) getAdditionToNetWorthAfterYear:(int)year withRentIncrease:(double)rentIncrease andPropertyAppreciationRate:(double)propertyAppreciationRate;
@end
