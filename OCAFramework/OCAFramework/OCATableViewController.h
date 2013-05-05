//
//  OCATableViewController.h
//  OCAFramework
//
//  Created by Wu Yanna on 12-4-8.
//  Copyright (c) 2012年 DP. All rights reserved.
//

#import "OCAViewController.h"

// Creates a table view with the correct dimensions and autoresizing, setting the datasource and delegate to self.
// In -viewWillAppear:, it reloads the table's data if it's empty. Otherwise, it deselects all rows (with or without animation) if clearsSelectionOnViewWillAppear is YES.
// In -viewDidAppear:, it flashes the table's scroll indicators.

@interface OCATableViewController : OCAViewController<UITableViewDelegate,UITableViewDataSource> {
    UITableViewStyle _tableViewStyle;
}

@property (nonatomic, retain)   UITableView *tableView;

@property(nonatomic) BOOL clearsSelectionOnViewWillAppear;

- (id)initWithStyle:(UITableViewStyle)style;

@end
