//
//  MYDateAssetCollectionViewController.h
//  AssetsLibrary
//
//  Created by Mika Yamamoto on 2014/02/12.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYDateAssetCollectionViewController : UICollectionViewController {
    NSMutableDictionary *dateAssets_;
    NSMutableArray *allAssets_;
    NSMutableDictionary *sections_;
}

@property (strong, nonatomic) NSMutableDictionary *dateAssets;
@property (strong, nonatomic) NSMutableArray *allAssets;
@property (strong, nonatomic) NSMutableDictionary *sections;

@end
