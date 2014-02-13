//
//  AssetsAccessor.h
//  AssetsLibrary
//
//  Created by Mika Yamamoto on 2014/02/12.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface AssetsAccessor : NSObject {
    ALAssetsLibrary *assetsLibrary_;
    NSMutableArray *selectedAssets_;
}

+ (AssetsAccessor*)sharedInstance;

@property (nonatomic, retain) ALAssetsLibrary *assetsLibrary;
@property (strong, nonatomic) NSMutableArray *selectedAssets;


@end
