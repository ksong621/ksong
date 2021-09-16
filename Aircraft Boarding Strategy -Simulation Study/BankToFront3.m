np = [120 150 180 210 240 270 300];
Nmatrix = [1,2,4,5,10,20,0,0;
    1,5,25,0,0,0,0,0;
    1,2,3,5,6,10,15,30;
    1,5,7,35,0,0,0,0;
    1,2,4,8,10,20,40,0;
    1,3,5,9,15,45,0,0;
    1,2,5,10,25,50,0,0];

v = 1;
w = 1;
R = 0;
simnum = 10;
nA = 12;
h = 1;

while h <=7
    n = np(h);
    L = n/6;
    Nrow = Nmatrix(h,:);
    y=[];
    z =1;
while z <= sum(Nrow ~=0)
    N = Nrow(z);
    he = 0;
    count = 1;
while count <= simnum
    st = 0;
    stA = 0;
    timeB = zeros(1,100000);
    xA = ceil(nA.*rand(nA,1));
    sA = zeros(1, nA);
    timeA = zeros(1,1000);
    for i = 1:12 
        a = xA(i);
        r = R;
        R = floor(a/4);
        k = mod(a, 4);
        sA(a) = 1;
        b = rand(100,1);
        if b <= 80
            timeA(2*R + 2*i + stA: 2*R + 2*i + stA + 30) = 1; %first class wide 2
            stA = stA + 30;
        end 
        if k == 1
            if sA(a+1) == 1
                stA = stA + 5;
                timeA(2*R + 2*i + stA: 2*R + 2*i + stA + 5) = 1;
            end
        else if k == 0
                if sA(a-1) == 1
                    stA = stA + 5;
                    timeA(2*R + 2*i + stA: 2*R + 2*i + stA + 5) = 1;             
                end
            end
        end

    stA = sum(timeA~=0);
    end
    TA = R + w*nA + stA;
for j = 1:N
    x = ceil(n/N.*rand(n,1));
    s = zeros(1, n/N); %n/N
for i = 1:n/N
    a = x(i);
    r = R;
    R = floor(a/6)+1;
    k = a - 6*floor(a/6);
    s(a) = 1;
    b = rand(100,1);
    if b <= 80
        timeB(R + i + (N-j)*L/N + st: R + i + (N-j)*L/N + st + 15) = 1;
        st = st + 15;
    end
    if k == 1
        if s(a+1) == 0
            if s(a+2) == 1
                timeB(R + i + (N-j)*L/N + st: R + i + (N-j)*L/N + st + 3) = 1;
                st = st + 3;
            end
        else
            if s(a+2) == 1
                timeB(R + i + (N-j)*L/N + st: R + i + (N-j)*L/N + st + 5) = 1;
                st = st + 5;
            else
                timeB(R + i + (N-j)*L/N + st: R + i + (N-j)*L/N + st + 4) = 1;
                st = st + 4;
            end
        end
    else if k == 6
            if s(a-1) == 0
                if s(a-2) == 1
                    timeB(R + i + (N-j)*L/N + st: R + i + (N-j)*L/N + st + 3) = 1;
                    st =st + 3;
                end
            else
                if s(a-2) == 1
                    timeB(R + i + (N-j)*L/N + st: R + i + (N-j)*L/N + st + 5) = 1;
                    st = st + 5;
                else
                    timeB(R + i + (N-j)*L/N + st: R + i + (N-j)*L/N + st + 4) = 1;
                    st = st + 4;
                end
            end
        else if k == 2
            if s(a+1) == 1
                st = st + 3;
                timeB(R + i + (N-j)*L/N + st: R + i + (N-j)*L/N + st + 3) = 1;
            end
        else if k == 5
                if s(a-1) == 1
                    st = st + 3;
                    timeB(R + i + (N-j)*L/N + st: R + i + (N-j)*L/N + st + 3) = 1;
                end
            end
            end
        end
    end
    st = sum(timeB~=0);
end
end
    T = R + w*n + st;
    count = count + 1;
    he = he+T+TA;
    Time = T+TA;      
end

average = he / simnum;
z = z+1; 
y = [y average];
Min = floor(average/60);
Second = average - Min*60;
print = ['N=',num2str(N),' n=',num2str(n),' average=',num2str(average),'=', num2str(Min),'min',num2str(Second),'sec'];
disp(print)

end

hold all
plot(Nrow(1:z-1), y,'o-')
legend('n=120','n=150','n=180','n=210','n=240','n=270','n=300')
axis([1 50 500 3500]);
h = h+1;
xlabel('number of groups');
ylabel('seconds');
title('BF time vs number of groups vs numver of people');

end


