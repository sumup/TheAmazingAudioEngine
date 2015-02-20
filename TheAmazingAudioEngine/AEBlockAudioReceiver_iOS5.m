//
//  AEBlockAudioReceiver.m
//  TheAmazingAudioEngine
//
//  Created by Michael Tyson on 21/02/2013.
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

#import "AEBlockAudioReceiver_iOS5.h"

@interface AEBlockAudioReceiver_iOS5 ()
@property (nonatomic, copy) AEBlockAudioReceiverBlock block;
@end

@implementation AEBlockAudioReceiver_iOS5
@synthesize block = _block;

- (id)initWithBlock:(AEBlockAudioReceiverBlock)block {
    if ( !(self = [super init]) ) self = nil;
    self.block = block;
    return self;
}

+ (AEBlockAudioReceiver_iOS5*)audioReceiverWithBlock:(AEBlockAudioReceiverBlock)block {
    return [[[AEBlockAudioReceiver_iOS5 alloc] initWithBlock:block] autorelease];
}

-(void)dealloc {
    self.block = nil;
    [super dealloc];
}

static void receiverCallback(id                        receiver,
                             AEAudioController_iOS5   *audioController,
                             void                     *source,
                             const AudioTimeStamp     *time,
                             UInt32                    frames,
                             AudioBufferList          *audio) {
    AEBlockAudioReceiver_iOS5 *THIS = (AEBlockAudioReceiver_iOS5*)receiver;
    THIS->_block(source, time, frames, audio);
}

-(AEAudioController_iOS5AudioCallback)receiverCallback {
    return receiverCallback;
}

@end
