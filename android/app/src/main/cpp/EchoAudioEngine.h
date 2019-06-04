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

#ifndef AAUDIO_ECHOAUDIOENGINE_H
#define AAUDIO_ECHOAUDIOENGINE_H

#include <thread>
#include "aaudio/AAudio.h"
#include "AudioEffect.h"
#include <mutex>

class EchoAudioEngine {

public:
  ~EchoAudioEngine();

  void setRecordingDeviceId(int32_t deviceId);
  void setPlaybackDeviceId(int32_t deviceId);
  void setEchoOn(bool isEchoOn);
    AudioEffect* returnAudioEffect();
    aaudio_data_callback_result_t dataCallback(AAudioStream *stream,
                                             void *audioData,
                                             int32_t numFrames);
  void errorCallback(AAudioStream *stream,
                     aaudio_result_t  __unused error);

private:

  bool isEchoOn_ = false;
  bool isFirstDataCallback_ = true;
  int32_t recordingDeviceId_ = AAUDIO_UNSPECIFIED;
  int32_t playbackDeviceId_ = AAUDIO_UNSPECIFIED;
  aaudio_format_t format_ = AAUDIO_FORMAT_PCM_I16;
  int32_t sampleRate_;
  int32_t inputChannelCount_ = 1;
  int32_t outputChannelCount_ = 2;
  AAudioStream *recordingStream_ = nullptr;
  AAudioStream *playStream_ = nullptr;
  int32_t framesPerBurst_;
  std::mutex restartingLock_;
  AudioEffect audioEffect_;

  void openRecordingStream();
  void drainRecordingStream(void *audioData, int32_t numFrames);
  void openPlaybackStream();

  void startStream(AAudioStream* stream);
  void stopStream(AAudioStream* stream);
  void closeStream(AAudioStream* stream);

  void openAllStreams();
  void closeAllStreams();
  void restartStreams();
  AAudioStreamBuilder* createStreamBuilder();

  void setupCommonStreamParameters(AAudioStreamBuilder *builder);
  void setupRecordingStreamParameters(AAudioStreamBuilder *builder);
  void setupPlaybackStreamParameters(AAudioStreamBuilder *builder);
  void warnIfNotLowLatency(AAudioStream *stream);
    void ConvertMonoToStereo(int16_t *buffer, int32_t numFrames);

    AudioEffect* AE;
};

#endif //AAUDIO_ECHOAUDIOENGINE_H
