//
//  CollectionDataSource.m
//  CollectionViewCircleLayout
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionDataSource.h"

@interface CollectionDataSource ()  {
    NSInteger CellCount;
    NSMutableArray *imageArray;
}

@end

@implementation CollectionDataSource

- (instancetype)init {
    self = [super init];
    imageArray = [NSMutableArray array];
    if (self) {
        for (int i = 1; i <= 20; i++) {
            [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]]];
        }
        CellCount = 5;
    }   
    return self;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0)
        return 5;
    else if (section == 1)
        return 20;
    else
        return 17;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AlbumCellResuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = [imageArray objectAtIndex:(indexPath.row % [imageArray count])];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CollectionSupplementaryView *supplyView;
    if ([kind isEqual:AlbumHeaderSupplyKind]) {
        supplyView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:AlbumSupplyResuseIdentifier forIndexPath:indexPath];
        
    }
    return supplyView;
}

@end
