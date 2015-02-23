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
        CellCount = 20;
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
    CollectionAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AlbumCellResuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = [imageArray objectAtIndex:(indexPath.row % [imageArray count])];

    return cell;
}

@end
