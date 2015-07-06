%function OuvrirNXT()
COM_CloseNXT('all')
%clear all
close all
global h j speedmultip
j = COM_OpenNXTEx('USB','0016530A5DE9', 'MotorControlFilename', 'motorcontrol22');
h = COM_OpenNXTEx('USB','0016530A5E6B', 'MotorControlFilename', 'motorcontrol22');
OpenLight(SENSOR_3, 'ACTIVE', j)
OpenLight(SENSOR_4, 'ACTIVE', j)
OpenColor(SENSOR_2, j)
OpenCompass(SENSOR_1, h)
speedmultip = 1.125;