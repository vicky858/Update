//
//  PatientDetails.h
//  SplitViewController
//
//  Created by vignesh on 9/12/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientDetails : NSObject

@property (strong, nonatomic) NSNumber  *patientID;
@property (strong, nonatomic) NSString  *usrImg;
@property (strong, nonatomic) NSString  *usrName;
@property (strong, nonatomic) NSString  *gender;
@property (strong, nonatomic) NSString  *age;
@property (strong, nonatomic) NSString  *mailId;
@property (strong, nonatomic) NSString  *primayContactNo;
@property (strong, nonatomic) NSString  *secondaryContactNo;
@property (strong, nonatomic) NSString  *language;
@property (strong, nonatomic) NSString  *financialClass;
@property (strong, nonatomic) NSString  *financialPayer;
@property (strong, nonatomic) NSString  *nextAppointmentDate;
@property (strong, nonatomic) NSString  *appDocName;
@property (strong, nonatomic) NSString  *lastAppDate;
@property (strong, nonatomic) NSString  *lastVisit;
@property (strong, nonatomic) NSString  *transportation;
@property (strong, nonatomic) NSString  *refDoc;
@property (strong, nonatomic) NSString  *lastSeenDoc;
@property (strong, nonatomic) NSString  *LastVisitDocAdd;
@property (strong, nonatomic) NSString  *diagonises;
@property (strong, nonatomic) NSString  *diganosesDate;
@property (strong, nonatomic) NSString  *allergies;
@property (strong, nonatomic) NSString  *perfPharmacy;

@end
