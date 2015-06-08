//
//  MYAssetsGroupCollectionViewController.h
//  AssetsLibrary
//
//  Created by PGMY on 2014/02/12.
//  Copyright (c) 2014年 PGMY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MYAssetsGroupCollectionViewController : UICollectionViewController {
    ALAssetsGroup *assetsGroup_;
    NSMutableArray *assets_;
}

@property (strong, nonatomic) ALAssetsGroup *assetsGroup;
@property (strong, nonatomic) NSMutableArray *assets;

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout assetsGroup:(ALAssetsGroup*)assetsGroup;
@end
