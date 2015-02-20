//
//  AEBlockFilter.m
//  TheAmazingAudioEngine
//
//  Created by Michael Tyson on 20/12/2012.
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import "AEBlockFilter_iOS5.h"

@interface AEBlockFilter_iOS5 ()
@property (nonatomic, copy) AEBlockFilterBlock block;
@end

@implementation AEBlockFilter_iOS5
@synthesize block = _block;

- (id)initWithBlock:(AEBlockFilterBlock)block {
    if ( !(self = [super init]) ) self = nil;
    self.block = block;
    return self;
}

+ (AEBlockFilter_iOS5*)filterWithBlock:(AEBlockFilterBlock)block {
    return [[[AEBlockFilter_iOS5 alloc] initWithBlock:block] autorelease];
}

-(void)dealloc {
    self.block = nil;
    [super dealloc];
}

static OSStatus filterCallback(id                        filter,
                               AEAudioController_iOS5        *audioController,
                               AEAudioController_iOS5FilterProducer producer,
                               void                     *producerToken,
                               const AudioTimeStamp     *time,
                               UInt32                    frames,
                               AudioBufferList          *audio) {
    AEBlockFilter_iOS5 *THIS = (AEBlockFilter_iOS5*)filter;
    THIS->_block(producer, producerToken, time, frames, audio);
    return noErr;
}

-(AEAudioController_iOS5FilterCallback)filterCallback {
    return filterCallback;
}

@end
