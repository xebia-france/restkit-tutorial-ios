//
//  AppDelegate.m
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 10/28/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "AppDelegate.h"
#import <RestKit/RestKit.h>
#import "NSDateFormatter+XBAdditions.h"
#import "GHRepository.h"
#import "GHUser.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initializeLoggers];
    [self initializeRestKit];

    return YES;
}

- (void)initializeLoggers {
    //  RKLogConfigureByName("RestKit/*", RKLogLevelWarning);
     RKLogConfigureByName("RestKit/UI", RKLogLevelWarning);
     RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
     RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelWarning);
     RKLogConfigureByName("RestKit/ObjectMapping/JSON", RKLogLevelWarning);
}

-(void)initializeRestKit {
    [self initializeObjectManager];
    [self initializeObjectMapping];
}

- (void)initializeObjectManager {
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURLString:@"https://api.github.com/"];
    objectManager.client.cachePolicy = RKRequestCachePolicyDefault;
    // RKRequestCachePolicyDefault = RKRequestCachePolicyEtag | RKRequestCachePolicyTimeout
}

- (void)initializeObjectMapping {
    
    // Github date format: 2012-07-05T09:43:24Z
    // Already available in Restkit default formatters
    [RKObjectMapping addDefaultDateFormatter: [NSDateFormatter initWithDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"]];
    
    RKObjectMappingProvider *omp = [RKObjectManager sharedManager].mappingProvider;
    
    RKObjectMapping *repositoryObjectMapping = [GHRepository mapping];
    [omp addObjectMapping:repositoryObjectMapping];
    [omp setObjectMapping:repositoryObjectMapping forResourcePathPattern:@"/orgs/:organization/repos"];
    
    RKObjectMapping *userObjectMapping = [GHUser mapping];
    [omp addObjectMapping:userObjectMapping];
    [omp setObjectMapping:userObjectMapping forResourcePathPattern:@"/orgs/:organization/public_members"];
}

@end