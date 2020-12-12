
% Created on 2 April 2020
% @author: Omama Elrefaei

clc; 
clear;

%We will refer to the voltage at node 1 as v_1, at node 2 as v_2 and so on.
%The naming of the independent voltage sources is quite loose, 
%but the names must start with the letter "V" and must be unique from any node names. 
%For our purposes we will require that independent voltage sources have no underscore ("_") in their names. 
%So the names Va, Vsource, V1, Vxyz123 are all legitimate names, but V_3, V_A, Vsource_1 are not. 
%The current through a voltage source will be labeled with "I_" followed by the name of the voltage source. 
%Therefore the current through Va is I_Va, the current through VSource is I_VSource, etc...
%The naming of the independent current sources is similar; 
%the names must start with the letter "I" and must have no underscore ("_") in their names. 
%So the names Ia, Isource, I1, Ixyz123 are all legitimate names, but I_3, I_A, Isource_1 are not. 


%Defining path of text file containing Netlist, and passing it to the 
%function called netlist_fun that returns the symbolic and numerical
%results and Ac analysis.
netlist = "netlist.cir";

% To find the the transfer function between two nodes of the netlist:
first_node = 2;  
second_node = 1;

[A, x, z, na, nx, nz, enx, mySys]= netlist_fun(netlist, first_node, second_node);

% Displey the matrix:
fprintf('\nThe symbolic A Matrix of the netlist is: \n\n');
disp(A);

fprintf('\nThe symbolic x vector of the netlist is: \n\n');
disp(x);

fprintf('\nThe symbolic z vector of the netlist is: \n\n');
disp(z);

fprintf('\nThe numerical A Matrix of the netlist is: \n\n');
disp(na);

fprintf('\nThe numerical z vector of the netlist is: \n\n');
disp(nz);

% Displey the matrix equation
fprintf('\nThe symbolic matrix equation: \n\n');
disp(A*x==z)

fprintf('\nThe symbolic solution of every unknown:  \n\n');
disp(x==nx)

fprintf('\nThe numerical matrix equation: \n\n');
disp(na*x==nz)

fprintf('\nThe solution of every unknown:  \n\n');
disp(x==enx)

fprintf('\nTransfer function between node %d and node %d:\n\n', first_node, second_node);

mySys
damp(mySys)

figure(1)
subplot(2,1,1)
% Pole-Zero Map
pzmap(mySys)
subplot(2,1,2)
% Step Response:
step(mySys)

figure(2)
% Bode Plot:
bode(mySys), grid
xlim([1 1e8]) 


fprintf('\nElapsed time is %g seconds.\n\n',toc);
