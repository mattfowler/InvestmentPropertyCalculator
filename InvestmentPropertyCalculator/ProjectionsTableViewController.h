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
    YearlyAddtionToNetWorth,
    TotalAdditionToNetWorth
} ProjectionType;

@interface ProjectionsTableViewController : UITableViewController

@end
