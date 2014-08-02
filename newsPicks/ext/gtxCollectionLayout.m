//
//  gtxCollectionLayout.m
//  Animation
//
//  Created by dengqixiang on 14-7-25.
//  Copyright (c) 2014年 gtx. All rights reserved.
//

#import "gtxCollectionLayout.h"
#define ITEM_SIZE_WIDTH 70

#define ITEM_SIZE_HEIGHT 70
#define ITEM_X_OFFSET    300
#define ITEM_Y_OFFSET    10
@interface gtxCollectionLayout()
@property (nonatomic, strong) NSDictionary *layoutAttributes;
// arrays to keep track of insert, delete index paths
@property (nonatomic, strong) NSMutableArray *deleteIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertIndexPaths;

@end

@implementation gtxCollectionLayout

- (instancetype)init {
    
    self = [super init];
    
    if (self) [self initLayout];
    
    return self;
}

- (void)initLayout {
    
    self.topReveal = ITEM_SIZE_HEIGHT*0.7;
    self.offsetY = ITEM_Y_OFFSET;
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    CGSize size = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height) ;
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
    self.itemSize = CGSizeMake(self.collectionViewContentSize.width, ITEM_SIZE_HEIGHT);
    
    
    CGPoint contentOffset = self.collectionView.contentOffset;
    CGFloat deltaH = self.collectionViewContentSize.height-self.collectionView.bounds.size.height;
    CGFloat deltaContentOffset = contentOffset.y-self.collectionViewContentSize.height+self.collectionView.bounds.size.height;
    NSMutableDictionary *layoutAttributes = [NSMutableDictionary dictionary];
    static NSInteger firstCompressingItem = -1;
    UICollectionViewLayoutAttributes *preattributes = nil;
    // 计算cell排列的直线斜率
    CGFloat tanTheta = (self.offsetY+deltaH)/ITEM_X_OFFSET;
    //self.offsetX = self.collectionView.bounds.size.width/2;
//    NSLog(@"tanTheta = %f",tanTheta);
//    NSLog(@"deltaContentOffset/tanTheta = %f",deltaContentOffset/tanTheta);
//    NSLog(@"self.offsetX = %f",self.offsetX);
//    NSLog(@"deltaContentOffset = %f",deltaContentOffset);
    for (NSInteger item = _cellCount-1; item>=0; --item)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGRect visibleRect;
        attributes.zIndex = indexPath.item;
        attributes.hidden = NO;
        CGFloat y = 0;
        CGFloat x = 0;
        visibleRect.size = self.itemSize;
        if (preattributes == nil)
        {
//            if((_cellCount-1)*self.topReveal>ITEM_Y_OFFSET)
//                y = ITEM_Y_OFFSET+deltaH;
//            else
            visibleRect.size = CGSizeMake(self.itemSize.width, self.collectionView.bounds.size.height);
            y = self.offsetY+deltaH;//(_cellCount-1)*self.topReveal+deltaH;
            x = ITEM_X_OFFSET-(y)*ITEM_X_OFFSET/(self.offsetY+deltaH);
        }
        else
        {
            //if(firstCompressingItem != item)
                y = preattributes.frame.origin.y - self.topReveal;
            //y = preattributes.frame.origin.y-(_cellCount-1-item)*2;
//            else
//                y = preattributes.frame.origin.y - self.topReveal - (contentOffset.y-200);
            //NSLog(@"y = %f",y);
            if(y<contentOffset.y+(item)*2)
            {
                y = contentOffset.y+(item)*2;
            }
            x = ITEM_X_OFFSET-(y)*ITEM_X_OFFSET/(self.offsetY+deltaH)+deltaContentOffset/tanTheta;
        }
