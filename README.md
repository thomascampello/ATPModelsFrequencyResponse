# Obtaining Frequency Responses of User-Defined Models in the ATP

Manuscript ID: IEEE LATAM Submission ID: 9564 

Authors:
-  Sergio L. Varricchio
-  Thomas M. Campello

This repository contains all scripts required to reproduce the simulation and numerical results presented in the paper.

##  📁 Scripts and Algorithms Files

| File   |	Description |
|--------|--------------|
| Main_TF.exe | Compiled executable of the proposed NFT algorithm. This executable was compiled as a generic program that takes the measured time-domain current waveforms as input.|
| run_TF_exe.m | Matlab script created to generate the input files for Main_TF.exe and to read the responses from it and generate the corresponding .mat files | 
| Fourier.m | The MATLAB script of the NFTA proposed in the paper. This file was used to compile and create the "Main_TF.exe" |
| Main_TF.m | Complementary script used with the "Fourier.m". This script is used to read the ATP curves saved as ".mat" by the PLOTXY program, run th "Fourier.m" and create an output file with the frequency response. This file was also used to compile and create the "Main_TF.exe" and the "run_TF_exe.m" |

##  📂 Simulation Result Files

| File   | Related Figure(s) |	Description |
|--------|-------------------|--------------|
| Sistema 2 | - | RAR File with the files Resposta_Tempo_1us_1seg_10kHz_FT_2_2.mat, Resposta_Tempo_1us_1seg_10kHz_FT_1_2.mat, and Resposta_Tempo_1us_1seg_10kHz_FT_1_1.mat. |
|Resposta_Tempo_1us_1seg_10kHz_FT_2_2.mat | - | Current Responses at the left-hand port due to the application of a balanced three-phase unit impulse voltage input at left-hand port in the 0 to 10 kHz FDNE of the two port test system. |
|Resposta_Tempo_1us_1seg_10kHz_FT_1_2.mat | - | Current Responses at the left-hand port due to the application of a balanced three-phase unit impulse voltage input at right-hand in the 0 to 10 kHz FDNE of the two port test system. |
|Resposta_Tempo_1us_1seg_10kHz_FT_1_1.mat | - | Current Responses at the right-hand port due to the application of a balanced three-phase unit impulse voltage input at right-hand in the 0 to 10 kHz FDNE of the two port test system. |
|Resp_Temp_Impulso_1us_10kHz.MAT | Fig.8 and Fig. 9 | Current responses due to the application of a balanced three-phase unit impulse voltage input in the 0 to 10 kHz FDNE of the one port test system. |
|Resp_Temp_Impulso_1us_1.2kHz.MAT | Fig. 3 | Current responses due to the application of a balanced three-phase unit impulse voltage input in the 0 to 1.2 kHz FDNE of the one port test system. |
|RF_impulse.mat| Fig. 10 and Fig. 11 | Frequency responses of Complete Model and 0-1.2 kHz and 0-10kHz FDNE of the one port test system. | 

##  📂 ATP System Files 

| File   |	Description |
|--------|--------------|
| v2_1us_RF_FDNE_MODELS_10000_pu_RT_impulso.acp | ATPDraw file of the one port test system with application of a balanced three-phase unit impulse voltage input in the 0 to 10 kHz FDNE. |
| v2_1us_RF_FDNE_MODELS_10000_pu_RT_FonteTENSAO_1Hz.acp | ATPDraw file of the one port test system with application of cossenoidal voltage sources (traditional method) in the 0 to 10 kHz FDNE. |
| v2_1us_RF_FDNE_MODELS_1200_pu_RT_impulso.acp | ATPDraw file of the one port test system with application of a balanced three-phase unit impulse voltage input in the 0 to 1.2 kHz FDNE. |

##  💻 Requirements
-  MATLAB R2014b or later.
-  ATP/ATPDraw

##  ✉️ Contact

For questions or replication of results: slvarricchio@gmail.com or thomas.campello@cefet-rj.br
