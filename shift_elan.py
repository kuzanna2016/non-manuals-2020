import os
import pandas as pd
import math
import cv2

# getting frame_count and fps from videos
meta_video = []
for x in ['deaf','hearing']:
    path_sentence = f'../data/{x}/'
    sentences = os.listdir(path=path_sentence)
    for sentence in sentences:
        path_files = path_sentence + f'{sentence}/'
        files = os.listdir(path=path_files)
        for file in files:
            if file.endswith('.mp4'):
                path_video = path_files + file
                vidcap = cv2.VideoCapture(path_video)
                meta_video.append({'video_name':file[:-4], 'fps': vidcap.get(cv2.CAP_PROP_FPS), 'frame_count': int(vidcap.get(cv2.CAP_PROP_FRAME_COUNT))})
				
# making df from a list
meta_video = pd.DataFrame(meta_video)

# to shift the delay
def rate_to_delay(rate):
    if rate >= 30:
        return 133
    elif 30 > rate >= 28.22:
        return 141
    elif 28.22 > rate >= 28.14:
        return 142
    elif 28.14 > rate >= 23.09:
        return 173
    elif 23.09 > rate >= 22.88:
        return 174
    elif 22.88 > rate >= 22.81:
        return 175
    elif 22.81 > rate >= 19.54:
        return 204
    elif 19.54 > rate >= 19.24:
        return 207
    elif 19.24 > rate >= 19.22:
        return 208
    elif 19.22 > rate >= 16.58:
        return 241
    elif 16.58 > rate >= 14.73:
        return 271
    elif 14.73 > rate >= 14.68:
        return 272
    elif 14.68 > rate >= 14.60:
        return 273
    elif 14.60 > rate:
        return 274
		
def ms_to_frames(row, start='start'):
    video_name = row['video_name']
    try:
        fps = meta_video.fps[meta_video.video_name == video_name].values[0]
        frame_count = meta_video.frame_count[meta_video.video_name == video_name].values[0]
    except:
        print(video_name)
        
    duration = frame_count / fps
    
    delay = rate_to_delay(fps)
    
    spf = frame_count / (duration * 1000 - delay)
    
    
    return math.ceil((row[f'{start}_ms'] - delay) * spf)
	
all_elan['start_frames'] = all_elan.apply(ms_to_frames, axis=1)
all_elan['end_frames'] = all_elan.apply(lambda x: ms_to_frames(x, 'end'), axis=1)

all_elan = all_elan.merge(meta_video[['frame_count','video_name']], on=['video_name'], how='left')
