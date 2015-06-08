//
//  AssetsAccessor.m
//  AssetsLibrary
//
//  Created by PGMY on 2014/02/12.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import "AssetsAccessor.h"

@interface AssetsAccessor () {
}

@end

@implementation AssetsAccessor

static AssetsAccessor *assetsAccessor = nil;
static ALAssetsLibrary *assetsLibrary = nil;

@synthesize assetsLibrary = assetsLibrary_;
@synthesize selectedAssets = selectedAssets_;


+ (AssetsAccessor *)sharedInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        assetsAccessor = [[AssetsAccessor alloc] init];
    });
    
    return assetsAccessor;
}

- (id)init
{
    if (self = [super init]) {
        if (assetsLibrary == nil) {
            assetsLibrary = [[ALAssetsLibrary alloc] init];
        }
        assetsLibrary_ = assetsLibrary;
    }
    
    return self;
}

// -------------------------------------------------------------------------------------------------------------------
#pragma mark -
// -------------------------------------------------------------------------------------------------------------------



@end
