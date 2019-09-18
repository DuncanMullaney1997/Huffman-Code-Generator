function answer = HuffmanCode(V,P)              % function title
% V = {'40','80','120','160','200','240'};      % values can represent pixel intensities
% P = [.8 .1 .05 .025 .024 .001];               % probability vector for each pixel
Po = sort(P);                                   % order P min to max
P_curr = Po;                                    % set a pointer to Po
i = length(Po);                                 % i starts @ length(Po) = 6
X = zeros(length(Po),length(Po));               % X = the probs @ each tree level
while length(P_curr) >= 3                       % so long as there are >=3 elmnts in Po
    X(i,:) = [P_curr zeros(1,length(Po)-i)];    % last row of X = Po with '0' ...
                                                % ...filling the remaining elements
    P_next = [P_curr(1)+P_curr(2) P_curr(3:i)]; % new P matrix = sum of 1st 2 (lowest)...
                                                % ...then the remaining after
    P_next = sort(P_next);                      % order this new P matrix
    i = i - 1;                                  % move i to next row up (e.g. 6 -> 5)
    P_curr = P_next;                            % assign current P mat to the...
                                                % ...one we've just calculated
end                                             % exit loop (have X now!)

                                                % need to now define last (or first!)...
                                                % ...few rows of X

P_final = P_curr(1) + P_curr(2);                % last P (=1) is sum of only 2 remaining P's
X(2,:) = [P_curr zeros(1,length(Po)-2)];        % 2nd row X = 2 remaing P's and zeros
X(1,:) = [P_final zeros(1,length(Po)-1)];       % 1st row X = 1 (certainty !)
U = X(2:length(Po),1:2);                        % define U as matrix of lowest probs...
                                                % ...and their sums each time
bits = {};                                      % preallocate the bits matrix (=size(U))
bits(1,1) = {'0'};                              % define bits(1,1) as 1st left branch (0)
bits(1,2) = {'1'};                              % define bits(1,2) as 1st right branch (1)
k = 2;                                          % vars needed for bit encoding
l = 1;                                          % "
while k <= length(U)                            % k starts on 2 b/c we have already...
                                                % ...defined row 1 of bits
    if U(k,1) + U(k,2) == U(l,1)                % check if entries sum to left-above
        bits(k,1) = strcat(bits(l,1),'0');      % if yes, assign children L(0) & R(1) by...
        bits(k,2) = strcat(bits(l,1),'1');      % ...concatenating with respective parent
        k = k + 1;                              % k increases row reference
        l = k - 1;                              % l refers to row just above k, so...
                                                % ...is always one less (reference row)
    elseif U(k,1) + U(k,2) == U(l,2)            % executes same procedure, but...
                                                % ...treats the above-RIGHT as parent
        bits(k,1) = strcat(bits(l,2),'0');      % "
        bits(k,2) = strcat(bits(l,2),'1');      % "
        k = k + 1;                              % "
        l = k - 1;                              % "
    else                                        % otherwise, if not equal to either...
                                                % indicates that sum must
                                                % exist above the above row
                                                % (indicates same tree
                                                % level but...
                                                % different branch pair)
        l = l - 1;                              % l set to reference row above row above
                                                % loop is re-run with k and
                                                % l values
    end
end

answer = {};                                    % preallocate final answers
answer(1,:) = V;                                % first row is the values in V
answer(2,:) = num2cell(P);                      % 2nd row is the respective
                                                % (and unorganised) probs
for p = 1:numel(U)                              % going through each U index
    for q = 1:numel(P)                          % " each P index "
        if U(p) == P(q)                         % if equal
            P(q) = 1;                           % scratch out the prob as used
            answer(3,q) = bits(p);              % put corresponding code from bits in
            U(p) = -1;                          % scratch corresponding prob off in U matrix
        end
    end
end
disp(answer);
end