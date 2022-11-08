%n = scanf("%d", "C");
%k = scanf("%d", "C");
n = 4;
k = 3;

squares = {'GO', 'A1', 'CC1', 'A2', 'T1', 'R1','B1','CH1','B2','B3',...
    'JAIL', 'C1', 'U1', 'C2', 'C3', 'R2', 'D1', 'CC2', 'D2', 'D3',...
    'FP', 'E1', 'CH2', 'E2', 'E3', 'R3', 'F1', 'F2', 'U2', 'F3',...
    'G2J', 'G1', 'G2', 'CC3', 'G3', 'R4', 'CH3', 'H1', 'T2', 'H2'};

go = 1;
jail = 11;
c1 = 12;
e3 = 25;
h2 = 40;
r1 = 6;
r2 = r1+10;
r3 = r2+10;
r4 = r3+10;
u1 = 13;
u2 = 29;
ch1 = 8;
ch2 = 23;
g2j = 31;
ch3 = 37;
cc1 = 3;
cc2 = 18;
cc3 = 34;

nsq = length(squares);

probs = zeros(nsq);

twon = 2*n;
hits = zeros(1, twon);
for i = 1:n
    for j = 1:n
        hits(i+j) = hits(i+j) + 1;
    end
end

hits = hits/sum(hits);

for col = 1:nsq
    row = col+1;
    for i = 1:twon
        if row > nsq
            row = 1;
        end
        probs(row, col) = probs(row, col) + hits(i);
        row = row + 1;
    end
end


% CHANCES
chvec = [ch1, ch2, ch3];
nextr = [r2, r3, r1];
nextu = [u1, u2, u1];

for i = 1:3
    thisrow = probs(chvec(i),:);
    probs(chvec(i),:) = (6/16)*thisrow;
    thisrow = (1/16)*thisrow;
    probs(go,:) = probs(go,:) + thisrow;
    probs(jail,:) = probs(jail,:) + thisrow;
    probs(c1,:) = probs(c1,:) + thisrow;
    probs(e3,:) = probs(e3,:) + thisrow;
    probs(h2,:) = probs(h2,:) + thisrow;
    probs(r1,:) = probs(r1,:) + thisrow;
    probs(nextr(i),:) = probs(nextr(i),:) + thisrow;
    probs(nextr(i),:) = probs(nextr(i),:) + thisrow;
    probs(nextu(i),:) = probs(nextu(i),:) + thisrow;
    probs(chvec(i)-3,:) = probs(chvec(i)-3,:) + thisrow;
end

% COMUNITY CHESTS
for cc = [cc1, cc2, cc3]    
    thisrow = probs(cc,:);
    probs(cc,:) = (14/16)*thisrow;
    thisrow = (1/16)*thisrow;
    probs(go,:) = probs(go,:) + thisrow;
    probs(jail,:) = probs(jail,:) + thisrow;
end

%G2J
thisrow = probs(g2j,:);
probs(jail,:) = probs(jail,:) + thisrow;
probs(g2j, :) = zeros(1, nsq); 

[S, ~] = eigs(probs,1,1);

[~, I] = sort(S);
for i = 1:k
    fprintf('%s ', squares{I(end-i+1)})
end
disp(' ')
