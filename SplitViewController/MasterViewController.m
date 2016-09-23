//
//  MasterViewController.m
//  SplitViewController
//
//  Created by vignesh on 9/8/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "PatientDetails.h"
#import "MyTableViewCell.h"
#import "SQLiteManager.h"
#import "FMResultSet.h"
#import "AppDelegate.h"

@interface MasterViewController ()
{
    PatientDetails *patientObj;
    
    
    
}
@property NSMutableArray *objects;
@property SQLiteManager *sqlManager;


@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    _patientList = [[NSMutableArray alloc]init];
    
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}



- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    [self getPatientDetails];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getPatientDetails{
    [_patientList removeAllObjects];
    _sqlManager = [[SQLiteManager alloc] init];
    [_sqlManager createDatabaseIfNeeded];
    //fetch only male :
    //FMResultSet *resultSet = [_sqlManager ExecuteQuery:@"SELECT * FROM PatientDetails where Gender = "Male""];
    [_sqlManager OpenDB:[_sqlManager GetDBPath]];
    FMResultSet *resultSet = [_sqlManager ExecuteQuery:@"SELECT * FROM PatientDetails"];
    while ([resultSet next]) {
        patientObj = [[PatientDetails alloc]init];
        patientObj.patientID = [NSNumber numberWithInt:[resultSet intForColumn:@"PatientID"]];
        patientObj.usrImg = [resultSet stringForColumn:@"UserImage"];
        patientObj.usrName = [resultSet stringForColumn:@"UserName"];
        patientObj.gender = [resultSet stringForColumn:@"Gender"];
        patientObj.age = [resultSet stringForColumn:@"Age"];
        patientObj.mailId= [resultSet stringForColumn:@"EmailID"];
        patientObj.primayContactNo= [resultSet stringForColumn:@"PhoneNo"];
        patientObj.secondaryContactNo= [resultSet stringForColumn:@"MobileNo"];
        patientObj.language=[resultSet stringForColumn:@"Language"];
        patientObj.financialClass= [resultSet stringForColumn:@"FinicialClass"];
        patientObj.financialPayer= [resultSet stringForColumn:@"FinicalPayer"];
        patientObj.nextAppointmentDate = [resultSet stringForColumn:@"AppoinmentDate"];
        patientObj.appDocName = [resultSet stringForColumn:@"ApponimentDoctorName"];
        patientObj.lastAppDate = [resultSet stringForColumn:@"LastApponimentDate"];
        patientObj.lastVisit = [resultSet stringForColumn:@"ApponimentPlace"];
        patientObj.transportation = [resultSet stringForColumn:@"Transportation"];
        patientObj.refDoc =[resultSet stringForColumn:@"RefreredDoctor"];
        patientObj.lastSeenDoc=[resultSet stringForColumn:@"LastSeenDoctor"];
        patientObj.LastVisitDocAdd = [resultSet stringForColumn:@"LastSeenDoctorPlace"];
        patientObj.diagonises = [resultSet stringForColumn:@"Diagonses"];
        patientObj.diganosesDate =[resultSet stringForColumn:@"DiagonsesDate"];
        patientObj.allergies = [resultSet stringForColumn:@"Alleriges"];
        patientObj.perfPharmacy = [resultSet stringForColumn:@"PharamacyName"];
        [_patientList addObject:patientObj];
    }
    [resultSet close];
    [self.tableView reloadData];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    ([[segue identifier] isEqualToString:@"showDetail"]&& sender == nil); {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if(_patientList.count == 0){
            [self getPatientDetails];
        }
        if(_patientList.count>0){
            
            patientObj = _patientList[indexPath.row];
            DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
            [controller setPatientList:_patientList];
            [controller setPatDetails:patientObj];
        }
    }
}

#pragma mark - Table View


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    int count = [self.patientList count];
    if(self.editing) count++;
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MyTableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
   
    patientObj = _patientList[indexPath.row];
    
    UIImage *cellImage = [UIImage imageNamed:patientObj.usrImg];
    cell.imgView.image = cellImage;
    
    cell.imgView.backgroundColor = [UIColor colorWithRed:(20.0f/255.0f) green:(173.0f/255.0f) blue:(199.0f/255.0f) alpha:1.0];
    cell.imgView.layer.masksToBounds = YES;
    cell.imgView.layer.cornerRadius = 32.0f;
    
    cell.nameLbl.text = patientObj.usrName;
    cell.nameLbl.font = [UIFont boldSystemFontOfSize:14.0f];
    cell.nameLbl.textColor= [UIColor colorWithRed:(10.0f/255.0f) green:(173.0f/255.0f) blue:(193.0f/255.0f) alpha:1.0];
    cell.ageLbl.text=[NSString stringWithFormat:@"%@ Years old",patientObj.age];
    cell.genderLbl.text=patientObj.gender;
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        [self performSegueWithIdentifier:@"showDetail" sender:nil];
        self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
        UINavigationController *navigationController = [self.splitViewController.viewControllers lastObject];
        navigationController.topViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
    UINavigationController *navigationController = [self.splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
}
- (IBAction)syncBtn:(id)sender {
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate SyncView];
}
@end
