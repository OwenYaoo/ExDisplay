//
//  ContactModel.m
//  WeChatContacts-demo
//
//  Created by shen_gh on 16/3/12.
//  Copyright © 2016年 com.joinup(Beijing). All rights reserved.
//

#import "ContactModel.h"
#import "NSString+Utils.h"//category


@implementation ContactModel

- (void)setName:(NSString<Optional> *)name{
    if (name) {
        _name=name;
        _pinyin=_name.pinyin;
    }
}
- (void)setPicture:(NSData *)picture{

    if (picture) {
        _picture = picture;
    }

}
- (void)setTelephone:(NSMutableDictionary *)telephone{
    if (telephone) {
        _telephones = telephone;
    }
}

- (void)setAddress:(NSString *)address{
    if (address) {
        _address = address;
    }


}
- (instancetype)initWithDic:(NSDictionary *)dic{
    NSError *error = nil;
    self =  [self initWithDictionary:dic error:&error];
    return self;
}

@end
