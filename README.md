# non-manuals-2020
Materials from ["Using Computer Vision to Analyze Non-manual Marking of Questions in KRSL"](https://aclanthology.org/2021.mtsummit-at4ssl.6/).
This is a pilot project. For more detailed version see ["Functional Data Analysis of Non-manual Marking of Questions in Sign Languages"](https://github.com/kuzanna2016/non-manuals-2021)

The repository contains:
*  shift_elan.py - a script to shift ELAN boundaries if you encountered a bug (ELAN has an offset at the beginning of each video, which forbids annotation from the start. The duration of this offset depends on the frame rate of the video). 
*  analysis.R - statistical analysis
