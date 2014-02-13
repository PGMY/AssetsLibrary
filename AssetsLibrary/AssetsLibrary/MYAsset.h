//
//  MYAsset.h
//  AssetsLibrary
//
//  Created by Mika Yamamoto on 2014/02/13.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MYAsset : NSObject {
    UIImage *thumbnail_;
    NSDate *date_;
}

@property (strong, nonatomic) UIImage *thumbnail;
@property (strong, nonatomic) NSDate *date;

- (id)initWithALAsset:(ALAsset *)asset;

@end
