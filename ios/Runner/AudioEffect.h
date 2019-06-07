//
//  AudioEffect.h
//  Runner
//
//  Created by Kim Wijfje on 07/06/2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#ifndef AAUDIO_EFFECT_PROCESSOR_H
#define AAUDIO_EFFECT_PROCESSOR_H


#include <cstdint>

class AudioEffect {
public:
    
    void process(int16_t *inputBuffer, int32_t samplesPerFrame, int32_t numFrames);
    void setSliderWaarde(int);
    int returnSliderWaarde();
    
private:
    int sliderWaarde = 100;
    float b;
};


#endif //AAUDIO_EFFECT_PROCESSOR_H
