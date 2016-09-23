//
//  DetailViewController.h
//  SplitViewController
//
//  Created by vignesh on 9/8/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Charts/Charts.h>
#import "PatientDetails.h"

@interface DetailViewController : UIViewController<UITextViewDelegate, UITextFieldDelegate>{
    BOOL editMode;

}
@property (strong, nonatomic) NSMutableArray* patientList;
@property (strong, nonatomic) PatientDetails* patDetails;
@property (strong, nonatomic) IBOutlet UIImageView *usrImg;
@property (strong, nonatomic) IBOutlet UITextField *usrName;
@property (strong, nonatomic) IBOutlet UITextField *gender;
@property (strong, nonatomic) IBOutlet UITextField *age;
@property (strong, nonatomic) IBOutlet UITextField *mailId;
@property (strong, nonatomic) IBOutlet UITextField *primayContactNo;
@property (strong, nonatomic) IBOutlet UITextField *secondaryContactNo;
@property (strong, nonatomic) IBOutlet UITextField *language;
@property (strong, nonatomic) IBOutlet UITextField *financialClass;
@property (strong, nonatomic) IBOutlet UITextField *financialPayer;
@property (strong, nonatomic) IBOutlet UITextField *nextAppointmentDate;
@property (strong, nonatomic) IBOutlet UITextField *appDocName;
@property (strong, nonatomic) IBOutlet UITextField *lastAppDate;
@property (strong, nonatomic) IBOutlet UITextField *lastVisit;
@property (strong, nonatomic) IBOutlet UITextField *transportation;
@property (strong, nonatomic) IBOutlet UITextField *refDoc;
@property (strong, nonatomic) IBOutlet UITextField *lastSeenDoc;
@property (strong, nonatomic) IBOutlet UITextField *LastVisitDocAdd;
@property (strong, nonatomic) IBOutlet UITextField *diagonises;
@property (strong, nonatomic) IBOutlet UITextField *diganosesDate;
@property (strong, nonatomic) IBOutlet UITextField *allergies;
@property (strong, nonatomic) IBOutlet UITextView *perfPharmacy;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBtn;
@property (strong, nonatomic) IBOutlet UIButton *insertSaveBtn;

-(IBAction)editAction:(id)sender;
@end

