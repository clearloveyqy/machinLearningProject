%function out=MMSfunction(s,m,mu1,mu2,T)
%out=MMSfunction(3,100,0.08,0.08,1000)
%M/M/S/m�Ŷ�ģ��
%s��������������
%m��������Դ��,������ܻ�������
%T����ʱ����ֹ��
%mu1���������뿪-����ʱ�����ָ���ֲ�
%mu2��������ʱ�����ָ���ֲ�
%�¼�����
%  p_s�������������и���
%   arrive_time�������������¼�
%   leave_time���������뿪�¼�
%mintime�����¼����е�����¼�
%current_time������ǰʱ��
%L�����ӳ�
%tt����ʱ������
%LL�����ӳ�����
%c������������ʱ������
%b����������ʼʱ������
%e���������뿪ʱ������
%a_count�������������
%b_count��������������
%e_count������ʧ������


s=2;            %����̨������
m=100;          %
mu1=0.08;       %�����ʱ����
mu2=0.08;       %�����ʱ�䳤��
T=1000;         %�ܷ���ʱ��
%��ʼ��

arrive_time=exprnd(mu1,1,m);        %�ܵĻ��������ĵ���ʱ��
arrive_time=sort(arrive_time);      %����ʱ������
leave_time=[];              %�뿪ʱ��
current_time=0;             %��ǰʱ��
L=0;            %�ӳ�
LL=[L];             %�ӳ�������
tt=[current_time];  %ʱ������
c=[];       %come�����ʱ��
b=[];       %begin��ʼ�����ʱ��
e=[];       %leave�뿪��ʱ��
a_count=0;  %����Ļ�������
%ѭ��
while min([arrive_time,leave_time])<T   %�����ʱ������뿪��ʱ�䳬������
    current_time=min([arrive_time,leave_time]); %
    tt=[tt,current_time];    %��¼ʱ������
    if current_time==min(arrive_time)      %���������ӹ���
        arrive_time(1)=[];  % ���¼�����Ĩȥ���������¼�
        a_count=a_count+1; %�ۼӵ��������
        if  L<s            %�п���������
            L=L+1;        %���¶ӳ�
            c=[c,current_time];%��¼��������ʱ������
            b=[b,current_time];%��¼������ʼʱ������
            leave_time=[leave_time,current_time+exprnd(mu2)];%�����µĻ����뿪�¼�
            leave_time=sort(leave_time);%�뿪�¼�������
        else             %�޿���������
            L=L+1;        %���¶ӳ�
            c=[c,current_time];%��¼��������ʱ������
        end
    else                   %�����뿪�ӹ���
            leave_time(1)=[];%���¼�����Ĩȥ�����뿪�¼�
            arrive_time=[arrive_time,current_time+exprnd(mu1)];
            arrive_time=sort(arrive_time);%�����¼�������
            e=[e,current_time];%��¼�����뿪ʱ������
            if L>s   %�л����ȴ�
                L=L-1;        %���¶ӳ�
                b=[b,current_time];%��¼������ʼʱ������
                leave_time=[leave_time,current_time+exprnd(mu2)];%�����µĻ����뿪�¼�
                leave_time=sort(leave_time);%�뿪�¼�������
            else    %�޻����ȴ�
                L=L-1;        %���¶ӳ�
            end
    end
    LL=[LL,L];   %��¼�ӳ�����
end
Ws=sum(e-c(1:length(e)))/length(e);
Wq=sum(b-c(1:length(b)))/length(b);
Wb=sum(e-b(1:length(e)))/length(e);
Ls=sum(diff([tt,T]).*LL)/T;
Lq=sum(diff([tt,T]).*max(LL-s,0))/T;
p_s=1.0/(factorial(m)/factorial(m).*(mu2/mu1)^0+factorial(m)/factorial(m-1).*(mu2/mu1)^1+factorial(m-2)/factorial(m-1).*(mu2/mu1)^2+factorial(m)/factorial(m-2).*(mu2/mu1)^2+factorial(m)/factorial(m-4).*(mu2/mu1)^4+factorial(m)/factorial(m-5).*(mu2/mu1)^5);
fprintf('���������и���:%d\n',p_s)%���������и���
fprintf('���������:%d\n',a_count)%���������
fprintf('ƽ������ʱ��:%f\n',sum(e-c(1:length(e)))/length(e))%ƽ������ʱ��
fprintf('ƽ���ȴ�ʱ��:%f\n',sum(b-c(1:length(b)))/length(b))%ƽ���ȴ�ʱ��
fprintf('ƽ������ʱ��:%f\n',sum(e-b(1:length(e)))/length(e))%ƽ������ʱ��
fprintf('ƽ���ӳ�:%f\n',sum(diff([tt,T]).*LL)/T)%ƽ���ӳ�
fprintf('ƽ���ȴ��ӳ�:%f\n',sum(diff([tt,T]).*max(LL-s,0))/T)%ƽ���ȴ��ӳ�
for i=0:m
     p(i+1)=sum((LL==i).*diff([tt,T]))/T;%�ӳ�Ϊi�ĸ���
     fprintf('�ӳ�Ϊ%d�ĸ���:%f\n',i,p(i+1));
end
fprintf('�����������ϵõ������ĸ���:%f\n',1-sum(p(1:s)))%�����������ϵõ������ĸ���
out=[Ws,Wq,Wb,Ls,Lq,p];
%end
