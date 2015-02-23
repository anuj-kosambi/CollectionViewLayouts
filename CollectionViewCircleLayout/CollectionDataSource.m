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
}

@end

@implementation CollectionDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        CellCount = 5;
    }
    return self;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return CellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CircleCellResuseIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];

    return cell;
}

@end