//        NSLog(@"item = %d,x = %f",item,x);
       
        
        visibleRect.origin = CGPointMake(x, y);
        attributes.frame = visibleRect;
        
        
        if (contentOffset.y<=(self.collectionViewContentSize.height-self.collectionView.bounds.size.height))
        {
            CGRect frame = attributes.frame;
            if(preattributes == nil)
            {
                frame.origin.y += deltaContentOffset;//contentOffset.y-200;
                if (firstCompressingItem<0) {
                    firstCompressingItem = item-1;
                }
            }
            else if(firstCompressingItem == item)
            {
                //CGFloat delta = frame.origin.y-preattributes.frame.origin.y;
                //NSLog(@"pre delta = %f",self.topReveal*(_cellCount-1-item));
                if(fabsf(deltaContentOffset) < self.topReveal*(_cellCount-1-item)&&fabsf(deltaContentOffset)>=self.topReveal*(_cellCount-2-item))
                {
                    frame.origin.y -= (deltaContentOffset + self.topReveal*(_cellCount-2-item));//contentOffset.y-200;
                    //frame.origin.x += deltaContentOffset/tanTheta;
                    frame.origin.x  = ITEM_X_OFFSET-(frame.origin.y)*ITEM_X_OFFSET/(self.offsetY+deltaH)+deltaContentOffset/tanTheta;
                    //NSLog(@"delta = %f",self.topReveal*(_cellCount-2-item));
                    //NSLog(@"deltaContentOffset = %f",deltaContentOffset);
                    //NSLog(@"item = %d",item);
                    //NSLog(@"frame.origin.y = %f",frame.origin.y);
                }
                else if (fabsf(deltaContentOffset)< self.topReveal*(_cellCount-2-item))
                {
                    firstCompressingItem = item+1;
                }
                else
                {
                    frame.origin.y = preattributes.frame.origin.y-2;
                    frame.origin.x  = ITEM_X_OFFSET-(frame.origin.y)*ITEM_X_OFFSET/(self.offsetY+deltaH)+deltaContentOffset/tanTheta;
                    firstCompressingItem = item-1;
                }
            }
            else if(item>firstCompressingItem)
            {
                frame.origin.y = preattributes.frame.origin.y-2;
                frame.origin.x  = ITEM_X_OFFSET-(frame.origin.y)*ITEM_X_OFFSET/(self.offsetY+deltaH)+deltaContentOffset/tanTheta;
            }
            
            //NSLog(@"firstCompressingItem = %ld",(long)firstCompressingItem);
            attributes.frame = frame;
        }
        else
        {
            firstCompressingItem = -1;
        }
        

        
        preattributes = attributes;
        layoutAttributes[indexPath] = attributes;
    }
    self.layoutAttributes = layoutAttributes;
}

-(CGSize)collectionViewContentSize
{
    self.offsetY =  (CGFloat)320;
    if((_cellCount-1)*self.topReveal>ITEM_Y_OFFSET)
        self.offsetY = 330;
    else
        self.offsetY = 330;//(_cellCount-1)*self.topReveal;
    NSInteger n = floorf(self.offsetY/self.topReveal);
    
    CGSize contentSize  = CGSizeMake(CGRectGetWidth(self.collectionView.frame), (_cellCount-n-1)*self.topReveal + CGRectGetHeight(self.collectionView.frame));
    if (contentSize.height <= CGRectGetHeight(self.collectionView.frame)) {
        CGRectGetHeight(self.collectionView.frame);
        contentSize.height = CGRectGetHeight(self.collectionView.frame)+1;
    }
//    return CGSizeMake([self collectionView].frame.size.width, [self collectionView].frame.size.height+300);
    return contentSize;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    //NSLog(@"new bounds = %@",NSStringFromCGRect(newBounds));
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
//    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
//    CGRect visibleRect;
//    if (path.item == _cellCount-1) {
//        visibleRect.size = CGSizeMake(self.itemSize.width, [self collectionView].frame.size.height);
//    }
//    else
//        visibleRect.size = self.itemSize;//CGSizeMake(ITEM_SIZE_WIDTH, ITEM_SIZE_HEIGHT);
//
//    CGPoint contentOffset = self.collectionView.contentOffset;
//    attributes.zIndex = path.item;
//    // 计算item的y值
//    CGFloat y = /*ITEM_SIZE_HEIGHT/2*/ path.item*2;
//    // 根据计算的y值得到x值
//    CGFloat x = ITEM_X_OFFSET-y*ITEM_X_OFFSET/ITEM_Y_OFFSET;
//    visibleRect.origin = CGPointMake(x, y);
//    attributes.frame = visibleRect;
//    return attributes;
    return self.layoutAttributes[path];
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
//    NSMutableArray* attributes = [NSMutableArray array];
//    for (NSInteger i=0 ; i < self.cellCount; i++) {
//        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
//        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
//    }
//    return attributes;
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    [self.layoutAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *stop) {
        
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            
            [layoutAttributes addObject:attributes];
        }
    }];
    
    return layoutAttributes;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    // Keep track of insert and delete index paths
    [super prepareForCollectionViewUpdates:updateItems];
    
    self.deleteIndexPaths = [NSMutableArray array];
    self.insertIndexPaths = [NSMutableArray array];
    
    for (UICollectionViewUpdateItem *update in updateItems)
    {
        if (update.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deleteIndexPaths addObject:update.indexPathBeforeUpdate];
        }
        else if (update.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertIndexPaths addObject:update.indexPathAfterUpdate];
        }
    }
}

- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    // release the insert and delete index paths
    self.deleteIndexPaths = nil;
    self.insertIndexPaths = nil;
}


// Note: name of method changed
// Also this gets called for all visible cells (not just the inserted ones) and
// even gets called when deleting cells!
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // Must call super
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    if ([self.insertIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on inserted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attributes.alpha = 0.0;
    }
    
    return attributes;
}

// Note: name of method changed
// Also this gets called for all visible cells (not just the deleted ones) and
// even gets called when inserting cells!
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // So far, calling super hasn't been strictly necessary here, but leaving it in
    // for good measure
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    if ([self.deleteIndexPaths containsObject:itemIndexPath])
    {
        // only change attributes on deleted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        attributes.alpha = 0.0;
        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);
    }
    
    return attributes;
}


@end
