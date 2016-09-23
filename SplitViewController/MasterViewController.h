//
//  MasterViewController.h
//  SplitViewController
//
//  Created by vignesh on 9/8/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <UIKit/UIKit.h>



@class DetailViewController;

@interface MasterViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>



@property (nonatomic, strong) NSMutableArray *patientList;

@property (strong, nonatomic) DetailViewController *detailViewController;

- (IBAction)syncBtn:(id)sender;


@end

