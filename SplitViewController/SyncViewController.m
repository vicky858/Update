//
//  SyncViewController.m
//  SplitViewController
//
//  Created by vignesh on 9/22/16.
//  Copyright © 2016 vignesh. All rights reserved.


#import "SyncViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "SQLiteManager.h"
#import "ZipManager.h"

@interface SyncViewController ()

@end

@implementation SyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionBtn:(id)sender {
    /*
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer = responseSerializer;
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];


    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/zip",nil];

    [manager GET:@"http://192.168.0.52/~Ram/PatientDetails.zip" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON Data: %@", responseObject);
        
        [self updateSQLiteDB:responseObject];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
*/
    

    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://192.168.0.52/~Ram/PatientDetails.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        ZipManager *zipManagerObj = [[ZipManager alloc] init];
        NSString *jsonFilePath = [zipManagerObj unZipJsonFile:[response suggestedFilename]];
        if(jsonFilePath!=nil){
            NSData* data = [NSData dataWithContentsOfFile:jsonFilePath];
            NSError* jsonerror = nil;
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:kNilOptions error:&jsonerror];
            [self updateSQLiteDB:responseObject];
        }
    }];
    [downloadTask resume];
    
    /*
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSURL *URL = [NSURL URLWithString:@"http://192.168.0.52/~Ram/PatientDetails.zip"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"NSURLResponse : %@", response);
            
            NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"Response : %@", str);
            NSError *localError = nil;

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&localError];
            
            NSLog(@"Response : %@", dic);
            
            
        }
    }];
    [dataTask resume];
    */
}

//-(void)createPatientTable{
//    
//    SQLiteManager *sqlManager = [[SQLiteManager alloc] init];
//    [sqlManager createDatabaseIfNeeded];
//    //[sqlManager OpenDB:[sqlManager GetDBPath]];
//    NSLog(@"DB Status : %d",[[NSFileManager defaultManager] fileExistsAtPath:[sqlManager GetDBPath]]);
//     FMResultSet *resultSet = [sqlManager ExecuteQuery:@"CREATE TABLE IF NOT EXISTS PatientDetails (PatientID INTEGER PRIMARY KEY, UserName TEXT, Gender TEXT, UserImage TEXT, Age TEXT, EmailID TEXT, PhoneNo TEXT, MobileNo TEXT, Language TEXT, FinicialClass TEXT, FinicalPayer TEXT, AppoinmentDate TEXT, ApponimentDoctorName TEXT, LastApponimentDate TEXT, ApponimentPlace TEXT, Transportation TEXT, RefreredDoctor TEXT, LastSeenDoctor TEXT, LastSeenDoctorPlace TEXT, Diagonses TEXT, DiagonsesDate TEXT, Alleriges TEXT, PharamacyName TEXT)"];
//    NSLog(@"%@",resultSet);
//    [resultSet close];
//}



-(void)updateSQLiteDB:(NSDictionary*)responseObject{
//    [self createPatientTable];
    SQLiteManager *sqlManager = [[SQLiteManager alloc] init];
    [sqlManager createDatabaseIfNeeded];
//    [sqlManager OpenDB:[sqlManager GetDBPath]];
    
    NSArray *patientList = [responseObject objectForKey:@"Patients"];
    for(NSDictionary *patientDic in patientList){
        
        NSMutableArray *values = [[NSMutableArray alloc] init];
        NSNumber *patientID = (NSNumber*)[patientDic objectForKey:@"PatientID"];
       
            
            [values addObject:[patientDic objectForKey:@"UserName"]];
            [values addObject:[patientDic objectForKey:@"Gender"]];
            [values addObject:[patientDic objectForKey:@"UserImage"]];
            [values addObject:[patientDic objectForKey:@"Age"]];
            [values addObject:[patientDic objectForKey:@"EmailID"]];
            [values addObject:[patientDic objectForKey:@"PhoneNo"]];
            [values addObject:[patientDic objectForKey:@"MobileNo"]];
            [values addObject:[patientDic objectForKey:@"Language"]];
            [values addObject:[patientDic objectForKey:@"FinicialClass"]];
            [values addObject:[patientDic objectForKey:@"FinicalPayer"]];
            [values addObject:[patientDic objectForKey:@"AppoinmentDate"]];
            [values addObject:[patientDic objectForKey:@"ApponimentDoctorName"]];
            [values addObject:[patientDic objectForKey:@"LastApponimentDate"]];
            [values addObject:[patientDic objectForKey:@"ApponimentPlace"]];
            [values addObject:[patientDic objectForKey:@"Transportation"]];
            [values addObject:[patientDic objectForKey:@"RefreredDoctor"]];
            [values addObject:[patientDic objectForKey:@"LastSeenDoctor"]];
            [values addObject:[patientDic objectForKey:@"LastSeenDoctorPlace"]];
            [values addObject:[patientDic objectForKey:@"Diagonses"]];
            [values addObject:[patientDic objectForKey:@"DiagonsesDate"]];
            [values addObject:[patientDic objectForKey:@"Alleriges"]];
            [values addObject:[patientDic objectForKey:@"PharamacyName"]];
            [values addObject:patientID];
            
            BOOL isUpdated = [sqlManager ExecuteInsertQuery:@"UPDATE PatientDetails set UserName= ?, Gender= ?, UserImage=?, Age= ?, EmailID= ?, PhoneNo= ?, MobileNo= ?, Language= ?, FinicialClass= ?, FinicalPayer= ?, AppoinmentDate= ?, ApponimentDoctorName= ?, LastApponimentDate= ?, ApponimentPlace= ?, Transportation= ?, RefreredDoctor= ?, LastSeenDoctor= ?, LastSeenDoctorPlace= ?, Diagonses= ?, DiagonsesDate= ?, Alleriges= ?, PharamacyName= ? where PatientID= ?" withCollectionOfValues:values];
        
        NSLog(@"isUpdated : %d",isUpdated);
    }
    
}


@end


























