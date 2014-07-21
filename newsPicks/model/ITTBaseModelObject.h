#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }
@interface ITTBaseModelObject :NSObject <NSCoding,NSCopying> {

}
-(id)initWithDataDic:(NSDictionary*)data;
- (NSDictionary*)attributeMapDictionary;
- (void)setAttributes:(NSDictionary*)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData*)getArchivedData;
@end
