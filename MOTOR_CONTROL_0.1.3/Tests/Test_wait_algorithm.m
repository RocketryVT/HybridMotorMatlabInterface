% pause on
t = tic;
n = 500;
d = zeros(1,n);
for i = 1:n
    t = toc;
    for j = 1:2
        pause(0.005);
    end
%     java.lang.Thread.sleep(10);
    d(i) = toc - t;
end

mean(d)
std(d)