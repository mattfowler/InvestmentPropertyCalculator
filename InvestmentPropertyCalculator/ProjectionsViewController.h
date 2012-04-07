//
//  ProjectionsViewController.h
//  InvestmentPropertyCalculator
//
//  Created by Matt Fowler on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectionsViewController : UIViewController {
    @private
    UITableViewController* projectionsTableViewController;
}

@property (nonatomic, retain) IBOutlet UITableView* projectionsTableView;

@end
