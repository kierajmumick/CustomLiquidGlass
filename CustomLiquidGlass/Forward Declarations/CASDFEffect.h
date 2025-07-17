// Created by kieraj_mumick on 7/17/25.
// Copyright © 2025 Kieraj Mumick Inc. All rights reserved.

#ifndef CASDFEffect_h
#define CASDFEffect_h

@interface CASDFEffect: NSObject
@end

/// The effect that "warps" the glass to make it appear curved.
@interface CASDFGlassDisplacementEffect : CASDFEffect
-(instancetype)init;
@end

/// The effect that "highlights" the glass to make it appear like its reflecting light.
@interface CASDFGlassHighlightEffect : CASDFEffect
-(instancetype)init;
-(NSString *)name;
-(void)setName:(NSString *) name;
@end

/// An effect that I haven't figured out what it does.
@interface CASDFOutputEffect : CASDFEffect
-(instancetype)init;
@end

/// An effect that presumably adds a shadow to the glass, but I haven't figured out what it does.
@interface CASDFShadowEffect : CASDFEffect
-(instancetype)init;
@end


#endif /* CASDFEffect_h */
