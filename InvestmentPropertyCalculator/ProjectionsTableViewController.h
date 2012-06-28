//
//  ProjectionsTableViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GrossIncome = 0,
    NetIncome,
    PrincipalPaid,
    PropertyAppreciation,
    TotalAdditionToNetWorth
} ProjectionType;

@interface ProjectionsTableViewController : UITableViewController

-(void) updateTableWithRentIncrease:(double) rentIncreasePercent andAppreciationRate:(double) appreciationRate;

@end
