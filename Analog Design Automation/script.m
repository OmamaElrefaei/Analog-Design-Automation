% A script for function "OTA_fun"

%Created on 18 April 2020
%@author: Omama Elrefaei
    
clearvars;
clear all;
close all;
clc;


OTA_SPEC.AVDC = 38; OTA_SPEC.GBW = 10e6; OTA_SPEC.CL = 5e-12; OTA_SPEC.IB = 40e-6;
[Sizing_SPEC]= OTA_fun(OTA_SPEC);
fprintf('\n The sizing (W and L) of the first OTA transistors:  \n\n');
disp(Sizing_SPEC);

OTA_SPEC.AVDC = 32; OTA_SPEC.GBW = 20e6; OTA_SPEC.CL = 5e-12; OTA_SPEC.IB = 100e-6;
[Sizing_SPEC]= OTA_fun(OTA_SPEC);
fprintf('\n The sizing (W and L) of the second OTA transistors:  \n\n');
disp(Sizing_SPEC);
