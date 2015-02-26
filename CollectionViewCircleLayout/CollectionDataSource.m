//
//  CollectionDataSource.m
//  CollectionViewCircleLayout
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionDataSource.h"


@interface CollectionDataSource ()  {
  }

@end

@implementation CollectionDataSource

@synthesize dataSource;

- (instancetype)initWithDataSource:(NSMutableDictionary *)dicitonary {
    self = [super init];
    dataSource = dicitonary;
    return self;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [dataSource allKeys].count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    NSAssert([[dataSource objectForKey:ConvertIntToId(section)] isKindOfClass:[NSMutableArray class]], @"Invaild ObjectType in DataSouce at%ld",section);
    NSMutableArray *allItems = [dataSource objectForKey:ConvertIntToId(section)];
    return [allItems count];
        
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AlbumCellResuseIdentifier forIndexPath:indexPath];
     NSAssert([[dataSource objectForKey:ConvertIntToId(indexPath.section)] isKindOfClass:[NSMutableArray class]], @"Invaild ObjectType in DataSouce at%ld",indexPath.section);
    NSMutableArray *allItems = [dataSource objectForKey:ConvertIntToId(indexPath.section)];
    cell.imageView.image = [allItems objectAtIndex:indexPath.item];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CollectionSupplementaryView *supplyView;
    if ([kind isEqual:AlbumHeaderSupplyKind]) {
        supplyView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:AlbumSupplyResuseIdentifier forIndexPath:indexPath];
        supplyView.sectionHeader.text = [NSString stringWithFormat:@"%lu",indexPath.section];
        
    }
    return supplyView;
}

@end
