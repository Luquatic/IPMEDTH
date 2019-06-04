/*
 * Copyright 2017 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <jni.h>
#include <android/log.h>

#include "EchoAudioEngine.h"

extern "C" {

static EchoAudioEngine *audioEngine = nullptr;

JNIEXPORT void JNICALL
Java_com_example_first_1app_MainActivity_create(
        JNIEnv *env,
        jclass type) {  //  jobject /* this */
  if (audioEngine == nullptr) {
    audioEngine = new EchoAudioEngine();
  }


}

JNIEXPORT void JNICALL
Java_com_example_first_1app_MainActivity_delete(JNIEnv *env, jclass type) { //jobject instance
  delete audioEngine;
  audioEngine = nullptr;
}

JNIEXPORT void JNICALL
Java_com_example_first_1app_MainActivity_setEchoOn(JNIEnv *env, jclass type,
                                                    jboolean isEchoOn) { //jobject instance

  audioEngine->setEchoOn(isEchoOn);
}

JNIEXPORT void JNICALL
Java_com_example_first_1app_MainActivity_setWaarde(JNIEnv *env, jobject instance,
                                                   jint sliderwaarde) {

  audioEngine->returnAudioEffect()->setSliderWaarde(sliderwaarde);
}

JNIEXPORT void JNICALL
Java_com_example_first_1app_MainActivity_getWaarde(JNIEnv *env, jobject instance) {

  audioEngine->returnAudioEffect()->returnSliderWaarde();
}

}// End extern "C"
