//
//  ZipManager.h
//  ZipSampleiOS
//
//  Created by Admin on 05/08/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipArchive.h"

@interface ZipManager : NSObject

- (NSString*) createZipArchiveWithFiles:(NSArray*)files andPassword:(NSString*)password;
- (NSString*) unZipArchiveWithPassword:(NSString*)password;
- (NSString*) unZipJsonFile:(NSString*)fileName;
@end
