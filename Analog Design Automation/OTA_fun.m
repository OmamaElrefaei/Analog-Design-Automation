    %The function automates the design of 5T-OTA. It takes a single structure (SPEC) as input. 
    %SPEC has the following fields: 
    %DC gain (AVDC), 
    %gain-bandwidth product (GBW), 
    %OTA bias current (IB), 
    %load capacitance (CL).
    %The function returns a single structure OTA that contains the sizing (W and L) of the OTA transistors.
    
    %Created on 18 April 2020
    %@author: Omama Elrefaei
    
    % load data in structure format
    % all nmos data is contained in structure nch
    % all pmos data is contained in structure pch
    load PTM_180_nch.mat
    load PTM_180_pch.mat

    % Assume: 
    L = 0.4:0.1:2;
    % Then:
    Avds = OTA_SPEC.AVDC;
    ID = OTA_SPEC.IB/2;
    Gm12 = OTA_SPEC.GBW*2*pi*OTA_SPEC.CL;
    Gds2 = Gm12 /(2*(10^(Avds/20)));
    Gds4 =  Gds2; 
    gm12_id = round(Gm12/ID);
    gm12_gds2 = round(Gm12/Gds2);

    gm12_gds24 = look_up(nch, 'GM_GDS', 'GM_ID', gm12_id, 'L', L);
    n = min(find(gm12_gds24 >= gm12_gds2));
    L12 = L(n);

    id_w12 = look_up(nch, 'ID_W', 'GM_ID', gm12_id, 'L', L12);
    W12 = ceil(ID/id_w12);

    % Assume:
    Gm34_ID = 15;
    % Then:
    Gm34 = Gm34_ID*ID;
    gm34_gds4 = round(Gm34/Gds4);
    gm34_gds24 = look_up(pch, 'GM_GDS', 'GM_ID', Gm34_ID, 'L', L);
    n = min(find(gm34_gds24 >= gm34_gds4));
    L34 = L(n);

    % At sat VDS > Vov, at square low V* = Vov in range 60 to 80mV  
    % At V(3) constant, VDS3 = VGS3:
    VGS3 = 0.6;
    % Then:
    gm34_id = round(look_up(pch, 'GM_ID', 'VGS', VGS3, 'L', L34));

    id_w34 = look_up(pch, 'ID_W', 'GM_ID', gm34_id, 'L', L34);
    W34 = ceil(ID/id_w34);
    
    
    Sizing_SPEC.L12 = L12; Sizing_SPEC.W12 = W12; Sizing_SPEC.gm12_gds24 = gm12_gds24;
  
    Sizing_SPEC.L34 = L34; Sizing_SPEC.W34 = W34;
   

end