function plotGeneral()

global SP Time2 Time r2d SimOutput Sat

%% SETPOINTS de Posição
figure
set(gcf, 'Position', [1 1 800 600]);
esq = 0.05;
dir = 0.925;
esp_vert_top = 0.003;
esp_bet_line = 0.003;
% h            = 0.11;
h            = 0.175;
color        = [0.1 0.1 0.1];

axesVectors = [esq 1-h-esp_vert_top dir h;...
    esq 1-2*h-esp_vert_top-2*esp_bet_line dir h;...
    esq (1-3*h-esp_vert_top-4*esp_bet_line) dir h;...
    esq (1-4*h-esp_vert_top-6*esp_bet_line) dir h;...
    esq (1-5*h-esp_vert_top-8*esp_bet_line) dir h;...
    esq (1-6*h-esp_vert_top-10*esp_bet_line) dir h;...
    esq (1-7*h-esp_vert_top-12*esp_bet_line) dir h;...
    esq (1-8*h-esp_vert_top-14*esp_bet_line) dir h];

ax1 = axes('Units', 'Normalized', 'Position', [esq 1-h*2-esp_vert_top dir h*2], ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(SP.x_Cat,SP.y_Cat,'b','linewidth',2);
hold on;
% SimOutput.y_HTR = SP.h_tower + (exp(Sim.a*SimOutput.PositionAndAttitude(1,:)) + exp(-Sim.a*SimOutput.PositionAndAttitude(1,:)) - 2)/(2*Sim.a);
% aux1  = length(SimOutput.y_HTR);
% delta = (SimOutput.PositionAndAttitude(1,end) - SP.x_Cat(1))/aux1;
% aux2  = SimOutput.PositionAndAttitude(1,1):delta:(SimOutput.PositionAndAttitude(1,end)-delta);
plot(SimOutput.PositionAndAttitude(1,:),SimOutput.y_HTR,'r','linewidth',2);
plot(SimOutput.PositionAndAttitude(1,1),SimOutput.y_HTR(1),'xg','linewidth',2,'MarkerSize',6)
plot(SimOutput.PositionAndAttitude(1,end),SimOutput.y_HTR(end),'ok','linewidth',2,'MarkerSize',6)
% set(gca, 'XTick', [5 10 15 20])
% set(gca, 'YTick', [-250 -200 -150])
axis([SP.x_Cat(1) SP.x_Cat(end) 0 55]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$\rm Catenary\ height\ {\rm[m]}$'},'Interpreter','latex','Color','k','FontSize',14);
xlabel({'$\rm Catenary\ length\ {\rm[m]}$'},'Interpreter','latex','Color','k','FontSize',14);
leg3 = legend({'Catenary shape','HTR path','Start','End'});
set(leg3,'Interpreter','latex','orientation','horizontal','location','south','FontSize',14);

linkaxes([ax1], 'x');

print('-depsc2','C:\Users\muril\Dropbox\UFJF\Pós-Doutorado 2\Paper Vítor A1\SIMULACAO - v2 Scn_01\figs\fig1.eps');
% 
% %%
% figure
set(gcf, 'Position', [1 1 800 600]);
ax1 = axes('Units', 'Normalized', 'Position', axesVectors(1, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time,SP.Position(1,:),'b','linewidth',2);
hold on;
plot(Time2,SimOutput.PositionAndAttitude(1,:),'r','linewidth',2);
set(gca, 'XTick', [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80])
set(gca, 'YTick', [-250 -150 -50 0 50 150])
axis([0 85 -270 160]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$x(t) {\rm[m]}$'},'Interpreter','latex','Color','k','FontSize',14);

leg3 = legend({'SetPoint','Responses'});
set(leg3,'Interpreter','latex','orientation','horizontal','location','south','FontSize',14);

ax2 = axes('Units', 'Normalized', 'Position', axesVectors(2, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time,SP.Roll(1,:)*r2d,'b','linewidth',2); hold on;
plot(Time2,SimOutput.PositionAndAttitude(2,:)*r2d,'r','linewidth',2); % MATHAUS - não seria SimOutput.PositionAndAttitude(2,:) ao invés de SimOutput.VelocitiesBFFrame(1,:) ???
set(gca, 'XTick', [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80])
set(gca, 'YTick', [-40 -20 0 20 40])
axis([0 85 -50 50]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$\phi(t)\,{\rm[^{\circ}]}$'}, 'Interpreter','latex','Color','k','FontSize',14);

ax3 = axes('Units', 'Normalized', 'Position', axesVectors(3, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time2,SimOutput.Arfagem_Line*r2d,'r','linewidth',2);
set(gca, 'XTick', [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80])
set(gca, 'YTick', [-10 -5 0 5 10])
axis([0 85 -12 12]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$\theta(t)\,{\rm[^{\circ}]}$'}, 'Interpreter','latex','Color','k','FontSize',14);

ax4 = axes('Units', 'Normalized', 'Position', axesVectors(4, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time2,SimOutput.Vx(:),'r','linewidth',2);
set(gca, 'XTick', [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80])
set(gca, 'YTick', [-60 -30 0 30 60])
axis([0 85 -70 70]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$X^b_p(t)\,{\rm[N]}$'}, 'Interpreter','latex','Color','k','FontSize',14);

ax5 = axes('Units', 'Normalized', 'Position', axesVectors(5, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time2,SimOutput.Torq_Roll(:),'r','linewidth',2);
set(gca, 'XTick', [0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85])
% set(gca, 'XTick', [5 10 15 20 25 30 35 40 45 50 55 60 63])
set(gca, 'YTick', [-1 -0.5 0 0.5 1])
axis([0 85 -1.5 1.5]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$L^b_p(t)\,{\rm[N.m]}$'}, 'Interpreter','latex','Color','k','FontSize',14);
xlabel({'$\rm Time\,{\rm[sec]}$'}, 'Interpreter','latex','Color','k','FontSize',14);

linkaxes([ax1 ax2 ax3 ax4 ax5], 'x');

% print('-depsc2','C:\Users\muril\Dropbox\UFJF\Pós-Doutorado 2\Paper Vítor A1\SIMULACAO - v2 Scn_01\figs\fig2.eps');

%% PWM de saida dos Motores e Servomotores para Fx
h            = 0.11;
color        = [0.1 0.1 0.1];

axesVectors = [esq 1-h-esp_vert_top dir h;...
    esq 1-2*h-esp_vert_top-2*esp_bet_line dir h;...
    esq (1-3*h-esp_vert_top-4*esp_bet_line) dir h;...
    esq (1-4*h-esp_vert_top-6*esp_bet_line) dir h;...
    esq (1-5*h-esp_vert_top-8*esp_bet_line) dir h;...
    esq (1-6*h-esp_vert_top-10*esp_bet_line) dir h;...
    esq (1-7*h-esp_vert_top-12*esp_bet_line) dir h;...
    esq (1-8*h-esp_vert_top-14*esp_bet_line) dir h];

figure
set(gcf, 'Position', [1 1 800 600]);
ax1 = axes('Units', 'Normalized', 'Position', axesVectors(1, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time2,SimOutput.Servos(1,:),'k','linewidth',2);
set(gca, 'XTick', [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80])
set(gca, 'YTick', [-90 -45 0 45 90])
axis([0 85 -100 100]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$\gamma_1\ (t) {\rm[^{\circ}]}$'},'Interpreter','latex','Color','k','FontSize',14);

ax2 = axes('Units', 'Normalized', 'Position', axesVectors(2, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time2,SimOutput.Servos(2,:),'k','linewidth',2);
set(gca, 'XTick', [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80])
set(gca, 'YTick', [-90 -45 0 45 90])
axis([0 85 -100 100]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$\gamma_2\ (t) {\rm[^{\circ}]}$'},'Interpreter','latex','Color','k','FontSize',14);

ax3 = axes('Units', 'Normalized', 'Position', axesVectors(3, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time2,SimOutput.Motors(1,:),'r','linewidth',2);
set(gca, 'XTick', [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80])
set(gca, 'YTick', [0 0.25 0.5 0.75 1])
axis([0 85 -0.1 1.1]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$||\delta_1(t)||$'},'Interpreter','latex','Color','k','FontSize',14);

ax4 = axes('Units', 'Normalized', 'Position', axesVectors(4, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time2,SimOutput.Motors(2,:),'r','linewidth',2);
set(gca, 'XTick', [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80])
set(gca, 'YTick', [0 0.25 0.5 0.75 1])
axis([0 85 -0.1 1.1]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$||\delta_2(t)||$'},'Interpreter','latex','Color','k','FontSize',14);

ax5 = axes('Units', 'Normalized', 'Position', axesVectors(5, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time2,SimOutput.Motors(3,:),'b','linewidth',2);
set(gca, 'XTick', [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80])
set(gca, 'YTick', [0 0.25 0.5 0.75 1])
axis([0 85 -0.1 1.1]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$||\delta_3(t)||$'},'Interpreter','latex','Color','k','FontSize',14);

ax6 = axes('Units', 'Normalized', 'Position', axesVectors(6, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time2,SimOutput.Motors(4,:),'b','linewidth',2);
set(gca, 'XTick', [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80])
set(gca, 'YTick', [0 0.25 0.5 0.75 1])
axis([0 85 -0.1 1.1]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$||\delta_4(t)||$'},'Interpreter','latex','Color','k','FontSize',14);

ax7 = axes('Units', 'Normalized', 'Position', axesVectors(7, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time2,SimOutput.Motors(5,:),'b','linewidth',2);
set(gca, 'XTick', [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80])
set(gca, 'YTick', [0 0.25 0.5 0.75 1])
axis([0 85 -0.1 1.1]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$||\delta_5(t)||$'},'Interpreter','latex','Color','k','FontSize',14);

ax8 = axes('Units', 'Normalized', 'Position', axesVectors(8, :), ...
    'FontName', 'Times New Roman', 'FontSize', 10, 'GridLineStyle', ...
    ':', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', ...
    'YMinorTick', 'on', 'Box', 'off');

set(gcf,'Color','w');
plot(Time2(end),SimOutput.Motors(6,end),'k','linewidth',2);
hold on
plot(Time2(end),SimOutput.Motors(6,end),'r','linewidth',2);
plot(Time2,SimOutput.Motors(6,:),'b','linewidth',2);
set(gca, 'XTick', [0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85])
set(gca, 'YTick', [0 0.25 0.5 0.75 1])
axis([0 85 -0.1 1.1]);
set(gca,'XColor',color,'YColor',color)
set(gca,'Box','off');
ylabel({'$||\delta_6(t)||$'},'Interpreter','latex','Color','k','FontSize',14);
xlabel({'$\rm Time\,{\rm[sec]}$'}, 'Interpreter','latex','Color','k','FontSize',14);

leg3 = legend({'Servomotors','Motors 1, 2','Motors 3, 4, 5, 6'});
set(leg3,'Interpreter','latex','orientation','horizontal','location','south','FontSize',14);

linkaxes([ax1 ax2 ax3 ax4 ax5 ax6 ax7 ax8], 'x');
end