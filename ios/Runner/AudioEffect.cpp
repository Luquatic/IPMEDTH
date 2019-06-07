//
//  AudioEffect.cpp
//  Runner
//
//  Created by Kim Wijfje on 07/06/2019.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#include "AudioEffect.h"
#include <algorithm>
#include <iostream>
//#define a 5000 //grenswaarde
#define MAX_GRENSWAARDE 5000
#define MIN_GRENSWAARDE 100
using namespace std;


void AudioEffect::process(int16_t *inputBuffer, int32_t samplesPerFrame, int32_t numFrames) {
    int a = sliderWaarde;
    //  a - grenswaarde (doorgeven via ui, nu define)
    //  b - hoogste waarde van buffer (wordt gebruikt voor omrekenen)
    //  limitFlag - flag voor als een waarde in de buffer boven grens is
    
    int limitFlag = 0;
    float q = 0;
    
    //Check if input is above threshold, set in b if value above previous max
    for(int i = 0; i< (numFrames * samplesPerFrame); i++){
        if(inputBuffer[i] > a){
            if(inputBuffer[i] > b) b = inputBuffer[i];
            limitFlag=1;
        }
    }
    
    //If buffer has a value above a, use current b
    //If buffer doesn't but previous buffer did, decrease b to 1/2 of its value
    //Else, don't multiply (a/a)
    if(limitFlag){
        q = b;
    }else if(b>a){
        q = b-((b-a)/2);
        b = a;
    }else{
        q = a;
        b = a;
    }
    
    for(int i = 0; i< (numFrames * samplesPerFrame); i++){
        inputBuffer[i] = (a/q) * inputBuffer[i];
    }
}


void AudioEffect::setSliderWaarde(int waarde) {
    
    waarde = ((double)waarde/100.0) * (MAX_GRENSWAARDE- MIN_GRENSWAARDE) + MIN_GRENSWAARDE;  //remaps the slidervalue from [0-100] to [MIN_GRENSWAARDE - MAX_GRENSWAARDE]
    sliderWaarde = waarde;
}

int AudioEffect::returnSliderWaarde() {
    return sliderWaarde;
}
